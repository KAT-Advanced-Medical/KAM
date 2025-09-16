#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks handwarmer status
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_hypothermia_fnc_checkHandWarmers;
 *
 * Public: No
 */

params ["_player", "_target"];
_hasWarmer = false;
private _warmers = _target getVariable [QGVAR(handWarmers), [0,0,0,0,0,0,0,0,0,0,0,0]];
_hasWarmer = (selectMax _warmers) > 0;
_hasWarmer