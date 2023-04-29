#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Removing Guedeltubus
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_RemoveGuedeltubusLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(guedeltubusisSet), false, true];
_patient setVariable [QGVAR(airway_item), "", true];
_patient call FUNC(handleAirway);

if (GVAR(ReusableAirwayItems)) exitWith {
    if (_medic canAdd "kat_guedel") then {
        _medic addItem "kat_guedel";
    } else {
        _patient addItem "kat_guedel";
    };
};
