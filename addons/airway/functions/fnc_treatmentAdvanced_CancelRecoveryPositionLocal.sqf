#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for set patient from recovery position.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Successful treatment
 *
 * Example:
 * call kat_airway_fnc_CancelRecoveryPositionLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(recovery), false, true];
_patient setVariable [QGVAR(overstretch), false, true];

private _output = localize LSTRING(Recovery_Cancel);
[_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
