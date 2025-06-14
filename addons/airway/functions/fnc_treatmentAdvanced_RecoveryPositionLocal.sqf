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

if (GVAR(RecoveryPosition_TimeToDrain) > 0) then {
   [{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    private _occlusionState = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
    if (!(alive _unit) || {(_occlusionState select 0 == 0) && (_occlusionState select 1 == 0) && (_occlusionState select 2 == 0)}) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _occlusionState = _unit getVariable [QGVAR(occlusion), [0, 0, 0]];
    _occlusionState set [0, ((_occlusion select 0) - selectRandom [1, 2]) max 0];
    _occlusionState set [1, ((_occlusion select 1) - selectRandom [1, 2]) max 0];
    _occlusionState set [2, ((_occlusion select 2) - selectRandom [1, 2]) max 0];
    _unit setVariable [QGVAR(occlusion), _occlusionState, true];
}, GVAR(RecoveryPosition_TimeToDrain), [_unit]] call CBA_fnc_addPerFrameHandler;
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
}, [_medic, _patient], 3600, {}] call CBA_fnc_waitUntilAndExecute;
