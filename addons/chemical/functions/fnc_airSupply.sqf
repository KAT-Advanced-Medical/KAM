#include "..\script_component.hpp"
#define DEBUG_MODE_FULL
/*
 * Author: kolmipilot
 *
* Arguments:
 * 0: supply <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_airSupply;
 *
 * Public: No
 *
 *
*/

params ["_supply"];

private _action = [
    "AirSupply_recharge",
    CSTRING(RechargeSCBA),
    "",{
    params ["_target", "_player", "_params"];
    [FUNC(rechargeSCBA), [_player], _player] call CBA_fnc_targetEvent;},
    {true},
    {},
    [],
    [0, 0, 0],
    5
] call ace_interact_menu_fnc_createAction;
[_supply, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
