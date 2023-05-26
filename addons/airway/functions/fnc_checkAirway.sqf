#include "script_component.hpp"
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

private _messageairwayobstruction = LLSTRING(message_obstruction_no);
private _messageairwayOccluded = LLSTRING(message_Occluded_no);
private _obstruction = LSTRING(noObstruction);
private _occluded = LSTRING(noOccluded);

if (_patient getVariable [QGVAR(obstruction), false]) then {
    _messageairwayobstruction = LLSTRING(message_obstruction_yes);
    _obstruction = LSTRING(obstruction);
    if (_patient getVariable [QGVAR(overstretch), false]) then {
        _messageairwayobstruction = LLSTRING(message_obstructionTemporarilyMitigated);
        _obstruction = LLSTRING(mitigatedObstruction);
    };
    if (GVAR(autoTriage)) then {
        _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
    };
};
if (_patient getVariable [QGVAR(occluded), false]) then {
    _messageairwayOccluded = LLSTRING(message_Occluded_yes);
    _occluded = LSTRING(Occluded);
    if (GVAR(autoTriage)) then {
        _patient setVariable [QACEGVAR(medical,triageLevel), 3, true];
    };
};
if (!(_patient getVariable [QGVAR(occluded), false] && _patient getVariable [QGVAR(obstruction), false]) && GVAR(autoTriage)) then {_patient setVariable [QACEGVAR(medical,triageLevel), 0, true]};
private _message = format ["%1, %2", _messageairwayobstruction, _messageairwayOccluded];
[_message, 2, _medic] call ACEFUNC(common,displayTextStructured);

[_patient, "activity", LSTRING(checkAirway_log), [[_medic] call ACEFUNC(common,getName), _obstruction, _occluded]] call ACEFUNC(medical_treatment,addToLog);
