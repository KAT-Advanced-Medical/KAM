#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * 
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Item Classname <STRING>
 *
 * Return Value:
 * <BOOLEAN>
 *
 * Example:
 * [player, "Nalbuphine"] call kat_pharma_fnc_treatmentAdvanced_NalbuphineLocal;
 *
 * Public: No
 */
params ["_patient"];

GVAR(ppNalbuphineDynamic) = ppEffectCreate ["DynamicBlur",511];

GVAR(ppNalbuphineDynamic) ppEffectEnable true;

GVAR(ppNalbuphineDynamic) ppEffectAdjust [1.76];

GVAR(ppNalbuphineDynamic) ppEffectCommit 3;

[{
	GVAR(ppNalbuphineDynamic) ppEffectEnable false;
},[_patient], 60] call CBA_fnc_waitAndExecute;