/*
 * Author: Katalam
 * Function for treatment of the alergical reaction to a bee thing
 *
 * Arguments:
 * 0: _target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, hagrid, "ACE_surgicalKit"] call kat_aceDisability_fnc_treatmentAdvanced_bee;
 *
 * Public: No
 */

params ["_unit", "_target", "_removeItem"];

[_caller, _target, _removeItem] call ace_medical_fnc_useItem;

if (local _target) then {
  ["treatmentBees", [_target]] call CBA_fnc_localEvent;
} else {
  ["treatmentBees", [_target], _target] call CBA_fnc_targetEvent;
};
