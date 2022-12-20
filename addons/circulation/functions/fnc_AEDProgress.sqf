#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Handles the progress of the AED treatment.
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 *   0: Medic <OBJECT>
 *   1: Patient <OBJECT>
 *
 * Return Value:
 * Continue AED <BOOL>
 *
 * Example:
 * [[player, cursorObject]] call kat_circulation_fnc_AEDProgress
 *
 * Public: No
 */

params ["_args"];
_args params ["_medic", "_patient"];

[_medic, _patient] call FUNC(AED_Sound);

// Cancel AED if patient wakes up

!(_patient call ACEFUNC(common,isAwake))
&& {(ACEGVAR(medical_treatment,advancedDiagnose) != 0) || {IN_CRDC_ARRST(_patient)}} // if basic diagnose, then only show action if appropriate (they can't tell difference between uncon/ca)
&& {_medic == (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull])}
