#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_airway_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
if (!local _patient) exitWith {};
if !(GVAR(enable)) exitWith {};
KAT_forceWakeup = false;

TRACE_1("handleUncon",_patient);
private _airwayItem = _patient getVariable [QGVAR(airway_item), ""];
private _noSurgicalAirway = (_airwayItem isNotEqualTo "Surgical_Airway");
if (_noSurgicalAirway) then {
    _patient setVariable [QGVAR(airway), false, true];
    _patient setVariable [QGVAR(clearedTime), 0, true];
    _patient setVariable [QGVAR(cricothyrotomy), 0, true];
    private _item = _patient getVariable [QGVAR(airway_item), ""];
    private _currentMonitors = _patient getVariable [QEGVAR(breathing,etco2Monitor), []];
    _currentMonitors deleteAt (_currentMonitors find _item);
    _patient setVariable [QEGVAR(breathing,etco2Monitor), _currentMonitors, true];
    _patient setVariable [QGVAR(airway_item), "", true];
};
_patient call FUNC(handleAwakePuking);
_patient setVariable [QGVAR(occlusionMitigation), [0, 0, 0], true];
_patient setVariable [QGVAR(obstruction), [0, 0, 0], true];
_patient setVariable [QGVAR(overstretch), false, true];
_patient setVariable [QGVAR(recovery), false, true];
_patient setVariable [QGVAR(airwayStatus), [0, 0, 0], true];
_patient setVariable [QGVAR(isVisualized), false, true];
_patient setVariable ["kat_occlusion_PFH", false, true];
_patient setVariable ["kat_pukeActive_PFH", false, true];
[{
        params ["_args", "_idPFH"];
        _args params ["_patient"];

        private _isUnconscious   = _patient getVariable ["ACE_isUnconscious", false];
        private _alive           = alive _patient;
        private _stomachVolume  = _patient getVariable [QGVAR(stomachVolume), 5];
        if (!_alive || (_stomachVolume == 5) || _isUnconscious) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        _patient setVariable [QGVAR(stomachVolume), (_stomachVolume + 1), true];
    }, 
    300, 
    [_patient]] call CBA_fnc_addPerFrameHandler;
