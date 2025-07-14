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
if !(IS_UNCONSCIOUS(_patient)) exitWith { false };
if !(_patient getVariable [QGVAR(currentConverted), false]) exitWith { false };
private _spaceBlanket = _patient getVariable [QGVAR(spaceBlanket), false];

_spaceBlanket