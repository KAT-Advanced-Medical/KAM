#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for set patient from recovery position.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Hint is delayed? <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_CancelRecoveryPositionLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_delayed", false]];

_patient setVariable [QGVAR(recovery), false, true];
_patient setVariable [QGVAR(overstretch), false, true];
_patient setVariable [QGVAR(occluded), (_patient getVariable [QGVAR(wasOccluded), false]), true];
_patient call FUNC(handlePuking);

private _output = LLSTRING(RecoveryPosition_Cancel);

if (_delayed) then {
    [{
        params ["_medic", "_output"];

        [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
    }, [_medic, _output], 2.5] call CBA_fnc_waitAndExecute;
} else {
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};