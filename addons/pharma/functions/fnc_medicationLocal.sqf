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
// 0.2625 = 0.6/0.8 * 0.35
// 0.6 = basic medication morph. pain suppr., 0.8 = adv. medication morph. pain suppr., 0.35 = adv. medication painkillers. pain suppr.
#define PAINKILLERS_PAIN_SUPPRESSION 0.2625

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
        };
        case "EpinephrineIV": {
            private _sedated = _patient getVariable [QEGVAR(surgery,sedated), false];
            if !(_sedated) then {
                [QACEGVAR(medical,WakeUp), _patient] call CBA_fnc_localEvent;
            };
        };
        case "Painkillers": {
            private _painSuppress = GET_PAIN_SUPPRESS(_patient);
            _patient setVariable [VAR_PAIN_SUPP, (_painSuppress + PAINKILLERS_PAIN_SUPPRESSION) min 1, true];
        };
    };
};
TRACE_1("Running treatmentMedicationLocal with Advanced configuration for",_patient);

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;

// Handle IV blockage
if ([7,8,9] find (_IVarray select _partIndex) == -1) exitWith {
    private _occludedMedications = _patient getVariable [QACEGVAR(medical,occludedMedications), []];
    _occludedMedications pushBack [_partIndex, _classname];
    _patient setVariable [QACEGVAR(medical,occludedMedications), _occludedMedications, true];
};
private _tourniquets = GET_TOURNIQUETS(_unit);
private _occlusionMap = [
    [4, [4, 5]],
    [5, [5]],
    [6, [6, 7]],
    [7, [7]],
    [8, [8, 9, 3]],
    [9, [9, 3]],
    [10, [10, 11, 3]],
    [11, [11, 3]]
];

private _occlusionMap = [
    [4, [4, 5]],
    [5, [5]],
    [6, [6, 7]],
    [7, [7]],
    [8, [8, 9, 3]],
    [9, [9, 3]],
    [10, [10, 11, 3]],
    [11, [11, 3]]
];

private _tourniquets = GET_TOURNIQUETS(_patient);
private _idx = _occlusionMap findIf { _x#0 == _partIndex };
private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
private _isOccluded = { _tourniquets select _x != 0 } count _result > 0;
if (_isNotOccluded) exitWith {
    TRACE_1("Medication injection site is occluded by tourniquet", _partIndex);
    
    private _occludedMedications = _patient getVariable [QACEGVAR(medical,occludedMedications), []];
    _occludedMedications pushBack [_partIndex, _classname];
    _patient setVariable [QACEGVAR(medical,occludedMedications), _occludedMedications, true];
};

// Get adjustment attributes for used medication
private _defaultConfig = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "Medication";
private _medicationConfig = _defaultConfig >> _classname;

// Get and calculate medication modifiers
if (GVAR(AMS_Enabled)) then {
    _painReduce             = GET_NUMBER(_medicationConfig >> "painReduce",getNumber (_defaultConfig >> "painReduce"));
    _timeInSystem           = GET_NUMBER(_medicationConfig >> "timeInSystem",getNumber (_defaultConfig >> "timeInSystem"));
    _timeTillMaxEffect      = GET_NUMBER(_medicationConfig >> "timeTillMaxEffect",getNumber (_defaultConfig >> "timeTillMaxEffect"));
    _viscosityChange        = GET_NUMBER(_medicationConfig >> "viscosityChange",getNumber (_defaultConfig >> "viscosityChange"));
    _alphaFactor            = GET_NUMBER(_medicationConfig >> "alphaFactor",getNumber (_defaultConfig >> "alphaFactor"));
    _opioidRelief           = GET_NUMBER(_medicationConfig >> "opioidRelief",getNumber (_defaultConfig >> "opioidRelief"));
    _opioidEffect           = GET_NUMBER(_medicationConfig >> "opioidEffect",getNumber (_defaultConfig >> "opioidEffect"));
    _respiratoryRate        = GET_NUMBER(_medicationConfig >> "respiratoryRate",getNumber (_defaultConfig >> "respiratoryRate"));
    _opioidDepression       = GET_NUMBER(_medicationConfig >> "opioidDepression",getNumber (_defaultConfig >> "opioidDepression"));
    _hrIncreaseLow          = GET_ARRAY(_medicationConfig >> "hrIncreaseLow",getArray (_defaultConfig >> "hrIncreaseLow"));
    _hrIncreaseNormal       = GET_ARRAY(_medicationConfig >> "hrIncreaseNormal",getArray (_defaultConfig >> "hrIncreaseNormal"));
    _hrIncreaseHigh         = GET_ARRAY(_medicationConfig >> "hrIncreaseHigh",getArray (_defaultConfig >> "hrIncreaseHigh"));
    _incompatibleMedication = GET_ARRAY(_medicationConfig >> "incompatibleMedication",getArray (_defaultConfig >> "incompatibleMedication"));
    _maxRelief              = GET_NUMBER(_medicationConfig >> "maxRelief",getNumber (_defaultConfig >> "maxRelief"));
    _dose                   = GET_NUMBER(_medicationConfig >> "dose",getNumber (_defaultConfig >> "dose"));

    private _heartRate = GET_HEART_RATE(_patient);
    private _hrIncrease = [_hrIncreaseLow, _hrIncreaseNormal, _hrIncreaseHigh] select (floor ((0 max _heartRate min 110) / 55));
    _hrIncrease params ["_minIncrease", "_maxIncrease"];
    _heartRateChange = _minIncrease + random (_maxIncrease - _minIncrease);

    private _presentPain = GET_PAIN(_patient);
    private _presentReduce = 0;
    if (_maxRelief > 0) then {
        if (_presentPain > _maxRelief) then {
            _painReduce = _painReduce / 4;
        };
    };
    private _medicationParts = (_className splitString "_");
    TRACE_1("ClassName being processed:",_className);
    TRACE_1("SplitString result for _className:",_medicationParts);
    if (count _medicationParts > 3) then {
        private _medicationName = _medicationParts select 1;
        TRACE_6("adjustments1",_patient,_medicationName,_timeTillMaxEffect,_timeInSystem,_heartRateChange,_painReduce);
        TRACE_7("adjustments2",_viscosityChange,_dose,_alphaFactor,_opioidRelief,_opioidEffect,_opioidDepression,_respiratoryRate);
        [_patient, _medicationName, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange, _dose, _alphaFactor, _opioidRelief, _opioidEffect, _opioidDepression, _respiratoryRate] call EFUNC(vitals,addMedicationAdjustment);
        [_patient, _medicationName, _incompatibleMedication] call FUNC(onMedicationUsage);
    } else {
        [_patient, _className, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange, _dose, _alphaFactor, _opioidRelief, _opioidEffect, _opioidDepression, _respiratoryRate] call EFUNC(vitals,addMedicationAdjustment);
        [_patient, _className, _incompatibleMedication] call FUNC(onMedicationUsage);
    };

    if (count _medicationParts > 3) then {
        _medicationName = _medicationParts select 1;
        diag_log _medicationName;
        if ((toUpper (_medicationName select [count _medicationName - 2])) isEqualTo "IV") then {
            _medicationName = _medicationName select [0, count _medicationName - 2];
        };
        if (_medicationName in ["Lorazepam","EACA","TXA","Amiodarone","Flumazenil"]) then {
        [format ["kat_pharma_%1Local", toLower _medicationName], [_patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
        diag_Log format ["kat_pharma_%1Local", toLower _medicationName];
        };

        if (_medicationName in ["Ketamine","Atropine","Adenosine","Alteplase"]) then {
        [format ["kat_pharma_%1Local", toLower _medicationName], [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
        diag_Log format ["kat_pharma_%1Local", toLower _medicationName];
        };

        if (_medicationName in ["Fentanyl","Morphine","Nalbuphine"]) then {
        [format ["kat_pharma_%1Local", toLower _medicationName], [_patient, _bodyPart, _opioidRelief], _patient] call CBA_fnc_targetEvent;
        diag_Log format ["kat_pharma_%1Local", toLower _medicationName];
        };
    } else {
        if (_className in ["Lorazepam","Ketamine","EACA","TXA","Atropine","Amiodarone","Flumazenil"]) then {
        [format ["kat_pharma_%1Local", toLower _className], [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
        };

        if (_className in ["Fentanyl","Morphine","Nalbuphine"]) then {
        [format ["kat_pharma_%1Local", toLower _className], [_patient, _bodyPart, _opioidRelief], _patient] call CBA_fnc_targetEvent;
        };
    };
    
} else {
    _painReduce             = GET_NUMBER(_medicationConfig >> "painReduce",getNumber (_defaultConfig >> "painReduce"));
    _timeInSystem           = GET_NUMBER(_medicationConfig >> "timeInSystem",getNumber (_defaultConfig >> "timeInSystem"));
    _timeTillMaxEffect      = GET_NUMBER(_medicationConfig >> "timeTillMaxEffect",getNumber (_defaultConfig >> "timeTillMaxEffect"));
    _viscosityChange        = GET_NUMBER(_medicationConfig >> "viscosityChange",getNumber (_defaultConfig >> "viscosityChange"));
    _alphaFactor            = GET_NUMBER(_medicationConfig >> "alphaFactor",getNumber (_defaultConfig >> "alphaFactor"));
    _opioidRelief           = GET_NUMBER(_medicationConfig >> "opioidRelief",getNumber (_defaultConfig >> "opioidRelief"));
    _opioidEffect           = GET_NUMBER(_medicationConfig >> "opioidEffect",getNumber (_defaultConfig >> "opioidEffect"));
    _respiratoryRate        = GET_NUMBER(_medicationConfig >> "respiratoryRate",getNumber (_defaultConfig >> "respiratoryRate"));
    _opioidDepression       = GET_NUMBER(_medicationConfig >> "opioidDepression",getNumber (_defaultConfig >> "opioidDepression"));
    _hrIncreaseLow          = GET_ARRAY(_medicationConfig >> "hrIncreaseLow",getArray (_defaultConfig >> "hrIncreaseLow"));
    _hrIncreaseNormal       = GET_ARRAY(_medicationConfig >> "hrIncreaseNormal",getArray (_defaultConfig >> "hrIncreaseNormal"));
    _hrIncreaseHigh         = GET_ARRAY(_medicationConfig >> "hrIncreaseHigh",getArray (_defaultConfig >> "hrIncreaseHigh"));
    _incompatibleMedication = GET_ARRAY(_medicationConfig >> "incompatibleMedication",getArray (_defaultConfig >> "incompatibleMedication"));
    _maxRelief              = GET_NUMBER(_medicationConfig >> "maxRelief",getNumber (_defaultConfig >> "maxRelief"));
    _dose                   = GET_NUMBER(_medicationConfig >> "dose",getNumber (_defaultConfig >> "dose"));
    
    private _heartRate = GET_HEART_RATE(_patient);
    private _hrIncrease = [_hrIncreaseLow, _hrIncreaseNormal, _hrIncreaseHigh] select (floor ((0 max _heartRate min 110) / 55));
    _hrIncrease params ["_minIncrease", "_maxIncrease"];
    _heartRateChange = _minIncrease + random (_maxIncrease - _minIncrease);

    private _presentPain = GET_PAIN(_patient);
    private _presentReduce = 0;
    if (_maxRelief > 0) then {
        if (_presentPain > _maxRelief) then {
            _painReduce = _painReduce / 4;
        };
    };
    TRACE_6("adjustments1",_patient,_medicationName,_timeTillMaxEffect,_timeInSystem,_heartRateChange,_painReduce);
    TRACE_7("adjustments2",_viscosityChange,_dose,_alphaFactor,_opioidRelief,_opioidEffect,_opioidDepression,_respiratoryRate);
    [_patient, _className, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange, _dose, _alphaFactor, _opioidRelief, _opioidEffect, _opioidDepression, _respiratoryRate] call EFUNC(vitals,addMedicationAdjustment);
    [_patient, _className, _incompatibleMedication] call FUNC(onMedicationUsage);

    if (_className in ["Lorazepam","Ketamine","EACA","TXA","Atropine","Amiodarone","Flumazenil"]) then {
        [format ["kat_pharma_%1Local", toLower _className], [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
    };

    if (_className in ["Fentanyl","Morphine","Nalbuphine"]) then {
    [format ["kat_pharma_%1Local", toLower _className], [_patient, _bodyPart, _opioidRelief], _patient] call CBA_fnc_targetEvent;
    };
};

if (GVAR(AMSEnabled)) then {
private _TXAmedications = ["syringe_TXA_5ml_1", "syringe_TXA_10ml_1"];
    if (_classname in _TXAmedications) then {
        private _medication = _classname;
        private _administered = _patient getVariable ["meds_administered", []];
        private _effectTriggered = _patient getVariable ["effect_triggered", false];
        private _windowActive = _patient getVariable ["meds_window_active", false];
        if (!(_medication in _administered)) then {
            _administered pushBack _medication;
            _patient setVariable ["meds_administered", _administered, true];
        };
        if (count _administered == 1) then {
            _patient setVariable ["meds_window_active", false, true];
        [{
            params ["_patient"];
            _patient setVariable ["meds_window_active", true, true];  
        },
        [_patient], 180] call CBA_fnc_waitAndExecute; 
        [{
            params ["_patient"];
            _patient setVariable ["meds_window_active", false, true]; 
        },
        [_patient], 300] call CBA_fnc_waitAndExecute; 
        };
        if ((count _administered == count _TXAmedications) && (_patient getVariable ["meds_window_active", false]) && {!_effectTriggered}) then {
            _effectTriggered = true;
            [_patient, "EACA", 15, 360, "", "", "", "",  "", "", "", ""] call EFUNC(vitals,addMedicationAdjustment);
            [_patient, "Body"] call FUNC(treatmentAdvanced_EACALocal);
            _patient setVariable ["effect_triggered", false, true];
            _patient setVariable ["meds_administered", [], true];
            _patient setVariable ["meds_window_active", false, true];
        };
    };
};