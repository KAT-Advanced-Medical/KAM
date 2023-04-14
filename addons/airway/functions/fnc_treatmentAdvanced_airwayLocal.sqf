#include "script_component.hpp"
/*
 * Author: Katalam, edited by MiszczuZPolski
 * Airway Management for collapsing local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Treatment classname <STRING>
 * 3: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "Larynxtubus", "kat_larynx"] call kat_airway_fnc_treatmentAdvanced_airwayLocal;
 *
 * Public: No
 */

params ["_medic", "_patient","_classname", "_usedItem"];

if (_patient getVariable [QGVAR(occluded), false]) exitWith {
    [QGVAR(airwayFeedback), [_medic, LLSTRING(Airway_NotClearForItem)], _medic] call CBA_fnc_targetEvent;
    [_medic, _usedItem] call ACEFUNC(common,addToInventory);
};

if (_patient getVariable [QGVAR(airway_item), ""] isEqualTo "Larynxtubus") exitWith {
    [QGVAR(airwayFeedback), [_medic, LLSTRING(Airway_already)], _medic] call CBA_fnc_targetEvent;
    [_medic, _usedItem] call ACEFUNC(common,addToInventory);
};

if (_patient getVariable [QGVAR(airway_item), ""] isEqualTo "Guedeltubus" && _usedItem isEqualTo "kat_guedel") exitWith {
    [QGVAR(airwayFeedback), [_medic, LLSTRING(Airway_already)], _medic] call CBA_fnc_targetEvent;
    [_medic, _usedItem] call ACEFUNC(common,addToInventory);
};

_patient setVariable [QGVAR(airway), true, true];
_patient setVariable [QGVAR(obstruction), false, true];
_patient setVariable [QGVAR(airway_item), _classname, true];

[_patient, _usedItem] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", LSTRING(airway_log), [[_medic] call ACEFUNC(common,getName), getText (configFile >> "CfgWeapons" >> _usedItem >> "displayName")]] call ACEFUNC(medical_treatment,addToLog);
