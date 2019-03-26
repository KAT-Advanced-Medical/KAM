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
 * call kat_aceDisability_fnc_events;
 *
 * Public: No
 */

["treatmentClothes", {_this call kat_aceDisability_fnc_treatmentAdvanced_clothesLocal}] call CBA_fnc_addEventHandler;
["treatmentTrachea", {_this call kat_aceDisability_fnc_treatmentAdvanced_tracheaLocal}] call CBA_fnc_addEventHandler;
["treatmentFts", {_this call kat_aceDisability_fnc_treatmentAdvanced_ftsLocal}] call CBA_fnc_addEventHandler;
