#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Registers a placed radioactive-source object as an inverse-square point
 * source. Uses a hot beta+gamma profile (a "lost industrial-radiography
 * source") so handling it point-blank burns the hands/arms and is rapidly
 * lethal whole-body. Runs once per object on the server.
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

private _strengths = [0, 500, 100, 0];

[QGVAR(addRadSource), [_obj, 15, _strengths, "inverseSquare", _obj, {
    params ["_obj"];
    !isNull _obj
}, [_obj]]] call CBA_fnc_localEvent;
