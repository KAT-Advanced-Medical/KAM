#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Drops the radioactive source the player is carrying back onto the ground.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_player"];

private _source = _player getVariable [QGVAR(carriedRadSource), objNull];
if (isNull _source) exitWith {};

_player setVariable [QGVAR(carriedRadSource), objNull, true];
[QGVAR(detachRadSource), [_source, _player]] call CBA_fnc_globalEvent;
