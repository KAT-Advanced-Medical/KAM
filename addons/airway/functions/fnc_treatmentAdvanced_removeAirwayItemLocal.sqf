#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Removing airway item from patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_airway_fnc_treatmentAdvanced_removeAirwayItemLocal;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _item = _patient getVariable [QGVAR(airway_item), ""];

if (GVAR(reusableAirwayItem)) then {
    if (_item isEqualTo "Larynxtubus") then {
        [_medic, "kat_larynx"] call ACEFUNC(common,addToInventory);
    } else {
        [_medic, "kat_guedel"] call ACEFUNC(common,addToInventory);
    };
};

_patient setVariable [QGVAR(airway), false, true];
_patient setVariable [QGVAR(airway_item), "", true];
