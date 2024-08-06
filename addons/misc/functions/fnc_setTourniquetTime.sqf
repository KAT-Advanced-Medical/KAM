#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Records in game time when tourniquet was applied
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Body Part <STRING>
 *
 * ReturnValue:
 * None
 *
 * Example:
 * [cursorObject, "LeftLeg"] call kat_misc_fnc_setTourniquetTime;
 *
 * Public: No
 */

params ["_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _tourniquetsDisplay = _patient getVariable [QEGVAR(circulation,tourniquetTime), [0,0,0,0,0,0]];

_tourniquetsDisplay set [_partIndex, ([dayTime, "HH:MM"] call BIS_fnc_timeToString)];

_patient setVariable [QEGVAR(circulation,tourniquetTime), _tourniquetsDisplay, true];