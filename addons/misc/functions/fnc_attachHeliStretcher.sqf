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

private _stretcher = createVehicle ["kat_stretcher", (_target modelToWorld [0,0,-5])];
_stretcher attachTo [_target, [0,0,-.1], "slingload0"];
_target setVariable [QGVAR(isStretcherAttached), true, true];
_target setVariable [QGVAR(stretcher), _stretcher, true];
