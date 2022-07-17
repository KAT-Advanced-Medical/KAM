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
	GVAR(ppFentanylWet) ppEffectEnable false;
};

GVAR(ppFentanylWet) = ppEffectCreate ["WetDistortion",311];

GVAR(ppFentanylWet) ppEffectEnable true;

GVAR(ppFentanylWet) ppEffectAdjust [1.5,0.4,0.4,1.04,0.96,0.96,1.04,0.05,0.01,0.05,0.01,0.1,0.1,0.2,0.2];

GVAR(ppFentanylWet) ppEffectCommit 3;

[{
	GVAR(ppFentanylWet) ppEffectEnable false;
},[_patient], 60] call CBA_fnc_waitAndExecute;