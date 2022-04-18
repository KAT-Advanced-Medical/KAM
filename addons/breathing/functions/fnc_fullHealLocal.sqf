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

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

if (!alive _patient) exitWith {};

// check if on fire, then put out the fire before healing
if ((["ace_fire"] call ace_common_fnc_isModLoaded) && {[_patient] call ace_fire_fnc_isBurning}) then {
    _patient setVariable ["ace_fire_intensity", 0, true];
};

private _state = [_patient, ace_medical_STATE_MACHINE] call CBA_statemachine_fnc_getCurrentState;
TRACE_1("start",_state);

// Treatment conditions would normally limit full heal to non-unconscious units
// However, this may be called externally (through Zeus)
if (_patient getVariable ["ace_medical_inCardiacArrest", false]) then {
    TRACE_1("Exiting cardiac arrest",_patient);
    ["ace_medical_CPRSucceeded", _patient] call CBA_fnc_localEvent;
    _state = [_patient, ace_medical_STATE_MACHINE] call CBA_statemachine_fnc_getCurrentState;
    TRACE_1("after CPRSucceeded",_state);
};

_patient setVariable ["ace_medical_pain", 0, true];
_patient setVariable ["ace_medical_bloodVolume", 6.0, true];

// Tourniquets
{
    if (_x != 0) then {
        [_patient, "ACE_tourniquet"] call ace_common_fnc_addToInventory;
    };
} forEach (_patient getVariable ["ace_medical_tourniquets", [0,0,0,0,0,0]]);
_patient setVariable ["ace_medical_tourniquets", [0,0,0,0,0,0], true];
_patient setVariable ["ace_medical_treatment_occludedMedications", nil, true];

// Wounds and Injuries
_patient setVariable ["ace_medical_openWounds", [], true];
_patient setVariable ["ace_medical_bandagedWounds", [], true];
_patient setVariable ["ace_medical_stitchedWounds", [], true];
_patient setVariable ["ace_medical_isLimping", false, true];
_patient setVariable ["ace_medical_fractures", [0,0,0,0,0,0], true];
_patient setVariable ["KAT_medical_airwayStatus", 100, true];
_patient setVariable ["KAT_medical_airwayOccluded", false, true];
_patient setVariable ["KAT_medical_pneumothorax", false, true];
_patient setVariable ["KAT_medical_hemopneumothorax", false, true];
_patient setVariable ["KAT_medical_tensionpneumothorax", false, true];

// Update wound bleeding
[_patient] call ace_medical_status_fnc_updateWoundBloodLoss;

// Vitals
_patient setVariable ["ace_medical_heartRate", 80, true];
_patient setVariable ["ace_medical_bloodPressure", [80, 120], true];
_patient setVariable ["ace_medical_peripheralResistance", 100, true];

// IVs
_patient setVariable ["ace_medical_ivBags", nil, true];
_unit setVariable [QGVAR(flowRate), 1, true];
_unit setVariable [QGVAR(IVplaced), false, true];
_unit setVariable [QGVAR(usedIV), "", true];
_unit setVariable [QGVAR(IV_counts), 0, true];
_unit setVariable [QGVAR(IVsite), 0, true];

// Damage storage
_patient setVariable ["ace_medical_bodyPartDamage", [0,0,0,0,0,0], true];

// wakeup needs to be done after achieving stable vitals, but before manually reseting unconc var
if (_patient getVariable ["ACE_isUnconscious", false]) then {
    if (!([_patient] call ace_medical_status_fnc_hasStableVitals)) then { ERROR_2("fullheal [unit %1][state %2] did not restore stable vitals",_patient,_state); };
    TRACE_1("Waking up",_patient);
    ["ace_medical_WakeUp", _patient] call CBA_fnc_localEvent;
    _state = [_patient, ace_medical_STATE_MACHINE] call CBA_statemachine_fnc_getCurrentState;
    TRACE_1("after WakeUp",_state);
    if (_patient getVariable ["ACE_isUnconscious", false]) then { ERROR_2("fullheal [unit %1][state %2] failed to wake up patient",_patient,_state); };
};

// Generic medical admin
// _patient setVariable [VAR_CRDC_ARRST, false, true]; // this should be set by statemachine transition
// _patient setVariable [VAR_UNCON, false, true]; // this should be set by statemachine transition
_patient setVariable ["ace_medical_hemorrhage", 0, true];
_patient setVariable ["ace_medical_inPain", false, true];
_patient setVariable ["ace_medical_painSuppress", 0, true];

// Medication
_patient setVariable ["ace_medical_medications", [], true];
_unit setVariable [QGVAR(ondUse), false, true];
_unit setVariable [QGVAR(asystole), 0, true];
_unit setVariable [QGVAR(CPRcount), 2, true];

// Reset triage card since medication is reset
_patient setVariable ["ace_medical_triageCard", [], true];

[_patient] call ace_medical_engine_fnc_updateDamageEffects;

// Reset damage
_patient setDamage 0;

["ace_medical_FullHeal", _patient] call CBA_fnc_localEvent;
_state = [_patient, ace_medical_STATE_MACHINE] call CBA_statemachine_fnc_getCurrentState;
TRACE_1("after FullHeal",_state);
