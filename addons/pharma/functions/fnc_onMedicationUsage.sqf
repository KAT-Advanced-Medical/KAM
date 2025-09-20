#include "..\script_component.hpp"
/*
 * Author: Glowbal, Cplhardcore
 * Handles the medication given to a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Medication Treatment classname <STRING>
 * 2: Incompatible medication <ARRAY of <STRING, NUMBER>>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "morphine", [["x", 1]]] call kat_pharma_fnc_onMedicationUsage
 *
 * Public: No
 */
 
params ["_target", "_className", "_incompatibleMedication"];
TRACE_3("onMedicationUsage",_target,_className,_incompatibleMedication);
    if !(_className in ["CWMP", "Painkillers", "Penthrox", "Carbonate", "BubbleWrap", "Caffeine", "Pervitin", "Naloxone"]) then {
        _medicationName = format ["syringe_%1", _className];
        private _defaultConfig    = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "Medication";
        private _medicationConfig = _defaultConfig >> _medicationName;
        TRACE_1("onMedicationUsage2",_medicationConfig);
        private _maxDose = GET_NUMBER(_medicationConfig >> "maxDose",getNumber (_defaultConfig >> "maxDose"));
        private _weightBase = GET_STRING(_medicationConfig >> "weightBased",getText (_defaultConfig >> "weightBased"));
        private _maxDoseMult = 1;
        if (_weightBase == "true") then {
            private _currentWeight = _target getVariable [QEGVAR(vitals,currentWeight), 80];
            _maxDoseMult = linearConversion [60, 100, _currentWeight, 0.6, 1.4, true];
        };
        private _unitMedEffectivness = _patient getVariable [QGVAR(medicationEffectivness), 1];
        private _maxDoseFixed = _maxDose * _maxDoseMult * _unitMedEffectivness;
        TRACE_2("onMedUsage1",_maxDoseFixed,_medicationName);

        if (_maxDoseFixed > 0) then {
            private _maxDoseDeviation = GET_NUMBER(_medicationConfig >> "maxDoseDeviation",getNumber (_defaultConfig >> "maxDoseDeviation"));
            private _currentDose = [_target, _className] call ACEFUNC(medical_status,getMedicationCount) select 0;
            TRACE_2("onMedUsage2",_currentDose,_className);
            // Because both {floor random 0} and {floor random 1} return 0
            if (_maxDoseDeviation > 0) then {
                _maxDoseDeviation = _maxDoseDeviation + 1;
            };
            _maxDoseDeviation * _maxDoseMult * _unitMedEffectivness;
            private _limit = _maxDoseFixed + (floor random _maxDoseDeviation);
            if (_currentDose > _limit) then {
                TRACE_1("exceeded max dose",_currentDose);
                [_target, _className, _currentDose, _limit, _incompatibleMed] call FUNC(overDose);
            };
            {
            _x params ["_xMed", "_xLimit"];
            private _inSystem = ([_target, _xMed] call ACEFUNC(medical_status,getMedicationCount)) select 0;
            if (_inSystem > _xLimit) then {
                [_target, _className, _inSystem, _xLimit, _xMed] call FUNC(overDose);
                };
            } forEach _incompatibleMedication;
            };
    } else {
        private _defaultConfig    = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "Medication";
        private _medicationConfig = _defaultConfig >> _classname;
        private _maxDose          = GET_NUMBER(_medicationConfig >> "maxDose",getNumber (_defaultConfig >> "maxDose"));
        private _currentWeight = _target getVariable [QEGVAR(vitals,currentWeight), 80];
        private _maxDoseMult = linearConversion [60, 100, _currentWeight, 0.7, 1.3, true];
        private _maxDoseFixed = _maxDose * _maxDoseMult;
        TRACE_2("onMedUsage1",_maxDoseFixed,_classname);
        if (_maxDoseFixed > 0) then {
        private _maxDoseDeviation = GET_NUMBER(_medicationConfig >> "maxDoseDeviation",getNumber (_defaultConfig >> "maxDoseDeviation"));
        private _currentDose = [_target, _className] call ACEFUNC(medical_status,getMedicationCount) select 0;
        TRACE_2("onMedUsage2",_currentDose,_classname);
        // Because both {floor random 0} and {floor random 1} return 0
        if (_maxDoseDeviation > 0) then {
            _maxDoseDeviation = _maxDoseDeviation + 1;
        };

        private _limit = _maxDoseFixed + (floor random _maxDoseDeviation);
        if (_currentDose > _limit) then {
            TRACE_1("exceeded max dose",_currentDose);
            [_target, _classname, _currentDose, _limit, _classname] call FUNC(overDose);
        };
    };

// Check incompatible medication (format [med,limit])
    {
        _x params ["_xMed", "_xLimit"];
        private _inSystem = ([_target, _xMed] call ACEFUNC(medical_status,getMedicationCount)) select 0;
        if (_inSystem > _xLimit) then {
            [_target, _classname, _inSystem, _xLimit, _xMed] call FUNC(overDose);
        };
        } forEach _incompatibleMedication;
    };

/*} else {
    private _defaultConfig    = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "Medication";
    private _medicationConfig = _defaultConfig >> _classname;
    private _maxDose          = GET_NUMBER(_medicationConfig >> "maxDose",getNumber (_defaultConfig >> "maxDose"));

    if (_maxDose > 0) then {
        private _maxDoseDeviation = GET_NUMBER(_medicationConfig >> "maxDoseDeviation",getNumber (_defaultConfig >> "maxDoseDeviation"));
        private _currentDose = [_target, _className] call ACEFUNC(medical_status,getMedicationCount) select 0;
        // Because both {floor random 0} and {floor random 1} return 0
        if (_maxDoseDeviation > 0) then {
            _maxDoseDeviation = _maxDoseDeviation + 1;
        };

        private _limit = _maxDose + (floor random _maxDoseDeviation);
        if (_currentDose > _limit) then {
            TRACE_1("exceeded max dose",_currentDose);
            [_target, _classname, _currentDose, _limit, _classname] call FUNC(overDose);
        };
    };

// Check incompatible medication (format [med,limit])
    {
        _x params ["_xMed", "_xLimit"];
        private _inSystem = ([_target, _xMed] call ACEFUNC(medical_status,getMedicationCount)) select 0;
        if (_inSystem > _xLimit) then {
            [_target, _classname, _inSystem, _xLimit, _xMed] call FUNC(overDose);
        };
    } forEach _incompatibleMedication;}*/
