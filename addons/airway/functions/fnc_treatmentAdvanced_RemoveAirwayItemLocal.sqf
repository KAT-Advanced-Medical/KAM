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

params ["_medic", "_patient", "_item"];

_patient setVariable [QGVAR(airway_item), "", true];
_patient setVariable [QGVAR(airway), false, true];
_patient call FUNC(handleAirway);

if (_item isEqualTo "Larynxtubus") then {
    _patient call FUNC(handlePuking);
};

if !(GVAR(ReusableAirwayItems)) exitwith {};
    
if (_item isEqualTo "Larynxtubus") then {
    if (_medic canAdd "kat_larynx") then {
        _medic addItem "kat_larynx";
    } else {
        _patient addItem "kat_larynx";
    };
} else {
    if (_medic canAdd "kat_guedel") then {
        _medic addItem "kat_guedel";
    } else {
        _patient addItem "kat_guedel";
    };
};
