#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks patient temperature
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_hypothermia_fnc_useHandWarmer;
 *
 * Public: No
 */
params ["_entries", "_idNumber", "_medic"];

private _idNumber = _entries select 1;
private _bloodGasArray = (_entries select 0) get _idNumber;
private _medic = _entries select 2;
private _bloodGas = _bloodGasArray select 1;

private _output = format ["Patient: %1, PaCO2: %2, PaO2: %3, SpO2: %4, HCO2: %5, pH: %6, ETCO2: %7", _bloodGasArray select 0, _bloodGas select 0, _bloodGas select 1, _bloodGas select 2, _bloodGas select 3, _bloodGas select 4, _bloodGas select 5];
[_output, 20, _medic] call ACEFUNC(common,displayTextStructured);