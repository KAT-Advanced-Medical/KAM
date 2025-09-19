#include "..\script_component.hpp"
/*
 * Author: Katalam, edited by MiszczuZPolski, Miss Heda & apo_tle
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

params ["_medic", "_patient","_classname", "_usedItem", ["_requireClear", true]];
private _occlusion = ((_patient getVariable [QGVAR(occlusion), [0, 0, 0]]) findIf { _x > 2 }) != -1;
private _obstruction = ((_patient getVariable [QGVAR(obstruction), [0, 0, 0]]) findIf { _x != 0 }) != -1;

if ((_occlusion || (_obstruction && !(_patient getVariable [QGVAR(overstretch), false])) ) && !(_classname in ["NPA"])) exitWith {
    [QGVAR(airwayFeedback), [_medic, LLSTRING(AirwayStatus_NotClearForItem)], _medic] call CBA_fnc_targetEvent;
    [_medic, _usedItem] call ACEFUNC(common,addToInventory);
};
_patient setVariable [QGVAR(airway), true, true];
_patient setVariable [QGVAR(airway_item), _classname, true];
switch (true) do {
    case (_usedItem isEqualTo "kat_larynx"): {
        _patient setVariable [QGVAR(airwayStatus), [1, 1, 0], true];
        private _obstruction = _patient getVariable [QGVAR(obstruction), [0, 0, 0]];
        private _newObstruction = [0, 0, _obstruction select 2];
        _patient setVariable [QGVAR(obstruction), _newObstruction, true];
    };
    case (_usedItem isEqualTo "kat_IGEL"): {
        _patient setVariable [QGVAR(airwayStatus), [1, 1, 0], true];
        private _obstruction = _patient getVariable [QGVAR(obstruction), [0, 0, 0]];
        private _newObstruction = [0, 0, _obstruction select 2];
        _patient setVariable [QGVAR(obstruction), _newObstruction, true];
    };
    case (_usedItem isEqualTo "kat_ETT"): {
        _patient setVariable [QGVAR(airwayStatus), [1, 1, 1], true];
        _patient setVariable [QGVAR(obstruction), [0, 0, 0], true];
        [GVAR(PlaceETT), "keydown"] call CBA_fnc_removeKeyHandler;
        _patient setVariable [QGVAR(visualizationActive), false, true];
    };
    case (_usedItem isEqualTo "kat_NPA"): {
        _patient setVariable [QGVAR(airwayStatus), [1, 0, 0], true];
    };
    case (_usedItem isEqualTo "kat_guedel"): {
        _patient setVariable [QGVAR(airwayStatus), [1, 0, 0], true];
        private _obstruction = _patient getVariable [QGVAR(obstruction), [0, 0, 0]];
        private _newObstruction = [0, _obstruction select 1, _obstruction select 2];
        _patient setVariable [QGVAR(obstruction), _newObstruction, true];
    };
    default {};
};

if (_classname in ["Larynxtubus", "IGEL", "ETT"]) then {
    private _currentMonitors = _patient getVariable [QEGVAR(breathing,etco2Monitor), []];
    _currentMonitors pushBack _classname;
    _patient setVariable [QEGVAR(breathing,etco2Monitor), _currentMonitors, true];
    if (QGVAR(capnographEnable)) then {
        [QGVAR(capnoPFH), [_patient], _patient] call CBA_fnc_targetEvent;
    };
};
[_patient, _usedItem] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", LSTRING(airway_log), [[_medic] call ACEFUNC(common,getName), getText (configFile >> "CfgWeapons" >> _usedItem >> "displayName")]] call ACEFUNC(medical_treatment,addToLog);
