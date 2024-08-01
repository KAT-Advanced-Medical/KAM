#include "..\script_component.hpp"

/*
 * Author: Battlekeeper, modified by YetheSamartaka and Tomcat
 * Handles the behaviour of Helistretcher - attaching it and using it.
 *
 *
 * Example:
 * [_unit,_item] call kat_misc_fnc_heliStretcherAttach;
 *
 * Public: No
 */

params ["_player","_target"];

private _stretcher = _target getVariable [QGVAR(stretcher), objNull];
private _ropes = _target getVariable [QGVAR(ropes), []];

{
	private _rope = _x;
	if (!isNull _rope) then {
		ropeUnwind [_rope, 2, -10, true];
	};
} forEach _ropes;
