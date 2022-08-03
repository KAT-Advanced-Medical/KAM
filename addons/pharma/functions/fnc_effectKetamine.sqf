#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Create Ketamine post process effect
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Enable <BOOL>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_patient, true] call kat_pharma_fnc_effectKetamine;
 *
 * Public: No
 */
params ["_patient", "_enable"];

GVAR(ppKetamineBlur) = ppEffectCreate ["RadialBlur", 110];
GVAR(ppKetamineWet) = ppEffectCreate ["WetDistortion",310];
GVAR(ppKetamineColor) = ppEffectCreate ["ColorInversion",2510];

if (!_enable) exitWith {
	GVAR(ppKetamineBlur) ppEffectEnable false;
	GVAR(ppKetamineWet) ppEffectEnable false;
	GVAR(ppKetamineColor) ppEffectEnable false;
};

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