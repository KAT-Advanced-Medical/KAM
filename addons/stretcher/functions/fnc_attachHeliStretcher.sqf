#include "..\script_component.hpp"

/*
 * Author: MiszczuZPolski
 * Attaches helistretcher to helicopter
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Helicopter <OBJECT>
 *
 * Example:
 * [player, cursorObject] call kat_stretcher_fnc_attachHeliStretcher;
 *
 * Public: No
 */

params ["_player","_target"];

_player removeItem "kat_helistretcher";
private _stretcher = createVehicle ["kat_stretcher", (_target modelToWorld [0,0,-5])];
_stretcher attachTo [_target, [0,0,-.1], "slingload0"];
[_stretcher, false] call ACEFUNC(dragging,setCarryable);
[_stretcher, false] call ACEFUNC(dragging,setDraggable);
_target setVariable [QGVAR(isStretcherAttached), true, true];
_target setVariable [QGVAR(stretcher), _stretcher, true];


