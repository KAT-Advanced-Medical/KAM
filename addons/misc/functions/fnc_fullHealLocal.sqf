#include "..\script_component.hpp"
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
if ((["ace_fire"] call ACEFUNC(common,isModLoaded)) && {[_unit] call ACEFUNC(fire,isBurning)}) then {
    _unit setVariable [QACEGVAR(fire,intensity), 0, true];
};

private _state = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
TRACE_1("start",_state);

// Treatment conditions would normally limit full heal to non-unconscious units
// However, this may be called externally (through Zeus)
if (_unit getVariable [QACEGVAR(medical,inCardiacArrest), false]) then {
    TRACE_1("Exiting cardiac arrest",_unit);
    [QACEGVAR(medical,CPRSucceeded), _unit] call CBA_fnc_localEvent;
    _state = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
    TRACE_1("after CPRSucceeded",_state);
};

_unit setVariable [QACEGVAR(medical,pain), 0, true];
_unit setVariable [QACEGVAR(medical,bloodVolume), 6.0, true];

// GAS
_unit setVariable [QEGVAR(chemical,enteredPoison), false, true];
_unit setVariable [QEGVAR(chemical,airPoisoning), false, true];
_unit setVariable [QEGVAR(chemical,isTreated) ,true,true];
_unit setVariable [QEGVAR(chemical,CS), false, true];
_unit setVariable [QEGVAR(chemical,timeleft), missionNamespace getVariable [QEGVAR(chemical,infectionTime), 60], true];
if (_unit getVariable [QEGVAR(chemical,painEffect), 0] != 0) then {
    KAT_PAIN_EFFECT ppEffectEnable false;
};

// Tourniquets
{
    if (_x != 0) then {
        [_unit, "ACE_tourniquet"] call ACEFUNC(common,addToInventory);
    };
} forEach (_unit getVariable [QACEGVAR(medical,tourniquets), [0,0,0,0,0,0]]);
_unit setVariable [QACEGVAR(medical,tourniquets), [0,0,0,0,0,0], true];
_unit setVariable [QACEGVAR(medical_treatment,occludedMedications), nil, true];

// Wounds and Injuries
_unit setVariable [VAR_OPEN_WOUNDS, createHashMap, true];
_unit setVariable [VAR_BANDAGED_WOUNDS, createHashMap, true];
_unit setVariable [VAR_STITCHED_WOUNDS, createHashMap, true];
_unit setVariable [QACEGVAR(medical,isLimping), false, true];
_unit setVariable [QACEGVAR(medical,fractures), [0,0,0,0,0,0], true];

//KAT Airway
_unit setVariable [QEGVAR(airway,occluded), false, true];
_unit setVariable [QEGVAR(airway,wasOccluded), false];
_unit setVariable [QEGVAR(airway,obstruction), false, true];
_unit setVariable [QEGVAR(airway,recovery), false, true];
_unit setVariable [QEGVAR(airway,overstretch), false, true];
_unit setVariable [QEGVAR(airway,clearedTime), 0, true];

//KAT Breathing
_unit setVariable [QEGVAR(breathing,airwayStatus), 100, true];
_unit setVariable [QEGVAR(breathing,pneumothorax), 0, true];
_unit setVariable [QEGVAR(breathing,hemopneumothorax), false, true];
_unit setVariable [QEGVAR(breathing,tensionpneumothorax), false, true];
_unit setVariable [QEGVAR(breathing,activeChestSeal), false, true];
_unit setVariable [QEGVAR(breathing,deepPenetratingInjury), false, true];

// KAT Circulation
_unit setVariable [QEGVAR(circulation,cprCount), 2, true];
_unit setVariable [QEGVAR(circulation,heartRestart), false, true];
_unit setVariable [QEGVAR(circulation,cardiacArrestType), 0, true];

_unit setVariable [QEGVAR(circulation,ht), [], true];
_unit setVariable [QEGVAR(circulation,effusion), 0, true];
_unit setVariable [VAR_BLOODPRESSURE_CHANGE, nil, true];

_unit setVariable [QEGVAR(circulation,isPerformingCPR), false, true];
_unit setVariable [QEGVAR(circulation,OxygenationPeriod), 0, true];


// Update wound bleeding
[_unit] call ACEFUNC(medical_status,updateWoundBloodLoss);
[_unit] call EFUNC(circulation,updateInternalBleeding);

// Vitals
_unit setVariable [QACEGVAR(medical,heartRate), 80, true];
_unit setVariable [QACEGVAR(medical,bloodPressure), [80, 120], true];
_unit setVariable [QACEGVAR(medical,peripheralResistance), 100, true];

//KAT Pharmacy
_unit setVariable [QACEGVAR(medical,ivBags), nil, true];
_unit setVariable [QEGVAR(pharma,alphaAction), 1, true];
_unit setVariable [QEGVAR(pharma,opioidFactor), 1, true];
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

_unit setVariable [QEGVAR(surgery,fractures), [0,0,0,0,0,0], true];
_unit setVariable [QEGVAR(surgery,lidocaine), false, true];
_unit setVariable [QEGVAR(surgery,etomidate), false, true];
_unit setVariable [QEGVAR(surgery,sedated), false, true];
_unit setVariable [QEGVAR(surgery,imaging), false, true];
_unit setVariable [QEGVAR(surgery,reboa), false, true];
_unit setVariable [QEGVAR(surgery,surgicalBlock), [0,0,0,0,0,0], true];

// KAT Misc
_unit setVariable [QGVAR(Tourniquet_ArmNecrosis), 0];
_unit setVariable [QGVAR(Tourniquet_LegNecrosis), 0];
_unit setVariable [QGVAR(Tourniquet_PFH), -1];
_unit setVariable [QGVAR(Tourniquet_LegNecrosis_Threshold), 0, true];

// Damage storage
_unit setVariable [QACEGVAR(medical,bodyPartDamage), [0,0,0,0,0,0], true];

// wakeup needs to be done after achieving stable vitals, but before manually reseting unconc var
if (_unit getVariable ["ACE_isUnconscious", false]) then {
    if (!([_unit] call FUNC(hasStableVitals))) then { ERROR_2("fullheal [unit %1][state %2] did not restore stable vitals",_unit,_state); };
    TRACE_1("Waking up",_unit);
    [QACEGVAR(medical,WakeUp), _unit] call CBA_fnc_localEvent;
    _state = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
    TRACE_1("after WakeUp",_state);
    if (_unit getVariable ["ACE_isUnconscious", false]) then { ERROR_2("fullheal [unit %1][state %2] failed to wake up patient",_unit,_state); };
};

// Generic medical admin
// _unit setVariable [VAR_CRDC_ARRST, false, true]; // this should be set by statemachine transition
// _unit setVariable [VAR_UNCON, false, true]; // this should be set by statemachine transition
_unit setVariable [QACEGVAR(medical,hemorrhage), 0, true];
_unit setVariable [QACEGVAR(medical,inPain), false, true];
_unit setVariable [QACEGVAR(medical,painSuppress), 0, true];

// Medication
_unit setVariable [QACEGVAR(medical,medications), [], true];

// Reset triage card since medication is reset
_unit setVariable [QACEGVAR(medical,triageCard), [], true];

[_unit] call ACEFUNC(medical_engine,updateDamageEffects);

// Reset damage
_unit setDamage 0;

[QACEGVAR(medical,FullHeal), _unit] call CBA_fnc_localEvent;
_state = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
TRACE_1("after FullHeal",_state);

/// Clear Stamina & weapon sway
if (ACEGVAR(advanced_fatigue,enabled)) then {
    ["kat_LSDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
    ["kat_PDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
    ["kat_EDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
    // ACEGVAR(advanced_fatigue,swayFactor) = EGVAR(pharma,originalSwayFactor); // TODO REWORK OR REMOVE
} else {
    _unit setAnimSpeedCoef 1;
    _unit setCustomAimCoef 1;

    if (GVAR(staminaMedication)) then {
        _unit enableStamina true;

    };
};

/// Clear chroma effect & camera shake
if (hasInterface) then {
    resetCamShake;
    ["ChromAberration", 200, [ 0, 0, true ]] spawn
    {
        params["_name", "_priority", "_effect", "_handle"];
        while
        {
            _handle = ppEffectCreate[_name, _priority];
            _handle < 0
        }
        do
        {
            _priority = _priority + 1;
        };
        _handle ppEffectEnable true;
        _handle ppEffectAdjust _effect;
        _handle ppEffectCommit 0;
        [
            {
                params["_handle"];
                ppEffectCommitted _handle
            },
            {
                params["_handle"];
                _handle ppEffectEnable false;
                ppEffectDestroy _handle;
            },
        [_handle]] call CBA_fnc_waitUntilAndExecute;
    };
};

// Reenable ace fatige animationspeed override

if (!isNil QACEGVAR(advanced_fatigue,setAnimExclusions)) then {
    _index = ACEGVAR(advanced_fatigue,setAnimExclusions) find "PervitinOverride";
    if (_index != -1) then {
        ACEGVAR(advanced_fatigue,setAnimExclusions) deleteAt _index;
    };
};
