#include "..\script_component.hpp"
/*
 * Author: Katalam, Cplhardcore
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

private _hintAirwayStatus = LLSTRING(AirwayStatus_noAirwayInjuries);
private _airwayStatus = LSTRING(AirwayStatus_noAirwayInjuries_short);
private _obstructionState = _patient getVariable [QGVAR(obstruction), [0, 0, 0]];
private _occlusionState = _patient getVariable [QGVAR(occlusion), [0, 0, 0]];
private _catastrophicState = _patient getVariable [QGVAR(catastrophicAirway), [false, false]];
private _hasPuked = _patient getVariable [QGVAR(hasPuked), false];
private _hintWidth = 14;
private _hintSize = 2;
switch (true) do {
        case (_catastrophicState select 0): {
            _hintWidth = 17;
            _hintAirwayStatus = LLSTRING(AirwayStatus_OralCatastrophic);
            _airwayStatus = LSTRING(AirwayStatus_OralCatastrophic_short);
            if (GVAR(autoTriage)) then {
                _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
            };
        };
        case (_catastrophicState select 1): {
            _hintWidth = 17;
            _hintAirwayStatus = LLSTRING(AirwayStatus_Catastrophic);
            _airwayStatus = LSTRING(AirwayStatus_Catastrophic_short);
            if (GVAR(autoTriage)) then {
                _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
            };
        };
        case ((_obstructionState select 0 > 0) && (_occlusionState select 0 > 0) && _hasPuked): {
            _hintWidth = 17;
            _hintAirwayStatus = LLSTRING(AirwayStatus_OralTongueBloodPukeObstruction);
            _airwayStatus = LSTRING(AirwayStatus_OralTongueBloodPukeObstruction_short);
            if (_patient getVariable [QGVAR(overstretch), false]) then {
                _hintAirwayStatus = LLSTRING(AirwayStatus_mitigatedObstruction);
                _airwayStatus = LLSTRING(AirwayStatus_mitigatedObstruction_short);
            };
            if (GVAR(autoTriage)) then {
                _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
            };
        };
        case ((_obstructionState select 0 > 0) && (_occlusionState select 0 > 0)): {
            _hintWidth = 17;
            _hintAirwayStatus = LLSTRING(AirwayStatus_OralTongueBloodObstruction);
            _airwayStatus = LSTRING(AirwayStatus_OralTongueBloodObstruction_short);
            if (_patient getVariable [QGVAR(overstretch), false]) then {
                _hintAirwayStatus = LLSTRING(AirwayStatus_mitigatedObstruction);
                _airwayStatus = LLSTRING(AirwayStatus_mitigatedObstruction_short);
            };
            if (GVAR(autoTriage)) then {
                _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
            };
        };
        case (_obstructionState select 0 > 0): {
            _hintWidth = 17;
            _hintAirwayStatus = LLSTRING(AirwayStatus_OralTongueObstruction);
            _airwayStatus = LSTRING(AirwayStatus_OralTongueObstruction_short);
            if (_patient getVariable [QGVAR(overstretch), false]) then {
                _hintAirwayStatus = LLSTRING(AirwayStatus_mitigatedObstruction);
                _airwayStatus = LLSTRING(AirwayStatus_mitigatedObstruction_short);
            };
            if (GVAR(autoTriage)) then {
                _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
            };
        };
        case ((_occlusionState select 0 > 0) && _hasPuked): {
            _hintWidth = 17;
            _hintAirwayStatus = LLSTRING(AirwayStatus_OralBloodPukeOcclusion);
            _airwayStatus = LSTRING(AirwayStatus_OralBloodPukeOcclusion_short);
            if (GVAR(autoTriage)) then {
                _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
            };
        };
        case (_occlusionState select 0 > 0): {
            _hintWidth = 17;
            _hintAirwayStatus = LLSTRING(AirwayStatus_OralBloodOcclusion);
            _airwayStatus = LSTRING(AirwayStatus_OralBloodOcclusion_short);
            if (GVAR(autoTriage)) then {
                _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
            };
        };
        case ((_obstructionState select 1 > 0) || (_obstructionState select 2 > 0)): {
            _hintWidth = 17;
            _hintAirwayStatus = LLSTRING(AirwayStatus_Obstruction);
            _airwayStatus = LSTRING(AirwayStatus_Obstruction_short);
            if (_patient getVariable [QGVAR(overstretch), false]) then {
                _hintAirwayStatus = LLSTRING(AirwayStatus_mitigatedObstruction);
                _airwayStatus = LLSTRING(AirwayStatus_mitigatedObstruction_short);
            };
            if (GVAR(autoTriage)) then {
                _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
            };
        };
        case (((_occlusionState select 1 > 0) || (_occlusionState select 2 > 0)) && _hasPuked): {
            _hintWidth = 17;
            _hintAirwayStatus = LLSTRING(AirwayStatus_BloodPukeOcclusion);
            _airwayStatus = LSTRING(AirwayStatus_BloodPukeOcclusion_short);
            if (GVAR(autoTriage)) then {
                _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
            };
        };
        case ((_occlusionState select 1 > 0) || (_occlusionState select 2 > 0)): {
            _hintWidth = 17;
            _hintAirwayStatus = LLSTRING(AirwayStatus_BloodOcclusion);
            _airwayStatus = LSTRING(AirwayStatus_BloodOcclusion_short);
            if (GVAR(autoTriage)) then {
                _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
            };
        };
        default {
            _hintAirwayStatus = LLSTRING(AirwayStatus_Clear);
            _hintSize = 1.5;
            _hintWidth = 10;
            };
};


if ((((_patient getVariable [QGVAR(occlusion), [0, 0, 0]]) findIf { _x != 0 }) != -1) && (((_patient getVariable [QGVAR(obstruction), [0, 0, 0]]) findIf { _x != 0 }) != -1) && GVAR(autoTriage)) then {_patient setVariable [QACEGVAR(medical,triageLevel), 0, true]};



if (_patient getVariable [QEGVAR(chemical,airPoisoning), false]) exitWith {
    _hintAirwayStatus = LLSTRING(AirwayStatus_Poison);

    [_hintAirwayStatus, _hintSize, _medic, _hintWidth] call ACEFUNC(common,displayTextStructured);
    [_patient, "quick_view", LSTRING(checkAirway_log)] call EFUNC(circulation,removeLog);
    [_patient, "quick_view", LSTRING(checkAirway_poisonLog)] call EFUNC(circulation,removeLog);
    [_patient, "quick_view", LSTRING(checkAirway_poisonLog), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
};

[_hintAirwayStatus, _hintSize, _medic, _hintWidth] call ACEFUNC(common,displayTextStructured);

[_patient, "quick_view", LSTRING(checkAirway_log)] call EFUNC(circulation,removeLog);
[_patient, "quick_view", LSTRING(checkAirway_log), [[_medic] call ACEFUNC(common,getName), _airwayStatus]] call ACEFUNC(medical_treatment,addToLog);
