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
detach _stretcher;

private _rope1 = ropeCreate [_target, "slingload0", _stretcher, [.25,1,0], 5];
private _rope2 = ropeCreate [_target, "slingload0", _stretcher, [-.25,1,0], 5];
private _rope3 = ropeCreate [_target, "slingload0", _stretcher, [-.25,-1,0], 5];
private _rope4 = ropeCreate [_target, "slingload0", _stretcher, [.25,-1,0], 5];

ropeUnwind [_rope1, 2, 5];
ropeUnwind [_rope2, 2, 5];
ropeUnwind [_rope3, 2, 5];
ropeUnwind [_rope4, 2, 5];

_target setVariable [QGVAR(stretcherDeployed), true, true];
_target setVariable [QGVAR(ropes), [_rope1,_rope2,_rope3,_rope4], true];
