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

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _warmerArray = _patient getVariable [QGVAR(fluidWarmer), [0,0,0,0,0,0]];

if (_warmerArray select _partIndex == 0) exitWith {
    false
};

true
