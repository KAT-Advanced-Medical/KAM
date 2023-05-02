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
    [_medic, "kat_larynx"] call ACEFUNC(common,addToInventory);
} else {
    [_medic, "kat_guedel"] call ACEFUNC(common,addToInventory);
};