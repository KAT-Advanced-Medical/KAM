#include "..\script_component.hpp"
/*
 * Author: Miss Heda, edited by apo_tle
 * Removing Guedeltubus or KingLT
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_RemoveAirwayItem;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _item = _patient getVariable [QGVAR(airway_item), ""];

if (_item isEqualTo "Larynxtubus") then {
    [_patient, "activity", LSTRING(RemoveLarynxtubus_Log), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

    private _currentMonitors = _patient getVariable [QEGVAR(breathing,etco2Monitor), []];
    _currentMonitors deleteAt (_currentMonitors find "Larynxtubus");
    _patient setVariable [QEGVAR(breathing,etco2Monitor),_currentMonitors,true]; 
} else {
    [_patient, "activity", LSTRING(RemoveGuedeltubus_Log), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
};

[QGVAR(removeAirwayItemLocal), [_medic, _patient, _item], _patient] call CBA_fnc_targetEvent;
