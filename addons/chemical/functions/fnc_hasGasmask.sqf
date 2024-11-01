#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * Bool
 *
 * Example:
 * [player, cursorTarget] call kat_chemical_fnc_hasGasmask;
 *
 * Public: No
*/

params [["_player", objNull, [objNull]], ["_patient", objNull, [objNull]]];

private _playerArr = _player call ACEFUNC(common,uniqueItems);
private _playerHasGasmask = false;
{ if (_x in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) then {_playerHasGasmask = true} } forEach _playerArr;

private _patientarr = _patient call ACEFUNC(common,uniqueItems);
private _patientHasGasmask = false;
{ if (_x in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) then {_patientHasGasmask = true} } forEach _patientarr;

[true, false] select (!_playerHasGasmask && !_patientHasGasmask);
