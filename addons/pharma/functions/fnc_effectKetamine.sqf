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
	GVAR(ppKetamineBlur) ppEffectEnable false;
	GVAR(ppKetamineWet) ppEffectEnable false;
	GVAR(ppKetamineColor) ppEffectEnable false;
};

GVAR(ppKetamineBlur) = ppEffectCreate ["RadialBlur", 110];
GVAR(ppKetamineWet) = ppEffectCreate ["WetDistortion",310];
GVAR(ppKetamineColor) = ppEffectCreate ["ColorInversion",2510];

GVAR(ppKetamineBlur) ppEffectEnable true;
GVAR(ppKetamineWet) ppEffectEnable true;
GVAR(ppKetamineColor) ppEffectEnable true;

GVAR(ppKetamineBlur) ppEffectAdjust [0.05,0.04,0.12,0.16];
GVAR(ppKetamineWet) ppEffectAdjust [4.73,0.51,0.2,1,1,1,1,0.05,0.01,0.05,0.01,0.1,0.1,0.2,0.2];
GVAR(ppKetamineColor) ppEffectAdjust [0.46,0.58,0.5];

GVAR(ppKetamineBlur) ppEffectCommit 1;
GVAR(ppKetamineWet) ppEffectCommit 3;
GVAR(ppKetamineColor) ppEffectCommit 5;

[{
	GVAR(ppKetamineBlur) ppEffectEnable false;
	GVAR(ppKetamineWet) ppEffectEnable false;
	GVAR(ppKetamineColor) ppEffectEnable false;
},[_patient], 90] call CBA_fnc_waitAndExecute;