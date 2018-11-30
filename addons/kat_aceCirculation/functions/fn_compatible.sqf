/*
 * Author: Katalam
 * Handle the compatibility for blood and patient.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Class Name <STRING>
 *
 * Return Value:
 * Compatible <BOOLEAN>
 *
 * Example:
 * [cursorTarget, 'BloodIV_AB'] call kat_aceCirculation_fnc_compatible;
 *
 * Public: No
 */

params ["_unit", "_className"];

private _bloodType = _unit getVariable ["kat_aceCirculation_bloodtype", "O"];
private _compatibility = getArray (configFile >> "ACE_Medical_Advanced" >> "Treatment" >> "IV" >> _className >> "compatibility");
if (_bloodType in _compatibility) exitWith {true};
false;
