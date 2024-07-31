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
params ["_entries"];

private _bloodGas = _entries select 0;
private _bloodGasArray = _bloodGas select 1;
private _patient = _bloodGas select 0;

private _output = format ["Patient: %1, PaCO2: %2, PaO2: %3, SpO2: %4, HCO2: %5, pH: %6, ETCO2: %7", _patient, (_bloodGasArray select 0) toFixed 2, (_bloodGasArray select 1) toFixed 2, (_bloodGasArray select 2) toFixed 2, (_bloodGasArray select 3) toFixed 2, (_bloodGasArray select 4) toFixed 2, (_bloodGasArray select 5) toFixed 2];
[_output, 3, (_entries select 2)] call ACEFUNC(common,displayTextStructured);

EGVAR(circulation,resultCounter) = if (EGVAR(circulation,resultCounter) == 20) then { 1 } else { EGVAR(circulation,resultCounter) + 1 };
EGVAR(circulation,resultSampleMap) set [EGVAR(circulation,resultCounter), [_patient, _bloodGasArray]];

private _itemStr = format ["KAT_bloodResult_%1",EGVAR(circulation,resultCounter)];

[(_entries select 3), (format ["KAT_bloodSample_%1",(_entries select 2)])] call CBA_fnc_removeItemCargo;
[(_entries select 1), _itemStr, true] call CBA_fnc_addItem;