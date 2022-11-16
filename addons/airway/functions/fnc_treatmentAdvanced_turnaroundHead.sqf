#include "script_component.hpp"
/*
 * Author: Katalam
 * Turns the head of the patient for airway management without items
 *
 * Arguments:
 * 0: Soldier <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_turnaroundHead;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if !(_patient getVariable [QGVAR(occluded), false]) exitWith {
    private _output = LLSTRING(Airway_turnaroundSuccess);
    [_output, 2, _medic] call ace_common_fnc_displayTextStructured;
};

// TO-DO: head turning animation

private _output = LLSTRING(turnaround_info);
[_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;

if (random 100 < GVAR(probability_headturning)) then {
    _patient setVariable [QGVAR(occluded), false, true];
};
