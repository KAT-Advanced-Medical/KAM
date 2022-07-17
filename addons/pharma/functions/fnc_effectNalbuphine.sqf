#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Create Nalbuphine post process effect
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Enable <BOOL>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_patient, true] call kat_pharma_fnc_effectNalbuphine;
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