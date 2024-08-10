#include "..\script_component.hpp"

/*
 * Author: MiszczuZPolski
 * Deploys helistretcher attached below helicopter
 *
 * Arguments:
 * 0: Helicopter <OBJECT>
 *
 * Example:
 * [cursorObject] call kat_stretcher_fnc_deployHeliStretcher;
 *
 * Public: No
 */

params ["_target"];

private _stretcher = _target getVariable [QGVAR(stretcher), objNull];
detach _stretcher;

[_stretcher, true] call ACEFUNC(dragging,setCarryable);
[_stretcher, true] call ACEFUNC(dragging,setDraggable);

private _rope1 = ropeCreate [_target, "slingload0", _stretcher, [.25,1,0], 5];
private _rope2 = ropeCreate [_target, "slingload0", _stretcher, [-.25,1,0], 5];
private _rope3 = ropeCreate [_target, "slingload0", _stretcher, [-.25,-1,0], 5];
private _rope4 = ropeCreate [_target, "slingload0", _stretcher, [.25,-1,0], 5];

ropeUnwind [_rope1, 2, 10];
ropeUnwind [_rope2, 2, 10];
ropeUnwind [_rope3, 2, 10];
ropeUnwind [_rope4, 2, 10];

_target setVariable [QGVAR(stretcherDeployed), true, true];
_target setVariable [QGVAR(ropes), [_rope1,_rope2,_rope3,_rope4], true];
