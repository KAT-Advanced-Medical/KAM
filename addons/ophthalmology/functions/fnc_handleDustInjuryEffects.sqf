#include "script_component.hpp"
/*
 * Author: Katalam
 * Handles the effects of having dust in the eyes.
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_pfhID"];

if !(GVAR(enable)) exitWith {};

private _dustInjury = _unit getVariable [QGVAR(dust_injury), false];
private _dustInjuryHeavy = _unit getVariable [QGVAR(dust_injury_heavy), false];

// no injuries?
if (!_dustInjury && !_dustInjuryHeavy) exitWith {};

// already enabled?
if (ppEffectEnabled GVAR(ppBlurDustInjury)) exitWith {};

GVAR(ppBlurDustInjury) ppEffectEnable true;
GVAR(ppBlurDustInjury) ppEffectAdjust [GVAR(dust_effect_intensity)];
GVAR(ppBlurDustInjury) ppEffectCommit 30;
