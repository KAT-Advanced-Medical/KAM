#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut
 * Serializes the medical state of a unit into a string.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Serialized state as JSON string <STRING>
 *
 * Example:
 * [player] call ace_medical_fnc_serializeState
 *
 * Public: Yes
 */
params [["_unit", objNull, [objNull]]];

private _state = [] call CBA_fnc_createNamespace;

// For variables, see: EFUNC(medical_status,initUnit)
{
    _x params ["_var"];
    _state setVariable [_var, _unit getVariable _x];
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
[VAR_VASOCONSTRICTION, 1],
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
[QEGVAR(breathing,pneumothoraxSurfaceArea), [0, 0]],
[QEGVAR(breathing,hemopneumothorax), [false, false]],
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
[QEGVAR(circulation,testedBloodGas), [0,0,0,0,0,0]],
[QEGVAR(circulation,ABGmenuShow), false],
[QEGVAR(circulation,ht), []],
[QEGVAR(circulation,effusion), 0],
[QEGVAR(circulation,attachedLucas), false],
[QEGVAR(circulation,attachedLucasState), false],
[QEGVAR(ophthalmology,dustInjuryLight), 0],
[QEGVAR(ophthalmology,dustInjuryHeavy), 0],
[QEGVAR(ophthalmology,eyeInjuries), [1,1]],
[QEGVAR(ophthalmology,eyeInjurySevere), false],


[QEGVAR(pharma,alphaAction), 1],

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

// Convert medications time to offset
private _medications = _unit getVariable [VAR_MEDICATIONS, []];
{
    _x set [1, _x#1 - CBA_missionTime];
} forEach _medications;
_state setVariable [VAR_MEDICATIONS, _medications];

// Medical statemachine state
private _currentState = [_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState;
_state setVariable [QACEGVAR(medical,statemachineState), _currentState];

// Serialize & return
private _json = [_state] call CBA_fnc_encodeJSON;
_state call CBA_fnc_deleteNamespace;
_json