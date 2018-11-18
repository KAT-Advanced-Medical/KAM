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
 * [player, cursorTarget] call kat_aceDisability_fnc_treatmentAdvanced_trachea;
 *
 * Public: No
 */

params ["_unit", "_target"];

if (local _target) then {
  ["treatmentTrachea", [_unit, _target]] call CBA_fnc_localEvent;
} else {
  ["treatmentTrachea", [_unit, _target], _target] call CBA_fnc_targetEvent;
};
