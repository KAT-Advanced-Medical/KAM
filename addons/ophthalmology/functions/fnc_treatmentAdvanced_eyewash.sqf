#include "script_component.hpp"
/*
 * Author: Katalam
 * Handles the treatment of dust or heavy dust in eyes.
 *
 * Return Value:
 * None
 *
 * Public: No
 *
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(dust_injury), false, true];
_patient setVariable [QGVAR(dust_injury_heavy), false, true];
GVAR(ppBlurDustInjury) ppEffectEnable false;
GVAR(ppBlurDustInjury) ppEffectAdjust [0];
GVAR(ppBlurDustInjury) ppEffectCommit 0;
