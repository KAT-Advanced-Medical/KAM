#include "..\script_component.hpp"
/*
 * Author: mharis001
 * Condition for going into cardiac arrest upon receiving a fatal injury.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_statemachine_fnc_conditionSecondChance
 *
 * Public: No
 */

params ["_this"];

if !(_this getVariable [QGVAR(currentConverted), false]) exitWith { false };

if (isNil GRLIB_fob_range) exitWith { false };
if ((_this distance2d ([_this] call KPLIB_fnc_getNearestFob)) > GRLIB_fob_range) exitWith { false };

if !([_this] call FUNC(conversionCondition)) exitWith { false };

true