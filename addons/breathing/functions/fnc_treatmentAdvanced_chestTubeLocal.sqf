#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call to remove the fracture status from an open fracture
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Side <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, 1] call kat_surgery_fnc_openReductionLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_side"];

private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
private _liveChestTube = _chestTubeArray select _side;
systemChat str _liveChestTube;
if (_liveChestTube == 0.5)  exitWith {
    _liveChestTube = 0;

    _chestTubeArray set [_side, _liveChestTube];
    _tensionPneumothoraxArray set [_side, false];
    _patient setVariable [QGVAR(chestTube), _chestTubeArray, true];
    _patient setVariable [QGVAR(pneumothorax), _chestTubeArray, true];
    _patient setVariable [QGVAR(hemopneumothorax), _tensionPneumothoraxArray, true];
    _patient setVariable [QGVAR(tensionPneumothorax), _tensionPneumothoraxArray, true];
    [_patient, true] call ACEFUNC(dragging,setCarryable);
    [_patient, true] call ACEFUNC(dragging,setDraggable);
};

private _output = LLSTRING(chestTube_fail);
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
