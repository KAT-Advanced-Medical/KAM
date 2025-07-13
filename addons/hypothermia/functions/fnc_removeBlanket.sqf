#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Check for fluid warmers present
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_hypothermia_fnc_removeWarmer;
 *
 * Public: No
 */
params ["_patient", "_bodyPart"];

private _spaceBlanket = _patient getVariable [QGVAR(spaceBlanket), false];

_spaceBlanket