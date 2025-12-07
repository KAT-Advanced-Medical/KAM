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

private _woundClotDelayMult = 1;
private _medStack = [_patient, false] call ACEFUNC(medical_status,getAllMedicationCount);
private _medsToCheck = ["Alteplase", "CWMP"];
private _alteplaseEffectiveness = 0;
private _cwmpEffectiveness = 0;
{
    private _medName = toLower (_x select 0);
    private _effectiveness = _x select 2;
    if ("alteplase" in _medName) then {
        _alteplaseEffectiveness = _alteplaseEffectiveness max _effectiveness;
    };
    if ("cwmp" in _medName) then {
        _cwmpEffectiveness = _cwmpEffectiveness max _effectiveness;
    };
} forEach _medStack;
private _cwmpFixedEffectiveness = linearConversion [0, 1, _cwmpEffectiveness, 1, 1.3];
private _alteplaseFixedEffectiveness = linearConversion [0, 1, _alteplaseEffectiveness, 1, 10];
private _coagulationFactor = GET_BODY_FLUID_PLATELETS(_patient);
private _hypothermiaDelay = 1;
if (EGVAR(hypothermia,hypothermiaActive)) then {
    _hypothermiaDelay = linearConversion [35, 17, (_patient getVariable [QEGVAR(hypothermia,unitTemperature), 37]), 1, 3, true];
};
private _woundClotDelayMult = (round (((1 * _alteplaseFixedEffectiveness * (600/_coagulationFactor) * _cwmpFixedEffectiveness * _hypothermiaDelay) min 10) * 10)) / 10;

[_patient, "quick_view", LLSTRING(Coag_Sense_Log), [_woundClotDelayMult]] call ACEFUNC(medical_treatment,addToLog);
if (GVAR(abgEnable)) then {
    private _bloodGasArray = GET_BLOOD_GAS(_patient);
    _bloodGasArray params ["_paCO2", "_paO2", "_spO2", "_hCO3", "_pH", "_etCO2"];
    private _patientName = [_patient] call ACEFUNC(common,getName);
    private _output = format ["Patient: %1, PaCO2: %2, PaO2: %3, SpO2: %4, HCO3: %5, pH: %6", _patientName, _paCO2 toFixed 2, _paO2 toFixed 2, _spO2 toFixed 2, _hCO3 toFixed 2, _pH toFixed 2];
    [_output, 3, _medic] call ACEFUNC(common,displayTextStructured);
    [_patient, "quick_view", _output, [_medic]] call ACEFUNC(medical_treatment,addToLog);
    _patient setVariable [QEGVAR(circulation,testedBloodGas), _bloodGasArray, true];

};