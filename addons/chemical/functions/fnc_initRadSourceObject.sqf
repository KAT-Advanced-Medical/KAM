#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Registers a placed radioactive-source object as an inverse-square point
 * source (default Cobalt-60 profile). Runs once per object on the server.
 *
 * Arguments:
 * 0: Source object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_obj"];

if (!isServer || {isNull _obj}) exitWith {};

private _strengths = +(GVAR(radPresets) getOrDefault ["Cobalt60", [0, 0, 50, 0]]);

[QGVAR(addRadSource), [_obj, 15, _strengths, "inverseSquare", _obj, {
    params ["_obj"];
    !isNull _obj
}, [_obj]]] call CBA_fnc_localEvent;
