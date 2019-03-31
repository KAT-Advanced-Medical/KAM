#include "script_component.hpp"
/*
 * Author: Katalam
 * Handler for airway damage.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_airway_fnc_handleAirway;
 *
 * Public: No
 */

params ["_unit"];

if !(GVAR(enable)) exitWith {};

//if !(_selectionName in ["head", "neck", "face_hub", "body"]) exitWith {};
// it doesn't make sense to restrict it on the head. 'Cause unconcious state is the reason and not the damage selection


if (random(100) <= GVAR(probability_obstruction)) then {
    if !(_unit getVariable [QGVAR(obstruction), false]) then {
        _unit setVariable [QGVAR(obstruction), true, true];
        [_unit, CBA_missionTime] call FUNC(handleTimer);
    };
};
