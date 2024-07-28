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
params ["_bloodGasFrame", "_medic"];

private _bloodGas = _bloodGasFrame select 1;
private _output = format ["Patient: %1, PaCO2: %2, PaO2: %3, SpO2: %4, HCO2: %5, pH: %6, ETCO2: %7", _bloodGasFrame select 1, _bloodGas select 0, _bloodGas select 1, _bloodGas select 2, _bloodGas select 3, _bloodGas select 4, _bloodGas select 5,  _bloodGas select 6];
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);