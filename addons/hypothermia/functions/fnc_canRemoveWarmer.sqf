#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Check if there is a fluid warmer to remove
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Warmer Present <BOOL>
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_hypothermia_fnc_canRemoveWarmer;
 *
 * Public: No
 */
params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _warmerArray = _patient getVariable [QGVAR(fluidWarmer), [0,0,0,0,0,0]];

if (_warmerArray select _partIndex == 0) exitWith {
    false
};

true

