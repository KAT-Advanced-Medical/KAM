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
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_CancelRecoveryPositionLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(recovery), false, true];
_patient setVariable [QGVAR(overstretch), false, true];
_patient call FUNC(handlePuking);

private _output = LLSTRING(Recovery_Cancel);
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
