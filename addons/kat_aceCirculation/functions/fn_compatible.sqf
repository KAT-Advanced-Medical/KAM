/*
 * Author: Katalam
 * Handle the compatibility for blood and patient.
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: className <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_aceCirculation_fnc_compatible
 *
 * Public: No
 */

params ["_unit", "_className"];

_bloodType = _unit getVariable ["kat_aceCirculation_bloodtype", "O"];
_compatibility = getArray (configFile >> "ACE_Medical_Advanced" >> "Treatment" >> "IV" >> _className >> "compatibility");
if (_bloodType in _compatibility) exitWith {true};
false;
