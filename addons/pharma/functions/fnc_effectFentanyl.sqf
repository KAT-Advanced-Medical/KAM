#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Create Fentanyl post process effect
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Enable <BOOL>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_patient, true] call kat_pharma_fnc_effectFentanyl;
 *
 * Public: No
 */
params ["_patient", "_enable"];

if (!_enable) exitWith {
	GVAR(ppFentanylWet) ppEffectEnable false;
};

GVAR(ppFentanylWet) = ppEffectCreate ["WetDistortion",311];

GVAR(ppFentanylWet) ppEffectEnable true;

GVAR(ppFentanylWet) ppEffectAdjust [1.5,0.4,0.4,1.04,0.96,0.96,1.04,0.05,0.01,0.05,0.01,0.1,0.1,0.2,0.2];

GVAR(ppFentanylWet) ppEffectCommit 3;

[{
	GVAR(ppFentanylWet) ppEffectEnable false;
},[_patient], 60] call CBA_fnc_waitAndExecute;