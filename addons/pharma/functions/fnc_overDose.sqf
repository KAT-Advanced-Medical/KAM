#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effects of a medication.
 *
 * Arguments:
 * 0: The patient <OBJECT>
 * 1: Medication Treatment classname <STRING>
 * 2: Incompatable medication <ARRAY<STRING>>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "morphine"] call kat_pharma_fnc_overDose
 * Public: No
 */

params ["_unit", "_className", "_dose", "_limit",  "_incompatibleMedication"];
[format ["kat_pharma_%1OverdoseLocal", toLower _className], [_patient], _patient] call CBA_fnc_targetEvent;

/*else {
private _defaultConfig = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "Medication";
private _medicationConfig = (configFile >> "ace_medical_treatment" >> _classname);
private _onOverDose = getText (_medicationConfig >> "onOverDose");

    if (isClass _medicationConfig) then {
    _medicationConfig = _medicationConfig >> _classname;
    if (isText (_medicationConfig >> "onOverDose")) then {
        _onOverDose = getText (_medicationConfig >> "onOverDose");
        };
    };
    TRACE_2("overdose",_classname,_onOverDose);

    [QEGVAR(medical,overdose), [_unit, _classname, _dose, _limit, _incompatibleMed]] call CBA_fnc_localEvent;

    if (_onOverDose == "") exitWith {
    TRACE_1("CriticalVitals Event",_unit);
    [QEGVAR(medical,CriticalVitals), _unit] call CBA_fnc_localEvent;
    };

    _onOverDose = if (missionNamespace isNil _onOverDose) then {
    compile _onOverDose
    } else {
    missionNamespace getVariable _onOverDose
    };

    [_unit, _classname, _dose, _limit, _incompatibleMed] call _onOverDose};*/