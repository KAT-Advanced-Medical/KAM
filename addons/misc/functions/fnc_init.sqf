#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_misc_fnc_init;
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};

_unit setVariable [QGVAR(isLeftArmFree), true, true];
_unit setVariable [QGVAR(isRightArmFree), true, true];
_unit setVariable [QGVAR(isLeftLegFree), true, true];
_unit setVariable [QGVAR(isRightLegFree), true, true];

private _str = missionNamespace getVariable [QGVAR(armbandSlingLeftArm), ""];
private _array = [_str, ","" ", true] call FUNC(stringToArray);
_unit setVariable [QGVAR(armbandSlingLeftArmPos), _array, true];

private _str = missionNamespace getVariable [QGVAR(armbandSlingRightArm), ""];
private _array = [_str, ","" ", true] call FUNC(stringToArray);
_unit setVariable [QGVAR(armbandSlingRightArmPos), _array, true];

private _str = missionNamespace getVariable [QGVAR(armbandSlingLeftLeg), ""];
private _array = [_str, ","" ", true] call FUNC(stringToArray);
_unit setVariable [QGVAR(armbandSlingLeftLegPos), _array, true];

private _str = missionNamespace getVariable [QGVAR(armbandSlingRightLeg), ""];
private _array = [_str, ","" ", true] call FUNC(stringToArray);
_unit setVariable [QGVAR(armbandSlingRightLegPos), _array, true];

private _str = missionNamespace getVariable [QGVAR(armbandSlingLeftArmRotation), ""];
private _array = [_str, ","" ", true] call FUNC(stringToArray);
_unit setVariable [QGVAR(armbandSlingLeftArmRot), _array, true];

private _str = missionNamespace getVariable [QGVAR(armbandSlingRightArmRotation), ""];
private _array = [_str, ","" ", true] call FUNC(stringToArray);
_unit setVariable [QGVAR(armbandSlingRightArmRot), _array, true];

private _str = missionNamespace getVariable [QGVAR(armbandSlingLeftLegRotation), ""];
private _array = [_str, ","" ", true] call FUNC(stringToArray);
_unit setVariable [QGVAR(armbandSlingLeftLegRot), _array, true];

private _str = missionNamespace getVariable [QGVAR(armbandSlingRightLegRotation), ""];
private _array = [_str, ","" ", true] call FUNC(stringToArray);
_unit setVariable [QGVAR(armbandSlingRightLegRot), _array, true];
