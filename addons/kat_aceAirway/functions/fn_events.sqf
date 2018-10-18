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
 * call kat_aceAirway_fnc_events;
 *
 * Public: No
 */

["treatmentLarynx", {_this call kat_aceAirway_fnc_treatmentAdvanced_larynxLocal}] call CBA_fnc_addEventHandler;
["treatmentGuedel", {_this call kat_aceAirway_fnc_treatmentAdvanced_guedelLocal}] call CBA_fnc_addEventHandler;
["treatmentAccuvac", {_this call kat_aceAirway_fnc_treatmentAdvanced_accuvacLocal}] call CBA_fnc_addEventHandler;
