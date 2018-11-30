/*
 * Author: Katalam
 * Reports a blood type depending on the unit.
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * 0: Blood type <STRING>
 *
 * Example:
 * [cursorTarget] call kat_aceCirculation_fnc_bloodType;
 *
 * Public: No
 */

params ["_target"];

_target getVariable ["kat_aceCirculation_bloodtype", "O"];
