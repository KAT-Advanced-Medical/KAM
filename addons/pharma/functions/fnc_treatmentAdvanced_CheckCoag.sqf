#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Checks the Coag Factors and displays it to the player
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *`
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_CheckCoag;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _coagFactors = _patient getVariable [QGVAR(coagulationFactor), 15];
private _missionCoagFactors = missionNamespace getVariable [QGVAR(coagulationFactor), 15];
private _slowINR = (_missionCoagFactors / 100) * 75;
private _shighINR = (_missionCoagFactors / 100) * 125;
private _hlowINR = (_missionCoagFactors / 100) * 50;
private _hhighINR = (_missionCoagFactors / 100) * 150;
private _output = "";

switch (true) do {
    case (_coagFactors < _slowINR && _coagFactors > _hlowINR): { _output = "slightly below normal INR"};
    case (_coagFactors > _shighINR && _coagFactors < _hhighINR): { _output = "sligtly above normal INR"};
    case (_coagFactors < _hlowINR): { _output = "highly below normal INR"};
    case (_coagFactors > _hhighINR): { _output = "highly above normal INR"};
    default { _output = "normal INR"};
};

[_patient, "quick_view", LLSTRING(Coag_Sense_Log), [_output]] call ACEFUNC(medical_treatment,addToLog);
