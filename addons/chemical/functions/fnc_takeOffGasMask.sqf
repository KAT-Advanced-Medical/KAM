#include "..\script_component.hpp"

params ["_player"];

private _mask = goggles _player;

if (_mask isEqualTo "") exitWith {};

// unassignItem loses the mask when the inventory has no room for it
// Remove it and add it back, addToInventory puts it on the ground if it doesn't fit
removeGoggles _player;
[_player, _mask] call ACEFUNC(common,addToInventory);
