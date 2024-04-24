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

params [["_player", objNull, [objNull]],["_patient", objNull, [objNull]]];


private _playerarr = _player call ACEFUNC(common,uniqueItems);
private _playerhasGasmask = false;
{ if(_x in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) then {_playerhasGasmask = true} } forEach _playerarr;

private _patientarr = _patient call ACEFUNC(common,uniqueItems);
private _patienthasGasmask = false;
{ if(_x in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) then {_patienthasGasmask = true} } forEach _patientarr;

[true, false] select (!_playerhasGasmask && !_patienthasGasmask);