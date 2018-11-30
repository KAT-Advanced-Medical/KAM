/*
 * Author: Katalam
 * Condition check for the medicine IV stands to remove a bag.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Allowed to remove a IV bag <BOOLEAN>
 *
 * Example:
 * [player] call kat_aceMisc_fnc_conditionIV;
 *
 * Public: No
 */

params ["_player"];

if !(kat_aceMisc_enable) exitWith {false};

private _object = nearestObjects [_player, ["Land_IntravenStand_01_1bag_F", "Land_IntravenStand_01_2bags_F"], 10, false];
if (_object isEqualType []) then {
	_object = _object select 0;
};
if (_object distance _player <= 10) exitWith {true};
false;
