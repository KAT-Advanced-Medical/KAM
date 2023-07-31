#include "script_component.hpp"
/*
 * Author: Blue
 * Inspect chest for injuries
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_inspectChest;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _message = LLSTRING(inspectChest_normal);

if (GET_HEART_RATE(_patient) isEqualTo 0) then {
    _message = LLSTRING(inspectChest_none);
} else {
    if (_patient getVariable [QGVAR(pneumothorax), 0] > 2 || _patient getVariable [QGVAR(tensionpneumothorax), false] || _patient getVariable [QGVAR(hemopneumothorax), false]) then {
        _message = LLSTRING(inspectChest_uneven);
    };
};
if (_patient getVariable [QGVAR(hemopneumothorax), false]) then {
    _message = format ["%1\n%2", _message, LLSTRING(inspectChest_internalBleeding)];
};

[_message, 2, _medic] call ACEFUNC(common,displayTextStructured);

[_patient, "activity", LSTRING(inspectChest_log), [[_medic] call ACEFUNC(common,getName), _message]] call ACEFUNC(medical_treatment,addToLog);
