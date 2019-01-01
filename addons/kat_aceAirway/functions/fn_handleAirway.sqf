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
 * [player] call kat_aceAirway_fnc_handleAirway;
 *
 * Public: No
 */

params ["_unit"];

if !(kat_aceAirway_enable) exitWith {};

//if !(_selectionName in ["head", "neck", "face_hub", "body"]) exitWith {};
// it doesn't make sense to restrict it on the head. 'Cause unconcious state is the reason and not the damage selection


if (random(100) <= kat_aceAirway_probability_collapsed) then {
    if !(_unit getVariable ["ace_medical_airwayCollapsed", false]) then {
        _unit setVariable ["ace_medical_airwayCollapsed", true, true];
        [_unit, CBA_missionTime] call kat_aceAirway_fnc_handleTimer;
    };
};
