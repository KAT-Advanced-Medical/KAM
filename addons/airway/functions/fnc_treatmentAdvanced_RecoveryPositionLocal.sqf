#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for set patient into recovery position.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_RecoveryPositionLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(recovery), true, true];
_patient setVariable [QGVAR(overstretch), true, true];

private _output = LLSTRING(RecoveryPosition_Ready);
[_output, 2, _medic] call ACEFUNC(common,displayTextStructured);

_patient setVariable [QGVAR(wasOccluded), (_patient getVariable [QGVAR(occluded), false])];

if (GVAR(RecoveryPosition_TimeToDrain) > 0 && _patient getVariable [QGVAR(wasOccluded), false]) then {
    [{
        params ["_patient"];

        _patient setVariable [QGVAR(occluded), false, true];
        _patient setVariable [QGVAR(wasOccluded), false];
    }, [_patient], (random GVAR(RecoveryPosition_TimeToDrain) max 1)] call CBA_fnc_waitAndExecute;
} else {
    _patient setVariable [QGVAR(occluded), false, true];
    _patient setVariable [QGVAR(wasOccluded), false];
};

[{
    params ["_medic", "_patient"];

    _patient call ACEFUNC(medical_status,isBeingDragged) || _patient call ACEFUNC(medical_status,isBeingCarried) || !(_patient getVariable [QGVAR(recovery), false]) || !(isNull objectParent _patient);
}, {
    params ["_medic", "_patient"];

    if (_patient getVariable [QGVAR(recovery), false]) then {
        [LLSTRING(RecoveryPosition_Cancel), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
    };

    _patient setVariable [QGVAR(recovery), false, true];
    _patient setVariable [QGVAR(overstretch), false, true];
    _patient setVariable [QGVAR(occluded), (_patient getVariable [QGVAR(wasOccluded), false]), true];
}, [_medic, _patient], 3600, {}] call CBA_fnc_waitUntilAndExecute;
