/*
 * Author: Katalam
 * Condition for medical action
 *
 * Arguments:
 * 0: _target <OBJECT>
 *
 * Return Value:
 * True or false
 *
 * Example:
 * call kat_aceDisability_fnc_condition_clothes;
 *
 * Public: No
 */

params ["_target"];

if !([_target] call ace_common_fnc_isAwake) then {
  if (uniform _target != "") then {
    true;
  } else {
    false;
  };
} else {
  false;
};
