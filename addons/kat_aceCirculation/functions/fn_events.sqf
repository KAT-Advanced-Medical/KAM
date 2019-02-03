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
 * call kat_aceCirculation_fnc_events;
 *
 * Public: No
 */

["treatmentIVfalse", {_this call kat_aceCirculation_fnc_treatmentAdvanced_IV}] call CBA_fnc_addEventHandler;
["IVreset", {_this call kat_aceCirculation_fnc_removeEffect_IV}] call CBA_fnc_addEventHandler;

["ace_settingsInitialized", {
    if !(kat_aceCirculation_variableHR_enable) exitWith {};
    [kat_aceCirculation_fnc_handleHR, [], 10] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
