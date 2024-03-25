#include "..\script_component.hpp"
/*
 * Author: Glowbal, mharis001
 * Modified: MiszczuZPolski, Blue, Mazinski
 * Local callback for administering medication to a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 * 2: Treatment <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "RightArm", "Morphine"] call kat_pharma_fnc_medicationLocal
 *
 * Public: No
 */

// todo: move this macro to script_macros_medical.hpp?
#define MORPHINE_PAIN_SUPPRESSION 0.6

params ["_patient", "_bodyPart", "_classname"];
TRACE_3("medicationLocal",_patient,_bodyPart,_classname);

// Medication has no effects on dead units
if (!alive _patient) exitWith {};

// Exit with basic medication handling if advanced medication not enabled
if !(ACEGVAR(medical_treatment,advancedMedication)) exitWith {
    switch (_classname) do {
        case "Morphine": {
            private _painSuppress = GET_PAIN_SUPPRESS(_patient);
            _patient setVariable [VAR_PAIN_SUPP, (_painSuppress + MORPHINE_PAIN_SUPPRESSION) min 1, true];
        };
        case "Epinephrine": {
            private _sedated = _patient getVariable [QEGVAR(surgery,sedated), false];
            if !(_sedated) then {
                [QACEGVAR(medical,WakeUp), _patient] call CBA_fnc_localEvent;
            };

            [_patient, -0.15] call FUNC(alphaAction);
        };
    };
};
TRACE_1("Running treatmentMedicationLocal with Advanced configuration for",_patient);

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;

// Handle IV blockage
if (((_patient getVariable [QGVAR(IV), [0,0,0,0,0,0]]) select _partIndex) isEqualTo 3) exitWith {
    private _occludedMedications = _patient getVariable [QACEGVAR(medical,occludedMedications), []];
    _occludedMedications pushBack [_partIndex, _classname];
    _patient setVariable [QACEGVAR(medical,occludedMedications), _occludedMedications, true];
};

// Handle tourniquet on body part blocking blood flow at injection site
if (HAS_TOURNIQUET_APPLIED_ON(_patient,_partIndex)) exitWith {
    TRACE_1("unit has tourniquets blocking blood flow on injection site",_tourniquets);
    private _occludedMedications = _patient getVariable [QACEGVAR(medical,occludedMedications), []];
    _occludedMedications pushBack [_partIndex, _classname];
    _patient setVariable [QACEGVAR(medical,occludedMedications), _occludedMedications, true];
};

// Get adjustment attributes for used medication
private _defaultConfig = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "Medication";
private _medicationConfig = _defaultConfig >> _classname;

private _painReduce             = GET_NUMBER(_medicationConfig >> "painReduce",getNumber (_defaultConfig >> "painReduce"));
private _timeInSystem           = GET_NUMBER(_medicationConfig >> "timeInSystem",getNumber (_defaultConfig >> "timeInSystem"));
private _timeTillMaxEffect      = GET_NUMBER(_medicationConfig >> "timeTillMaxEffect",getNumber (_defaultConfig >> "timeTillMaxEffect"));
private _maxDose                = GET_NUMBER(_medicationConfig >> "maxDose",getNumber (_defaultConfig >> "maxDose"));
private _viscosityChange        = GET_NUMBER(_medicationConfig >> "viscosityChange",getNumber (_defaultConfig >> "viscosityChange"));
private _hrIncreaseLow          = GET_ARRAY(_medicationConfig >> "hrIncreaseLow",getArray (_defaultConfig >> "hrIncreaseLow"));
private _hrIncreaseNormal       = GET_ARRAY(_medicationConfig >> "hrIncreaseNormal",getArray (_defaultConfig >> "hrIncreaseNormal"));
private _hrIncreaseHigh         = GET_ARRAY(_medicationConfig >> "hrIncreaseHigh",getArray (_defaultConfig >> "hrIncreaseHigh"));
private _incompatibleMedication = GET_ARRAY(_medicationConfig >> "incompatibleMedication",getArray (_defaultConfig >> "incompatibleMedication"));
private _alphaFactor            = GET_NUMBER(_medicationConfig >> "alphaFactor",getNumber (_defaultConfig >> "alphaFactor"));
private _maxRelief              = GET_NUMBER(_medicationConfig >> "maxRelief",getNumber (_defaultConfig >> "maxRelief"));
private _opioidRelief           = GET_NUMBER(_medicationConfig >> "opioidRelief",getNumber (_defaultConfig >> "opioidRelief"));

private _heartRate = GET_HEART_RATE(_patient);
private _hrIncrease = [_hrIncreaseLow, _hrIncreaseNormal, _hrIncreaseHigh] select (floor ((0 max _heartRate min 110) / 55));
_hrIncrease params ["_minIncrease", "_maxIncrease"];
private _heartRateChange = _minIncrease + random (_maxIncrease - _minIncrease);

private _presentPain = GET_PAIN(_patient);
private _presentReduce = 0;
if (_maxRelief > 0) then {
    if (_presentPain > _maxRelief) then {
        _painReduce = _painReduce / 4;
    };
};

// Adjust the medication effects and add the medication to the list
TRACE_3("adjustments",_heartRateChange,_painReduce,_viscosityChange);
[_patient, _className, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange] call ACEFUNC(medical_status,addMedicationAdjustment);

// Check for medication compatiblity
[_patient, _className, _maxDose, _incompatibleMedication] call ACEFUNC(medical_treatment,onMedicationUsage);

//Change Alpha Factor
[_patient, _alphaFactor] call FUNC(alphaAction);

if (_className in ["Lorazepam","Ketamine","EACA","TXA","Atropine","Amiodarone","Flumazenil"]) then {
    [format ["kat_pharma_%1Local", toLower _className], [_patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
};

if (_className in ["Fentanyl","Morphine","Nalbuphine"]) then {
    [format ["kat_pharma_%1Local", toLower _className], [_patient, _bodyPart, _opioidRelief], _patient] call CBA_fnc_targetEvent;
};