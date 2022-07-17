#include "script_component.hpp"
/*
 * Author: Glowbal
 * Calculates the blood volume change and decreases the IVs given to the unit.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 * 1: Time since last update <NUMBER>
 * 2: Global Sync Values (bloodbags) <BOOL>
 *
 * Return Value:
 * Blood volume change (liters per second) <NUMBER>
 *
 * Example:
 * [player, 1, true] call ace_medical_status_fnc_getBloodVolumeChange
 *
 * Public: No
 */
params ["_patient", "_enable"];

if (!_enable) exitWith {
	GVAR(ppNalbuphineDynamic) ppEffectEnable false;
};

GVAR(ppNalbuphineDynamic) = ppEffectCreate ["DynamicBlur",511];

GVAR(ppNalbuphineDynamic) ppEffectEnable true;

GVAR(ppNalbuphineDynamic) ppEffectAdjust [1.76];

GVAR(ppNalbuphineDynamic) ppEffectCommit 3;

[{
	GVAR(ppNalbuphineDynamic) ppEffectEnable false;
},[_patient], 60] call CBA_fnc_waitAndExecute;