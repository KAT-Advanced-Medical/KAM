#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Checks need of airway management
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_checkAirway;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _hintAirwayObstruction = LLSTRING(AirwayStatus_noObstruction);
private _hintAirwayOcclusion = LLSTRING(AirwayStatus_noOcclusion);
private _obstruction = LSTRING(AirwayStatus_noObstruction_short);
private _occlusion = LSTRING(AirwayStatus_noOcclusion_short);

private _hintWidth = 14;
private _hintSize = 2;

if (_patient getVariable [QGVAR(obstruction), false]) then {
    _hintWidth = 17;
    _hintAirwayObstruction = LLSTRING(AirwayStatus_Obstruction);
    _obstruction = LSTRING(AirwayStatus_Obstruction_short);
    if (_patient getVariable [QGVAR(overstretch), false]) then {
        _hintAirwayObstruction = LLSTRING(AirwayStatus_mitigatedObstruction);
        _obstruction = LLSTRING(AirwayStatus_mitigatedObstruction_short);
    };
    if (GVAR(autoTriage)) then {
        _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
    };
};
if (_patient getVariable [QGVAR(occluded), false]) then {
    _hintAirwayOcclusion = LLSTRING(AirwayStatus_Occlusion);
    _occlusion = LSTRING(AirwayStatus_Occlusion_short);
    if (GVAR(autoTriage)) then {
        _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
    };
};
if (!(_patient getVariable [QGVAR(occluded), false] && _patient getVariable [QGVAR(obstruction), false]) && GVAR(autoTriage)) then {_patient setVariable [QACEGVAR(medical,triageLevel), 0, true]};

private _message = format ["%1<br />%2", _hintAirwayObstruction, _hintAirwayOcclusion];

if (!(_patient getVariable [QGVAR(occluded), false]) && !(_patient getVariable [QGVAR(obstruction), false])) then {
    _message = LLSTRING(AirwayStatus_Clear);
    _hintSize = 1.5;
    _hintWidth = 10;
};

[_message, _hintSize, _medic, _hintWidth] call ACEFUNC(common,displayTextStructured);

[_patient, "quick_view", LSTRING(checkAirway_log)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(checkAirway_log), [[_medic] call ACEFUNC(common,getName), _obstruction, _occlusion]] call ACEFUNC(medical_treatment,addToLog);
