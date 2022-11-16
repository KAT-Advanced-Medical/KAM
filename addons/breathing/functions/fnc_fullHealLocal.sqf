#include "script_component.hpp"
/*
 * Author: Glowbal
 * Edit: Tomcat --> added heal of airway damage
 * Local callback for fully healing a patient. 
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_treatment_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_unit"];
TRACE_1("fullHealLocal",_unit);

if (!alive _unit) exitWith {};

// check if on fire, then put out the fire before healing
if ((["ace_fire"] call ace_common_fnc_isModLoaded) && {[_unit] call ace_fire_fnc_isBurning}) then {
    _unit setVariable ["ace_fire_intensity", 0, true];
};

private _state = [_unit, ace_medical_STATE_MACHINE] call CBA_statemachine_fnc_getCurrentState;
TRACE_1("start",_state);

// Treatment conditions would normally limit full heal to non-unconscious units
// However, this may be called externally (through Zeus)
if (_unit getVariable ["ace_medical_inCardiacArrest", false]) then {
    TRACE_1("Exiting cardiac arrest",_unit);
    ["ace_medical_CPRSucceeded", _unit] call CBA_fnc_localEvent;
    _state = [_unit, ace_medical_STATE_MACHINE] call CBA_statemachine_fnc_getCurrentState;
    TRACE_1("after CPRSucceeded",_state);
};

_unit setVariable ["ace_medical_pain", 0, true];
_unit setVariable ["ace_medical_bloodVolume", 6.0, true];

// Tourniquets
{
    if (_x != 0) then {
        [_unit, "ACE_tourniquet"] call ace_common_fnc_addToInventory;
    };
} forEach (_unit getVariable ["ace_medical_tourniquets", [0,0,0,0,0,0]]);
_unit setVariable ["ace_medical_tourniquets", [0,0,0,0,0,0], true];
_unit setVariable ["ace_medical_treatment_occludedMedications", nil, true];

// Wounds and Injuries
_unit setVariable ["ace_medical_openWounds", [], true];
_unit setVariable ["ace_medical_bandagedWounds", [], true];
_unit setVariable ["ace_medical_stitchedWounds", [], true];
_unit setVariable ["ace_medical_isLimping", false, true];
_unit setVariable ["ace_medical_fractures", [0,0,0,0,0,0], true];

//KAT Airway
_unit setVariable [QEGVAR(airway,occluded), false, true];
_unit setVariable [QEGVAR(airway,obstruction), false, true];
_unit setVariable [QEGVAR(airway,recovery), false, true];
_unit setVariable [QEGVAR(airway,overstretch), false, true];

//KAT Breathing
_unit setVariable [QGVAR(airwayStatus), 100, true];
_unit setVariable [QGVAR(pneumothorax), false, true];
_unit setVariable [QGVAR(hemopneumothorax), false, true];
_unit setVariable [QGVAR(tensionpneumothorax), false, true];

// Update wound bleeding
[_unit] call ace_medical_status_fnc_updateWoundBloodLoss;

// Vitals
_unit setVariable ["ace_medical_heartRate", 80, true];
_unit setVariable ["ace_medical_bloodPressure", [80, 120], true];
_unit setVariable ["ace_medical_peripheralResistance", 100, true];

//KAT Pharmacy
_unit setVariable ["ace_medical_ivBags", nil, true];
_unit setVariable [QEGVAR(pharma,alphaAction), 1, true];
_unit setVariable [QEGVAR(pharma,IV), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(pharma,IVpfh), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(pharma,active), false, true];
_unit setVariable [QEGVAR(pharma,IVPharma_PFH), nil, true];
_unit setVariable [QEGVAR(pharma,pH), 1500, true];
_unit setVariable [QEGVAR(pharma,kidneyFail), false, true];
_unit setVariable [QEGVAR(pharma,kidneyArrest), false, true];
_unit setVariable [QEGVAR(pharma,kidneyPressure), false, true];
_unit setVariable [QEGVAR(pharma,coagulationFactor), 10, true];

//KAT Surgery

_unit setVariable [QEGVAR(surgery,debridement), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(surgery,fractures), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(surgery,lidocaine), false, true];
_unit setVariable [QEGVAR(surgery,etomidate), false, true];
_unit setVariable [QEGVAR(surgery,sedated), false, true];

// Damage storage
_unit setVariable ["ace_medical_bodyPartDamage", [0,0,0,0,0,0], true];

// wakeup needs to be done after achieving stable vitals, but before manually reseting unconc var
if (_unit getVariable ["ACE_isUnconscious", false]) then {
    if (!([_unit] call ace_medical_status_fnc_hasStableVitals)) then { ERROR_2("fullheal [unit %1][state %2] did not restore stable vitals",_unit,_state); };
    TRACE_1("Waking up",_unit);
    ["ace_medical_WakeUp", _unit] call CBA_fnc_localEvent;
    _state = [_unit, ace_medical_STATE_MACHINE] call CBA_statemachine_fnc_getCurrentState;
    TRACE_1("after WakeUp",_state);
    if (_unit getVariable ["ACE_isUnconscious", false]) then { ERROR_2("fullheal [unit %1][state %2] failed to wake up patient",_unit,_state); };
};

// Generic medical admin
// _unit setVariable [VAR_CRDC_ARRST, false, true]; // this should be set by statemachine transition
// _unit setVariable [VAR_UNCON, false, true]; // this should be set by statemachine transition
_unit setVariable ["ace_medical_hemorrhage", 0, true];
_unit setVariable ["ace_medical_inPain", false, true];
_unit setVariable ["ace_medical_painSuppress", 0, true];

// Medication
_unit setVariable ["ace_medical_medications", [], true];
_unit setVariable ["kat_pharma_ondUse", false, true];
_unit setVariable [QEGVAR(circulation,asystole), 0, true];
_unit setVariable [QEGVAR(circulation,CPRcount), 2, true];

// Reset triage card since medication is reset
_unit setVariable ["ace_medical_triageCard", [], true];

[_unit] call ace_medical_engine_fnc_updateDamageEffects;

// Reset damage
_unit setDamage 0;

["ace_medical_FullHeal", _unit] call CBA_fnc_localEvent;
_state = [_unit, ace_medical_STATE_MACHINE] call CBA_statemachine_fnc_getCurrentState;
TRACE_1("after FullHeal",_state);
