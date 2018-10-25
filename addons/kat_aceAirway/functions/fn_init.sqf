/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceAirway_fnc_init
 *
 * Public: No
 */

params ["_unit"];

// ace_medical_airwayCollapsed
// ace_medical_airwayOccluded
_unit setVariable ["kat_aceAirway_airway", false];
_unit setVariable ["kat_aceAirway_airway_item", ""];
_unit setVariable ["kat_aceAirway_overstretch", false];
_unit setVariable ["kat_aceAirway_swollen", false];
