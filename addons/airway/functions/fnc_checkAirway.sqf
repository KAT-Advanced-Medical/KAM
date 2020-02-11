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

params ["_player", "_target"];

private _messageairwayobstruction = localize LSTRING(message_obstruction_no);
private _messageairwayOccluded = localize LSTRING(message_Occluded_no);
private _yesornoobstruction = LSTRING(N);
private _yesornoOccluded = LSTRING(N);

if (_target getVariable [QGVAR(obstruction), false]) then {
    _messageairwayobstruction = localize LSTRING(message_obstruction_yes);
    _yesornoobstruction = "";
    _target setVariable [QEGVAR(medical,triageLevel), 3, true];
};
if (_target getVariable ["KAT_medical_airwayOccluded", false]) then {
    _messageairwayOccluded = localize LSTRING(message_Occluded_yes);
    _yesornoOccluded = "";
    _target setVariable [QEGVAR(medical,triageLevel), 3, true];
};
if !(_target getVariable ["KAT_medical_airwayOccluded", false] && _target getVariable [QGVAR(obstruction), false]) then {_target setVariable [QEGVAR(medical,triageLevel), 0, true]};
private _message = format ["%1, %2", _messageairwayobstruction, _messageairwayOccluded];
[_message, 2, _player] call ace_common_fnc_displayTextStructured;

[_target, "activity", LSTRING(checkAirway_log), [[_player] call ace_common_fnc_getName, _yesornoobstruction, LSTRING(obstruction), _yesornoOccluded, LSTRING(Occluded)]] call ace_medical_treatment_fnc_addToLog;
[_target, "quick_view", LSTRING(checkAirway_log), [[_player] call ace_common_fnc_getName, _yesornoobstruction, LSTRING(obstruction), _yesornoOccluded, LSTRING(Occluded)]] call ace_medical_treatment_fnc_addToLog;
