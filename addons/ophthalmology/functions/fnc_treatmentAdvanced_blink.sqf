#include "script_component.hpp"
/*
 * Author: Katalam
 * Handles the possibility to treat dust in the eye with blinking
 *
 * Return Value:
 * None
 *
 * Public: No
 *
 */

params ["_medic", "_patient"];

// get a random integer
private _random = floor(random [0, 50, 100]);

// heavy dust injury?
if (_patient getVariable [QGVAR(dust_injury_heavy), false]) exitWith {};
// no dust injury?
if !(_patient getVariable [QGVAR(dust_injury), false]) exitWith {};

if (_random <= GVAR(probability_treatment_dust)) then {
    _patient setVariable [QGVAR(dust_injury), false, true];
    GVAR(ppBlurDustInjury) ppEffectEnable false;
    GVAR(ppBlurDustInjury) ppEffectAdjust [0];
    GVAR(ppBlurDustInjury) ppEffectCommit 0;
};
