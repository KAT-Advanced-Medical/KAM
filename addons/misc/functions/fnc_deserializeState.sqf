#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut
 * Deserializes the medical state of a unit and applies it.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: State as JSON <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, _json] call ace_medical_fnc_deserializeState
 *
 * Public: Yes
 */
params [["_unit", objNull, [objNull]], ["_json", "{}", [""]]];
// Don't run in scheduled environment
if (canSuspend) exitWith {
    [FUNC(deserializeState), _this] call CBA_fnc_directCall
};
if (isNull _unit) exitWith {
};
if (!local _unit) exitWith { 
    ERROR_1("unit [%1] is not local",_unit) };

// If unit is not initialized yet, wait until event is raised
if !(_unit getVariable [QACEGVAR(medical,initialized), false]) exitWith {
    [QACEGVAR(medical,initialized), {
        params ["_unit"];
        _thisArgs params ["_target"];

        if (_unit == _target) then {
            _thisArgs call FUNC(deserializeState);
            [_thisType, _thisId] call CBA_fnc_removeEventHandler;
        };
    }, _this] call CBA_fnc_addEventHandlerArgs;
};

private _state = [_json] call CBA_fnc_parseJSON;
// Set medical variables
{
    _x params ["_var", "_default"];
    private _value = _state getVariable _x;

    // Handle wound hashmaps deserialized as CBA_namespaces
    if (typeName _value == "LOCATION") then {
        private _keys = allVariables _value;
        private _values = _keys apply {_value getVariable _x};
        _value = _keys createHashMapFromArray _values;
    };

    // Treat null as nil
    if (_value isEqualTo objNull) then {
        _value = _default;
    };

    _unit setVariable [_var, _value, true];
} forEach [
    [VAR_BLOOD_VOL, DEFAULT_BLOOD_VOLUME],
    [VAR_HEART_RATE, DEFAULT_HEART_RATE],
    [VAR_BLOOD_PRESS, [80, 120]],
    [VAR_PERIPH_RES, DEFAULT_PERIPH_RES],
    // State transition should handle this
    // [VAR_CRDC_ARRST, false],
    [VAR_HEMORRHAGE, 0],
    [VAR_PAIN, 0],
    [VAR_IN_PAIN, false],
    [VAR_PAIN_SUPP, 0],
    [VAR_OPEN_WOUNDS, createHashMap],
    [VAR_BANDAGED_WOUNDS, createHashMap],
    [VAR_STITCHED_WOUNDS, createHashMap],
    [VAR_FRACTURES, DEFAULT_FRACTURE_VALUES],
    // State transition should handle this
    // [VAR_UNCON, false],
    [VAR_TOURNIQUET, DEFAULT_TOURNIQUET_VALUES],
    [QACEGVAR(medical,occludedMedications), nil],
    [QACEGVAR(medical,ivBags), nil],
    [QACEGVAR(medical,triageLevel), 0],
    [QACEGVAR(medical,triageCard), []],
    [VAR_BODYPART_DAMAGE, DEFAULT_BODYPART_DAMAGE_VALUES],
    [VAR_WRAPPED_WOUNDS, createHashMap],
[VAR_COAGED_WOUNDS, createHashMap],
[QACEGVAR(medical,isLimping), false],
[VAR_SPO2, DEFAULT_SPO2],
[VAR_OXYGEN_DEMAND, 0],
[VAR_VASOCONSTRICTION, [1,1,1,1,1,1,1,1,1,1,1,1]],
[QEGVAR(airway,airway_item), ""],
[QEGVAR(airway,airway), false],
[QEGVAR(airway,clearedTime), 0],
[QEGVAR(airway,cricothyrotomy), 0],
[QEGVAR(airway,catastrophicAirway), [false, false]],
[QEGVAR(airway,obstruction), [0, 0, 0]],
[QEGVAR(airway,occlusion), [0, 0, 0]],
[QEGVAR(airway,occlusionMitigation), [false, false, false]],
[QEGVAR(airway,overstretch), false],
[QEGVAR(airway,recovery), false],
[QEGVAR(airway,wasOccluded), [0, 0, 0]],
[QEGVAR(airway,hasPuked), false],
[QEGVAR(airway,airwayStatus), [0, 0, 0]],
[QEGVAR(airway,isVisualized), false],
[QEGVAR(breathing,airwayStatus), 100],
[QEGVAR(breathing,pneumothorax), [0, 0]],
[QEGVAR(breathing,hemopneumothorax), [0, 0]],
[QEGVAR(breathing,tensionpneumothorax), [false, false]],
[QEGVAR(breathing,activeChestSeal), [false, false]],
[QEGVAR(breathing,deepPenetratingInjury), [false, false]],
[QEGVAR(breathing,etco2Monitor), []],
[QEGVAR(breathing,breathRate), 15],
[QEGVAR(breathing,nasalCannula), false],
[QEGVAR(breathing,lungSurfaceArea), 400],
[QEGVAR(breathing,chestTube), [0, 0]],
[QEGVAR(breathing,attachedVent), false],
[QEGVAR(breathing,attachedVentGUI), false],
[QEGVAR(breathing,paralysis), 0],
[QEGVAR(breathing,ventRate), 2],
[QEGVAR(breathing,TRALI), 0],
[QEGVAR(circulation,cprCount), 2],
[QEGVAR(circulation,heartRestart), false],
[QEGVAR(circulation,cardiacArrestType), 0],
[QEGVAR(circulation,bodyFluid), DEFAULT_BODY_FLUID],
[QEGVAR(circulation,isPerformingCPR), false],
[QEGVAR(circulation,OxygenationPeriod), 0],
[QEGVAR(circulation,tourniquetTime), [0,0,0,0,0,0,0,0,0,0,0,0]],
[QEGVAR(circulation,defaultHeartRate), 80],
[QEGVAR(circulation,bloodGas), DEFAULT_BLOOD_GAS],
[QEGVAR(circulation,testedBloodGas), [0,0,0,0,0,0,0]],
[QEGVAR(circulation,ABGmenuShow), false],
[QEGVAR(circulation,ht), []],
[QEGVAR(circulation,effusion), 0],
[QEGVAR(circulation,attachedLucas), false],
[QEGVAR(circulation,attachedLucasState), false],
[QEGVAR(ophthalmology,dustInjuryLight), 0],
[QEGVAR(ophthalmology,dustInjuryHeavy), 0],
[QEGVAR(ophthalmology,eyeInjuries), [1,1]],
[QEGVAR(ophthalmology,eyeInjurySevere), false],


[QEGVAR(pharma,alphaAction), [1,1,1,1,1,1,1,1,1,1,1,1]],

[QEGVAR(pharma,IV), [0,0,0,0,0,0,0,0,0,0,0,0]],
[QEGVAR(pharma,IVflow), [0,0,0,0,0,0,0,0,0,0,0,0]],
[QEGVAR(pharma,IVrate), [0,0,0,0,0,0,0,0,0,0,0,0]],

[QEGVAR(pharma,IVincomingFlowAmount), [0,0,0,0,0,0,0,0,0,0,0,0]],
[QEGVAR(pharma,IVpfh), [0,0,0,0,0,0,0,0,0,0,0,0]],
[QEGVAR(pharma,active), false],
[QEGVAR(pharma,IVPharma_PFH), 0],
[QEGVAR(pharma,IVmenuActive), false],

[QEGVAR(pharma,externalPh), 0],
[QEGVAR(pharma,pH), 0],

[QEGVAR(pharma,opioidFactor), 0],
[QEGVAR(pharma,opioidDepression), 0],

[QEGVAR(pharma,kidneyFail), false],
[QEGVAR(pharma,kidneyArrest), false],
[QEGVAR(pharma,kidneyPressure), false],

[QEGVAR(pharma,respiratoryRate), 1],
[QEGVAR(pharma,heartContractility), 1],
[QEGVAR(pharma,nauseaMult), 1],

[VAR_LOCAL_ANESTHESIA, DEFAULT_LOCAL_ANESTHESIA],
[QEGVAR(pharma,activeEtomidateLoadingDose), false],
[QEGVAR(surgery,fractures), [0,0,0,0,0,0,0,0,0,0,0,0]],
[QEGVAR(surgery,lidocaine), false],
[QEGVAR(surgery,etomidate), false],
[QEGVAR(surgery,sedated), 0],
[QEGVAR(surgery,imaging), false],
[QEGVAR(surgery,reboa), false],
[QEGVAR(surgery,surgicalBlock), [0,0,0,0,0,0,0,0,0,0,0,0]],
[QEGVAR(vitals,respiratoryDepth), DEFAULT_RESPIRATORY_DEPTH],
[QEGVAR(vitals,currentWeight), 80]

];

// Reset timers
_unit setVariable [QACEGVAR(medical,lastWakeUpCheck), nil];

// Convert medications offset to time
private _medications = _state getVariable [VAR_MEDICATIONS, []];
{
    _x set [1, _x#1 + CBA_missionTime];
} forEach _medications;
_unit setVariable [VAR_MEDICATIONS, _medications, true];

// Update effects
[_unit] call FUNC(updateDamageEffects);
[_unit] call EFUNC(circulation,updateWoundBloodLoss);

// Transition within statemachine
private _currentState = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
private _targetState = _state getVariable [QGVAR(statemachineState), "Default"];
[_unit, ACEGVAR(medical,STATE_MACHINE), _currentState, _targetState] call CBA_statemachine_fnc_manualTransition;

// Manually call wake up tranisition if necessary
if (_currentState in ["Unconscious", "CardiacArrest"] && {_targetState in ["Default", "Injured"]}) then {
    [_unit, false] call ACEFUNC(medical_status,setUnconsciousState);
};

_state call CBA_fnc_deleteNamespace;