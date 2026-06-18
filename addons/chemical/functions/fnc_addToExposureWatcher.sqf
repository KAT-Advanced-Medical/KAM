#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Asks the server to register a unit with the exposure watcher PFH so its
 * deadline variables get checked. Idempotent on the server side.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];

[QGVAR(serverAddExposureWatcher), [_unit]] call CBA_fnc_serverEvent;
