#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for collapsing local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Treatment classname <STRING>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget, "Larynxtubus"] call kat_airway_fnc_treatmentAdvanced_airwayLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_usedItem"];

if (_patient getVariable [QGVAR(occluded), false]) exitWith {
    private _output = localize LSTRING(Airway_NotClearForItem);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
    if (_usedItem isEqualTo "Guedeltubus") then {
        [_medic, "kat_guedel"] call ace_common_fnc_addToInventory;
    } else {
    [_medic, "kat_larynx"] call ace_common_fnc_addToInventory;    
    };
    false;
};

if (_patient getVariable [QGVAR(airway_item), ""] isEqualTo "larynx") exitWith {
    private _output = localize LSTRING(Airway_already);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
    false;
};

if (_patient getVariable [QGVAR(airway_item), ""] isEqualTo "guedel" && (_usedItem isEqualTo "Guedeltubus")) exitWith {
    private _output = localize LSTRING(Airway_already);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
    false;
};

_patient setVariable [QGVAR(airway), true, true];
_patient setVariable [QGVAR(obstruction), false, true];

private _item = LSTRING(Larynx_Display);
_patient setVariable [QGVAR(airway_item), "larynx", true];

if (_usedItem isEqualTo "Guedeltubus") then {
    _item = LSTRING(Guedel_Display);
    _patient setVariable [QGVAR(airway_item), "guedel", true];
};
