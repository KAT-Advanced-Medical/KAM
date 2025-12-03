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

params ["_medic", "_patient"];
private _cricothyrotomy = _patient getVariable [QGVAR(cricothyrotomy), 0];


if (_cricothyrotomy == 0.5)  exitWith {
    _cricothyrotomy = 1;
    _patient setVariable [QGVAR(cricothyrotomy), _cricothyrotomy, true];
    _patient setVariable [QGVAR(airway_item), "Surgical_Airway", true];
    _patient setVariable [QGVAR(airway), true, true];
    private _currentMonitors = _patient getVariable [QEGVAR(breathing,etco2Monitor), []];
    _currentMonitors pushBack "Surgical_Airway";
    _patient setVariable [QEGVAR(breathing,etco2Monitor), _currentMonitors, true];
    [_patient, true] call ACEFUNC(dragging,setCarryable);
    [_patient, true] call ACEFUNC(dragging,setDraggable);
};

private _output = LLSTRING(chest_tube_fail);
[_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
