#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks patient temperature
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_hypothermia_fnc_checkTemperature;
 *
 * Public: No
 */
params ["_medic", "_patient"];

private _unitTemperature = _patient getVariable [QGVAR(unitTemperature), 37];

switch (true) do {
    case (!(alive _patient)) : { [LLSTRING(temperature_dead), 1.5, _medic] call ACEFUNC(common,displayTextStructured); };
    case (_unitTemperature < 29) : { [LLSTRING(temperature_cold), 1.5, _medic] call ACEFUNC(common,displayTextStructured); };
    case (_unitTemperature < 32) : { [LLSTRING(temperature_cool), 1.5, _medic] call ACEFUNC(common,displayTextStructured); };
    case (_unitTemperature < 36) : { [LLSTRING(temperature_mild), 1.5, _medic] call ACEFUNC(common,displayTextStructured); };
    default {[LLSTRING(temperature_warm), 1.5, _medic] call ACEFUNC(common,displayTextStructured); };
};