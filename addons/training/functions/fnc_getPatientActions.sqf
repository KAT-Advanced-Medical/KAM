#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Returns one ACE action per patient of a training computer, used to choose the patient injuries are applied to.
 *
 * Arguments:
 * 0: Training computer <OBJECT>
 *
 * Return Value:
 * ACE actions <ARRAY>
 *
 * Example:
 * [cursorObject] call kat_training_fnc_getPatientActions
 *
 * Public: No
 */

params [["_computer", objNull, [objNull]]];

private _selected = _computer getVariable [QGVAR(patient), objNull];
private _actions = [];

{
    private _name = format ["%1. %2", _forEachIndex + 1, [_x] call ACEFUNC(common,getName)];

    if (_x isEqualTo _selected) then {
        _name = format [LLSTRING(SelectedPatient), _name];
    };

    _actions pushBack [
        [
            format [QGVAR(selectPatient_%1), _forEachIndex],
            _name,
            "",
            {
                params ["_computer", "_player", "_patient"];

                _computer setVariable [QGVAR(patient), _patient, true];

                [format [LLSTRING(PatientSelected), [_patient] call ACEFUNC(common,getName)], 1.5, _player] call ACEFUNC(common,displayTextStructured);
            },
            {true},
            {},
            _x
        ] call ACEFUNC(interact_menu,createAction),
        [],
        _computer
    ];
} forEach ([_computer] call FUNC(getPatients));

_actions
