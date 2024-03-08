#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Condition check for the medicine IV stands to remove a bag.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Ml <NUMBER>
 *
 * Return Value:
 * 0: Allowed <BOOLEAN>
 *
 * Example:
 * [player, 1000] call kat_misc_fnc_conditionIV;
 *
 * Public: No
 */

params [
    ["_player", objNull, [objNull]],
    ["_ml", 1000, [0]]
];

if !(GVAR(enable)) exitWith {false};

private _object = nearestObjects [_player, ['Land_IntravenStand_01_1bag_F', 'Land_IntravenStand_01_2bags_F'], 10, false];
if (isNil "_object") exitWith {false};
_object = _object select {_ml in (_x getVariable [QGVAR(stand), []])};
if (isNil "_object") exitWith {false};
_object = _object select 0;
if (_object distance _player <= 10) exitWith {true};
false;
