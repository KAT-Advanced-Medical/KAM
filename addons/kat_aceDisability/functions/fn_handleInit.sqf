/*
 * Author: Katalam
 * Handles the initialisation.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceDisability_fnc_handleInit;
 *
 * Public: No
 */

params ["_unit"];

// To-Do: is this even functional?
_unit addEventHandler ["EpeContactStart", {
	params ["_object1", "_object2", "_selection1", "_selection2", "_force"];
  if (_object2 isEqualTo "HoneyBee") then {
    _object1 call kat_aceDisability_fnc_bee;
  };
}];
_unit call kat_aceDisability_fnc_init;
