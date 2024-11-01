#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Children action for attaching stretcher
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Stretcher <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_stretcher_fnc_packIntoBackpack;
 *
 * Public: No
 */

params ["_player", "_target"];

private _posATL = _player getRelPos [2, 0];
_posATL set [2, ((getPosATL _player) select 2) + 0.5];

"kat_stretcherBag" createVehicle _posATL; // TODO create at exact position
deleteVehicle _target;