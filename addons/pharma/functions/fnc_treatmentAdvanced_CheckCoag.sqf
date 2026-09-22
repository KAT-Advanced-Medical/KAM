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

private _coagFactors = _patient getVariable [QGVAR(coagulationFactor), 30];
private _missionCoagFactors = missionNamespace getVariable [QGVAR(coagulation_factor_count), 30];
private _slowINR = (_missionCoagFactors / 100) * 75;
private _shighINR = (_missionCoagFactors / 100) * 125;
private _hlowINR = (_missionCoagFactors / 100) * 50;
private _hhighINR = (_missionCoagFactors / 100) * 150;
private _output = "";

switch (true) do {
    case (_coagFactors < _slowINR && _coagFactors > _hlowINR): { _output = LLSTRING(CheckCoag_slightly_lowINR)};
    case (_coagFactors > _shighINR && _coagFactors < _hhighINR): { _output = LLSTRING(CheckCoag_slightly_aboveINR)};
    case (_coagFactors <= _hlowINR): { _output = LLSTRING(CheckCoag_highly_lowINR)};
    case (_coagFactors >= _hhighINR): { _output = LLSTRING(CheckCoag_highly_aboveINR)};
    default { _output = LLSTRING(CheckCoag_normalINR)};
};

[_patient, "quick_view", LLSTRING(Coag_Sense_Log), [_output]] call ACEFUNC(medical_treatment,addToLog);
if (EGVAR(circulation,abgEnable)) then {
    private _bloodGasArray = GET_BLOOD_GAS(_patient);
    _bloodGasArray params ["_paCO2", "_paO2", "_spO2", "_hCO3", "_pH", "_etCO2"];
    private _patientName = [_patient] call ACEFUNC(common,getName);
    private _output = format ["Patient: %1, PaCO2: %2, PaO2: %3, SpO2: %4, HCO3: %5, pH: %6", _patientName, _paCO2 toFixed 2, _paO2 toFixed 2, _spO2 toFixed 2, _hCO3 toFixed 2, _pH toFixed 2];
    [_output, 3, _medic] call ACEFUNC(common,displayTextStructured);
    [_patient, "quick_view", _output, [_medic]] call ACEFUNC(medical_treatment,addToLog);
    _bloodGasArray pushBack _ca;
    _patient setVariable [QEGVAR(circulation,testedBloodGas), _bloodGasArray, true];
    _patient setVariable [QEGVAR(circulation,bloodGasTime), CBA_missionTime, true];
};