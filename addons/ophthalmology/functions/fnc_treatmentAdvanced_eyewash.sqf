#include "..\script_component.hpp"
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

[_patient, LLSTRING(eyewash_item)] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), LLSTRING(eyewash_item)]] call ACEFUNC(medical_treatment,addToLog);

_patient setVariable [QGVAR(dust_injury), false, true];
_patient setVariable [QGVAR(dust_injury_heavy), false, true];

GVAR(ppBlurDustInjury) ppEffectEnable false;
GVAR(ppBlurDustInjury) ppEffectAdjust [0];
GVAR(ppBlurDustInjury) ppEffectCommit 0;
