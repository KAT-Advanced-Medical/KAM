#include "script_component.hpp"
/*
 * Author: Katalam, edited by MiszczuZPolski
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

params ["_medic", "_patient","_classname", "_usedItem"];

if (_patient getVariable [QGVAR(occluded), false]) exitWith {
    private _output = LLSTRING(Airway_NotClearForItem);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
    [_medic, _usedItem] call ace_common_fnc_addToInventory;
};

if (_patient getVariable [QGVAR(airway_item), ""] isEqualTo "Larynxtubus") exitWith {
    private _output = LLSTRING(Airway_already);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
    [_medic, _usedItem] call ace_common_fnc_addToInventory;
};

if (_patient getVariable [QGVAR(airway_item), ""] isEqualTo "Guedeltubus" && _usedItem isEqualTo "kat_guedel") exitWith {
    private _output = LLSTRING(Airway_already);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
    [_medic, _usedItem] call ace_common_fnc_addToInventory;
};

_patient setVariable [QGVAR(airway), true, true];
_patient setVariable [QGVAR(obstruction), false, true];

_patient setVariable [QGVAR(airway_item), _classname, true];
