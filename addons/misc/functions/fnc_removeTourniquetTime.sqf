#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Removes in game time when tourniquet was applied
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Temperature Adjustments <OBJECT>
 * 2: Body Part <STRING>
 *
 * ReturnValue:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_misc_fnc_removeTourniquetTime;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _tourniquetsDisplay = _patient getVariable [QEGVAR(circulation,tourniquetTime), [0,0,0,0,0,0]];

_tourniquetsDisplay set [_partIndex, 0];

_patient setVariable [QEGVAR(circulation,tourniquetTime), _tourniquetsDisplay, true];