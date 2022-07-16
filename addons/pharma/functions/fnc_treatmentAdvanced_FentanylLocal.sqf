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
 * [player, "Fentanyl"] call kat_pharma_fnc_treatmentAdvanced_FentanylLocal;
 *
 * Public: No
 */

params ["_patient"];

GVAR(ppFentanylWet) = ppEffectCreate ["WetDistortion",311];

GVAR(ppFentanylWet) ppEffectEnable true;

GVAR(ppFentanylWet) ppEffectAdjust [1.5,0.4,0.4,1.04,0.96,0.96,1.04,0.05,0.01,0.05,0.01,0.1,0.1,0.2,0.2];

GVAR(ppFentanylWet) ppEffectCommit 3;

[{
	GVAR(ppFentanylWet) ppEffectEnable false;
},[_patient], 60] call CBA_fnc_waitAndExecute;