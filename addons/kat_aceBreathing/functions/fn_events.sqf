/*
 * Author: Katalam
 * CBA Events function
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceBreathing_fnc_events;
 *
 * Public: No
 */

["treatmentPulsoximeter", {_this call kat_aceAirway_fnc_treatmentAdvanced_pulsoximeterLocal}] call CBA_fnc_addEventHandler;
