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
            private _sedated = _patient getVariable [QEGVAR(surgery,sedated), 0];
            if (_sedated == 0) then {
                [QACEGVAR(medical,WakeUp), _patient] call CBA_fnc_localEvent;
            };
        };
        case "EpinephrineIV": {
            private _sedated = _patient getVariable [QEGVAR(surgery,sedated), 0];
            if (_sedated == 0) then {
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
if (_classname in ["CWMP", "Painkillers", "Penthrox", "BubbleWrap", "Caffeine", "Pervitin"]) then {
    private _occlusionArray = _patient getVariable [QEGVAR(airway,occlusion), [0, 0, 0]];
    private _obstructionArray = _patient getVariable [QEGVAR(airway,obstruction), [0, 0, 0]];
    private _catastrophicState = _patient getVariable [QEGVAR(airway,catastrophicAirway), [false, false]];
    private _hasCatastrophicAirway = ((_catastrophicState select 0) || (_catastrophicState select 1));
    private _occlusion = (_occlusionArray findIf { _x > 2 }) != -1;
    private _obstruction = (_obstructionArray findIf { _x != 0 }) != -1;
    if ((((_obstruction || _occlusion)) || _hasCatastrophicAirway)) exitwith {
        TRACE_3("Medication injection site is occluded by tourniquet", _partIndex,_classname,_patient);
    };
};
private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
// Handle IV blockage
if ([7,8,9] find (_IVarray select _partIndex) != -1) exitWith {
    private _occludedMedications = _patient getVariable [QACEGVAR(medical,occludedMedications), []];
    _occludedMedications pushBack [_partIndex, _classname, _patient];
    _patient setVariable [QACEGVAR(medical,occludedMedications), _occludedMedications, true];
};
private _tourniquets = GET_TOURNIQUETS(_patient);
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

private _idx = _occlusionMap findIf { _x#0 == _partIndex };
private _result = if (_idx != -1) then { _occlusionMap select _idx select 1 } else { [] };
private _subDermalMeds = [
    "syringe_Lidocaine_10ml_10"
];
private _medParts = _classname splitString "_";
private _hasValidSuffix = count _medParts > 2 && { _medParts select 2 isEqualTo "5ml" };
private _isOccluded = 
    ({ _tourniquets select _x != 0 } count _result > 0) 
    && !( ((_IVarray select _partIndex isEqualTo 13) && _hasValidSuffix) 
    || (_classname in _subDermalMeds));
if (_isOccluded) exitWith {
    TRACE_3("Medication injection site is occluded by tourniquet", _partIndex,_classname,_patient);
    private _occludedMedications = _patient getVariable [QACEGVAR(medical,occludedMedications), []];
    _occludedMedications pushBack [_partIndex, _classname, _patient];
    _patient setVariable [QACEGVAR(medical,occludedMedications), _occludedMedications, true];
};

// Get adjustment attributes for used medication

// Get and calculate medication modifiers
    private _defaultConfig = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "Medication";
    private _medicationConfig = _defaultConfig >> _classname;
    if (!isClass _medicationConfig) then {
        private _parts = _classname splitString "_";
        if ((count _parts) > 1) then {
            _parts deleteAt ((count _parts) - 1);
            private _trimmedClassname = _parts joinString "_";
            _medicationConfig = _defaultConfig >> _trimmedClassname;
        };
    };
    _startDose = 20;
    private _parts = (_classname splitString "_");
    if (count _parts > 3) then {
        _startDose = parseNumber (_parts select -1);
    };
    private _currentWeight = _patient getVariable [QEGVAR(vitals,currentWeight), 80];
    private _defaultHeartRate = _patient getVariable [QEGVAR(circulation,defaultHeartRate), 80];
    private _heartRateRatio = GET_HEART_RATE(_patient) / _defaultHeartRate;
    private _bloodBased = GET_STRING(_medicationConfig >> "bloodBased",getText (_defaultConfig >> "bloodBased"));
    private _weightBase = GET_STRING(_medicationConfig >> "weightBase",getText (_defaultConfig >> "weightBase"));
    private _weightDose = GET_NUMBER(_medicationConfig >> "weightDose",getNumber (_defaultConfig >> "weightDose"));
    _weightMult = 1;
    if (_weightBase == "true") then {
        private _defaultWeight = _patient getVariable [QEGVAR(circulation,defaultWeight), 80];
        private _weightFixed = linearConversion [60, 100, _defaultWeight, 10, 30, true];
        _weightDoseFixed = _weightDose;
        if (_weightDose != 20) then {
            private _weightDoseMin = GET_NUMBER(_medicationConfig >> "weightDoseMin",getNumber (_defaultConfig >> "weightDoseMin"));
            private _weightDoseMax = GET_NUMBER(_medicationConfig >> "weightDoseMax",getNumber (_defaultConfig >> "weightDoseMax"));
            _weightDoseFixed = linearConversion [_weightDoseMin, _weightDoseMax, _weightDose, 10, 30, true];
        };
        _weightMult = (_weightFixed/_weightDoseFixed);
        private _distance = abs (_weightMult - 1);
        if (_weightMult < 1) then {
            private _divisor = linearConversion [0, 1, _distance, 1.0, 1.7, true];
            _weightMult = _weightMult / _divisor;
        } else {
            private _multiplier = linearConversion [0, 1, _distance, 1.0, 1.7, true];
            _weightMult = _weightMult * _multiplier;
        };
    } else {
        private _lc = linearConversion [10, 30, _startDose, 0.5, 1.5, true];
        _weightMult = _weightMult * _lc;
        TRACE_2("weightMult",_weightMult,_lc);
    };
    private _currentDose = [_patient, _medication] call ACEFUNC(medical_status,getMedicationCount) select 0;
    if !(_classname in ["CWMP", "Painkillers", "Penthrox", "Carbonate", "BubbleWrap", "Caffeine", "Pervitin", "Naloxone"]) then {
        private _medicationParts = _classname splitString "_";
        private _medicationName = _medicationParts select 1;
        private _upperMed = toUpper _medicationName;
        if (_upperMed select [count _upperMed - 4] isEqualTo "AUTO") then {
            _medicationName = _medicationName select [0, count _medicationName - 4];
        };
        if (_upperMed select [count _upperMed - 2] isEqualTo "IV") then {
            _medicationName = _medicationName select [0, count _medicationName - 2];
        };
        private _medicationMEDName = format ["syringe_%1", _medicationName];
        private _doseConfig = _defaultConfig >> _medicationMEDName;
        private _maximumEffectiveDose = GET_NUMBER(_doseConfig >> "maximumEffectiveDose",getNumber (_defaultConfig >> "maximumEffectiveDose"));
    } else {
        _maximumEffectiveDose = GET_NUMBER(_medicationConfig >> "maximumEffectiveDose",getNumber (_defaultConfig >> "maximumEffectiveDose"));
    };
    TRACE_4("medicationEffectivness",_currentDose,_medication,_maximumEffectiveDose,_startDose);
    private _unitMedEffectivness = _patient getVariable [QGVAR(medicationEffectivness), 1];
    private _maximumEffectiveDose = _maximumEffectiveDose * _unitMedEffectivness;
    private _doseMult = 1;
        if ((_currentDose + _startDose) > _maximumEffectiveDose) then {
            private _excess = (_currentDose + _startDose) - _maximumEffectiveDose;
            private _reductionFactor = linearConversion [0, _maximumEffectiveDose, _excess, 1.0, 0.1, true];
            _doseMult = _doseMult * _reductionFactor;
        };
    
    private _distance = abs (_weightMult - 1);
        if (_weightMult < 1) then {
            private _divisor = linearConversion [0, 1, _distance, 1.0, 1.7, true];
            _weightMult = _weightMult / _divisor;
        } else {
            private _multiplier = linearConversion [0, 1, _distance, 1.0, 1.7, true];
            _weightMult = _weightMult * _multiplier;
        };
    private _routeMult = 1;
        if ((_IVarray select _partIndex) in [1, 13]) then {
            _routeMult = random [0.7, 0.8, 1];
        };
    private _hemocrit = 1;
        if (_bloodBased == "true") then {
            _hemocrit = (GET_BODY_FLUID_ECB(_patient)/GET_BODY_FLUID_ECP(_patient)) / (DEFAULT_ECB/DEFAULT_ECP)
        } else {
            _hemocrit = (GET_BODY_FLUID_ECP(_patient)/GET_BODY_FLUID_ECB(_patient)) / (DEFAULT_ECP/DEFAULT_ECB)
        };
    private _unitMedEffectivness = _patient getVariable [QGVAR(medicationEffectivness), 1];
    private _drugMult = ((((GET_BLOOD_VOLUME_LITERS(_patient) / DEFAULT_BLOOD_VOLUME) * (_heartRateRatio) * _hemocrit) max 0.2) min 2.5) * _weightMult * _doseMult * _unitMedEffectivness * _routeMult;
    TRACE_5("_drugMult",_patient,_defaultHeartRate,_heartRateRatio,(GET_BLOOD_VOLUME_LITERS(_patient) / DEFAULT_BLOOD_VOLUME),_drugMult);
    _painReduce             = GET_NUMBER(_medicationConfig >> "painReduce",getNumber (_defaultConfig >> "painReduce")) * _drugMult;
    _timeInSystem           = GET_NUMBER(_medicationConfig >> "timeInSystem",getNumber (_defaultConfig >> "timeInSystem")) * _drugMult;
    _timeTillMaxEffect      = GET_NUMBER(_medicationConfig >> "timeTillMaxEffect",getNumber (_defaultConfig >> "timeTillMaxEffect")) * _heartRateRatio;
    _viscosityChange        = GET_NUMBER(_medicationConfig >> "viscosityChange",getNumber (_defaultConfig >> "viscosityChange")) * _drugMult;
    _alphaFactor            = GET_NUMBER(_medicationConfig >> "alphaFactor",getNumber (_defaultConfig >> "alphaFactor")) * _drugMult;
    _opioidRelief           = GET_NUMBER(_medicationConfig >> "opioidRelief",getNumber (_defaultConfig >> "opioidRelief")) * _drugMult;
    _opioidEffect           = GET_NUMBER(_medicationConfig >> "opioidEffect",getNumber (_defaultConfig >> "opioidEffect")) * _drugMult;
    _respiratoryRate        = GET_NUMBER(_medicationConfig >> "respiratoryRate",getNumber (_defaultConfig >> "respiratoryRate")) * _drugMult;
    _opioidDepression       = GET_NUMBER(_medicationConfig >> "opioidDepression",getNumber (_defaultConfig >> "opioidDepression")) * _drugMult;
    _hrIncreaseLow          = GET_ARRAY(_medicationConfig >> "hrIncreaseLow",getArray (_defaultConfig >> "hrIncreaseLow"));
    _hrIncreaseNormal       = GET_ARRAY(_medicationConfig >> "hrIncreaseNormal",getArray (_defaultConfig >> "hrIncreaseNormal"));
    _hrIncreaseHigh         = GET_ARRAY(_medicationConfig >> "hrIncreaseHigh",getArray (_defaultConfig >> "hrIncreaseHigh"));
    _incompatibleMedication = GET_ARRAY(_medicationConfig >> "incompatibleMedication",getArray (_defaultConfig >> "incompatibleMedication"));
    _maxRelief              = GET_NUMBER(_medicationConfig >> "maxRelief",getNumber (_defaultConfig >> "maxRelief"));
    _dose                   = GET_NUMBER(_medicationConfig >> "dose",getNumber (_defaultConfig >> "dose")) * (_drugMult / _doseMult) * _startDose;
    _contractility          = GET_NUMBER(_medicationConfig >> "contractility",getNumber (_defaultConfig >> "contractility")) * _drugMult;
    _nauseaMult             = GET_NUMBER(_medicationConfig >> "nauseaMult",getNumber (_defaultConfig >> "nauseaMult")) * _drugMult;
    _sedation               = GET_STRING(_medicationConfig >> "sedation",getText (_defaultConfig >> "sedation"));
    _paralysis              = GET_STRING(_medicationConfig >> "paralysis",getText (_defaultConfig >> "paralysis"));

    private _heartRate = GET_HEART_RATE(_patient);
    private _hrIncrease = [_hrIncreaseLow, _hrIncreaseNormal, _hrIncreaseHigh] select (floor ((0 max _heartRate min 110) / 55));
    _hrIncrease params ["_minIncrease", "_maxIncrease"];
    _heartRateChange = (_minIncrease + random (_maxIncrease - _minIncrease)) * _drugMult;

    private _presentPain = GET_PAIN(_patient);
    private _presentReduce = 0;
    if (_maxRelief > 0) then {
        if (_presentPain > _maxRelief) then {
            _painReduce = _painReduce / 4;
        };
    };
    private _medicationParts = (_classname splitString "_");
    TRACE_1("ClassName being processed:",_classname);
    TRACE_1("SplitString result for _classname:",_medicationParts);
    if (count _medicationParts > 3) then {
        _medicationName = _medicationParts select 1;
        private _upperMed = toUpper _medicationName;
        if (_upperMed select [count _upperMed - 4] isEqualTo "AUTO") then {
            _medicationName = _medicationName select [0, count _medicationName - 4];
        };
        if (_upperMed select [count _upperMed - 2] isEqualTo "IV") then {
            _medicationName = _medicationName select [0, count _medicationName - 2];
        };
        TRACE_6("adjustments1",_patient,_medicationName,_timeTillMaxEffect,_timeInSystem,_heartRateChange,_painReduce);
        TRACE_7("adjustments2",_viscosityChange,_dose,_alphaFactor,_opioidRelief,_opioidEffect,_opioidDepression,_respiratoryRate);
        [_patient, _medicationName, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange, _dose, _alphaFactor, _opioidRelief, _opioidEffect, _opioidDepression, _respiratoryRate, _contractility, _nauseaMult, _sedation, _paralysis] call EFUNC(vitals,addMedicationAdjustment);
        [_patient, _medicationName, _incompatibleMedication] call FUNC(onMedicationUsage);
    } else {
        if (_classname in ["TXAAuto", "PhenylephrineAuto"]) then {
            private _medicationName = _classname select [0, count _classname - 4];
            TRACE_6("adjustments1",_patient,_classname,_timeTillMaxEffect,_timeInSystem,_heartRateChange,_painReduce);
            TRACE_7("adjustments2",_viscosityChange,_dose,_alphaFactor,_opioidRelief,_opioidEffect,_opioidDepression,_respiratoryRate);
            [_patient, _medicationName, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange, _dose, _alphaFactor, _opioidRelief, _opioidEffect, _opioidDepression, _respiratoryRate, _contractility, _nauseaMult, _sedation, _paralysis] call EFUNC(vitals,addMedicationAdjustment);
            [_patient, _medicationName, _incompatibleMedication] call FUNC(onMedicationUsage);
        } else {
            TRACE_6("adjustments1",_patient,_classname,_timeTillMaxEffect,_timeInSystem,_heartRateChange,_painReduce);
            TRACE_7("adjustments2",_viscosityChange,_dose,_alphaFactor,_opioidRelief,_opioidEffect,_opioidDepression,_respiratoryRate);
            [_patient, _classname, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange, _dose, _alphaFactor, _opioidRelief, _opioidEffect, _opioidDepression, _respiratoryRate, _contractility, _nauseaMult, _sedation, _paralysis] call EFUNC(vitals,addMedicationAdjustment);
            [_patient, _classname, _incompatibleMedication] call FUNC(onMedicationUsage);
        };
    };

    if (count _medicationParts > 3) then {
        _medicationName = _medicationParts select 1;
        private _upperMed = toUpper _medicationName;
        if (_upperMed select [count _upperMed - 4] isEqualTo "AUTO") then {
            _medicationName = _medicationName select [0, count _medicationName - 4];
        };
        if (_upperMed select [count _upperMed - 2] isEqualTo "IV") then {
            _medicationName = _medicationName select [0, count _medicationName - 2];
        };
        if (_medicationName in ["EACA","TXA","Amiodarone","Flumazenil"]) then {
        [format ["kat_pharma_%1Local", toLower _medicationName], [_patient, _bodyPart], _patient] call CBA_fnc_targetEvent;
        };

        if (_medicationName in ["Lorazepam","Etomidate","Rocuronium","Sugammadex","Succinylcholine"]) then {
        [format ["kat_pharma_%1Local", toLower _medicationName], [_patient, _dose], _patient] call CBA_fnc_targetEvent;
        };

        if (_medicationName in ["Rocuronium","Succinylcholine"]) then {
        [format ["kat_pharma_%1Local", toLower _medicationName], [_patient, _dose, _timeTillMaxEffect, _timeInSystem], _patient] call CBA_fnc_targetEvent;
        };

        if (_medicationName in ["Ketamine","Atropine","Adenosine","Alteplase","Lidocaine"]) then {
        [format ["kat_pharma_%1Local", toLower _medicationName], [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
        };

        if (_medicationName in ["Fentanyl","Morphine","Nalbuphine"]) then {
        [format ["kat_pharma_%1Local", toLower _medicationName], [_patient, _bodyPart, _opioidRelief], _patient] call CBA_fnc_targetEvent;
        };
    } else {
        if (_classname in ["Lorazepam","Ketamine","EACA","TXA","Atropine","Amiodarone","Flumazenil","Lidocaine", "TXAAuto"]) then {
        [format ["kat_pharma_%1Local", toLower _classname], [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
        };

        if (_classname in ["Fentanyl","Morphine","Nalbuphine"]) then {
        [format ["kat_pharma_%1Local", toLower _classname], [_patient, _bodyPart, _opioidRelief], _patient] call CBA_fnc_targetEvent;
        };
    };
    
/*
    private _defaultConfig = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "Medication";
    private _medicationConfig = _defaultConfig >> _classname;
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
    _contractility          = GET_NUMBER(_medicationConfig >> "_contractility",getNumber (_defaultConfig >> "_contractility"));
    _nauseaMult             = GET_NUMBER(_medicationConfig >> "nauseaMult",getNumber (_defaultConfig >> "nauseaMult"));
    _sedation               = GET_STRING(_medicationConfig >> "sedation",getText (_defaultConfig >> "sedation"));
    
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
    [_patient, _classname, _timeTillMaxEffect, _timeInSystem, _heartRateChange, _painReduce, _viscosityChange, _dose, _alphaFactor, _opioidRelief, _opioidEffect, _opioidDepression, _respiratoryRate, _contractility, _nauseaMult, _sedation] call EFUNC(vitals,addMedicationAdjustment);
    [_patient, _classname, _incompatibleMedication] call FUNC(onMedicationUsage);

    if (_classname in ["Lorazepam","Ketamine","EACA","TXA","TXAAuto","Atropine","Amiodarone","Flumazenil","Lidocaine"]) then {
        [format ["kat_pharma_%1Local", toLower _classname], [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;
    };

    if (_classname in ["Fentanyl","Morphine","Nalbuphine"]) then {
    [format ["kat_pharma_%1Local", toLower _classname], [_patient, _bodyPart, _opioidRelief], _patient] call CBA_fnc_targetEvent;
    };
};*/
private _TXAmedications = ["syringe_TXA_5ml_10", "syringe_TXA_10ml_10", "TXAAuto"];
    if (_classname in _TXAmedications) then {
        TRACE_1("TXADose",_patient);
        if (_classname in ["TXAAuto"]) then {
            _medicationName = _classname select [0, count _classname - 4];
        };
        private _medicationParts = (_classname splitString "_");
        if (count _medicationParts > 3) then {
                _medicationName = _medicationParts select 1;
        };
        private _medication = _medicationName;
        private _administered = _patient getVariable [QGVAR(TXAActive), []];
        private _effectTriggered = _patient getVariable [QGVAR(TXATriggered), false];
        private _windowActive = _patient getVariable [QGVAR(TXAWindow), false];
        if (!(_medication in _administered)) then {
            _administered pushBack _medication;
            _patient setVariable [QGVAR(TXAActive), _administered, true];
        };
        if (count _administered == 1) then {
            _patient setVariable [QGVAR(TXATriggered), false, true];
        [{
            params ["_patient"];
            _patient setVariable [QGVAR(TXAWindow), true, true];  
        },
        [_patient], 120] call CBA_fnc_waitAndExecute; 
        [{
            params ["_patient"];
            _patient setVariable [QGVAR(TXAWindow), false, true]; 
        },
        [_patient], 300] call CBA_fnc_waitAndExecute; 
        };
        if ((count _administered == count _TXAmedications) && (_patient getVariable [QGVAR(TXAWindow), false]) && {!_effectTriggered}) then {
            _effectTriggered = true;
            [_patient, "EACA", 15, 360] call EFUNC(vitals,addMedicationAdjustment);
            [_patient, "Body"] call FUNC(treatmentAdvanced_EACALocal);
            _patient setVariable [QGVAR(TXATriggered), false, true];
            _patient setVariable [QGVAR(TXAActive), [], true];
            _patient setVariable [QGVAR(TXAWindow), false, true];
        };
    };