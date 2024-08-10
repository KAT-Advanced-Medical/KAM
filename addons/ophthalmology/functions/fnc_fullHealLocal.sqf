#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_circulation_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

_patient setVariable [QGVAR(dust_injury_heavy), false, true];
_patient setVariable [QGVAR(dust_injury), false, true];

GVAR(ppBlurDustInjury) ppEffectEnable false;
GVAR(ppBlurDustInjury) ppEffectAdjust [0];
GVAR(ppBlurDustInjury) ppEffectCommit 0;

