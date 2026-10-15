#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Picks up a radioactive-source object: attaches it to the player (globally, so
 * the server-side source follows them and doses point-blank). The attached
 * source keeps its registration; local skin/limb dose comes from the proximity
 * branch in fnc_irradiate.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Source object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_player", "_source"];

if (isNull _source) exitWith {};
if !(isNull (_player getVariable [QGVAR(carriedRadSource), objNull])) exitWith {};

_player setVariable [QGVAR(carriedRadSource), _source, true];
[QGVAR(attachRadSource), [_source, _player]] call CBA_fnc_globalEvent;
