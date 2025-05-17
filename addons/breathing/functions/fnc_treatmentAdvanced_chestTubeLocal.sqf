#include "..\script_component.hpp"
/*
 * Author: Cplhadcore
 * Local call to remove hemothoraxes/tension pnumos after a placed chest tube
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
 * [player, cursorObject, 1] call kat_breathing_treatmentAdvanced_chestTubeLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];
private _chestTubeArray = _patient getVariable [QGVAR(chestTube), [0,0]];
private _liveChestTube = _chestTubeArray select _side;


if (_liveChestTube == 0.5)  exitWith {
    _liveChestTube = 0;

    _chestTubeArray set [_side, _liveChestTube];
    _tensionPneumothoraxArray set [_side, false];
    _patient setVariable [QGVAR(chestTube), _chestTubeArray, true];
    private _activeChestSeal = _patient getVariable [QGVAR(activeChestSeal), [false, false]];
    if (_activeChestSeal select _side) then {
    private _hemopneumothorax = _patient getVariable [QGVAR(hemopneumothorax), [false, false]];
    _hemopneumothorax set [_side, false];
    _patient setVariable [QGVAR(hemopneumothorax), _hemopneumothorax, true];
    private _tensionPneumothorax = _patient getVariable [QGVAR(tensionPneumothorax), [false, false]];
    _tensionPneumothorax set [_side, false];
    _patient setVariable [QGVAR(tensionPneumothorax), _tensionPneumothorax, true];
    };
    [_patient, true] call ACEFUNC(dragging,setCarryable);
    [_patient, true] call ACEFUNC(dragging,setDraggable);
    private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
    _ht deleteAt (_ht find "tension");
    _ht deleteAt (_ht find "hemo");
    _patient setVariable [QEGVAR(circulation,ht), _ht, true];
};

private _output = LLSTRING(chest_tube_fail);
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
