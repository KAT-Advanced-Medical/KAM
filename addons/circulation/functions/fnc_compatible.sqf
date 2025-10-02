#include "..\script_component.hpp"
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
 * [cursorTarget, 'BloodIV_AB'] call kat_circulation_fnc_compatible;
 *
 * Public: No
 */

params ["_unit", "_className"];

private _bloodType = [_unit] call FUNC(bloodType);
private _compatibility = getArray (configFile >> "ACE_Medical_Treatment" >> "IV" >> _className >> "compatibility");
if (_bloodType in _compatibility) exitWith {true};

false
