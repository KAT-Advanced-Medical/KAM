#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Handles the effects of having dust in the eyes.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_ophthalmonology_fnc_handleDustInjuryEffects;
 *
 * Public: No
 */

params ["_unit"];

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
