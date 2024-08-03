#include "..\script_component.hpp"

/*
 * Author: MiszczuZPolski
 * Inits stretcher object
 *
 * Arguments:
 * 0: Stretcher <OBJECT>
 *
 * Example:
 * [cursorObject] call kat_stretcher_fnc_initStretcher;
 *
 * Public: No
 */

params [["_object", objNull, [objNull]]];

[_object] call ACEFUNC(dragging,initObject);