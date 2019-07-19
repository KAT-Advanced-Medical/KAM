#include "script_component.hpp"
/*
 * Author: Katalam
 * Overstretch the head of the patient for airway management without items
 *
 * Arguments:
 * 0: Soldier <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget] call KAM_airway_fnc_treatmentAdvanced_overstretchHead;
 *
 * Public: No
 */

params ["_player", "_target"];

// to-do animation!

_target setVariable [QGVAR(headtilt), true, true];

private _output = localize LSTRING(headtilt_info);
[_output, 2, _player] call ace_common_fnc_displayTextStructured;

true;

/*
 * ((eyeDirection player) select 2) < -0.02
 * Works great
 */
