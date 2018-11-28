/*
 * Author: Katalam
 * Handler for airway damage.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Hit Selection <STRING>
 * 2: Amount Of Damage <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "leg_l", 2] call kat_aceAirway_fnc_handleDamage_airway;
 *
 * Public: No
 */

params ["_unit", "", "_amountOfDamage"];

if !(kat_aceAirway_enable) exitWith {};

//if !(_selectionName in ["head", "neck", "face_hub", "body"]) exitWith {};

if (_amountOfDamage > 0.5) then {
  if (random(100) <= kat_aceAirway_probability_collapsed) then {
    if !(_unit getVariable ["ace_medical_airwayCollapsed", false]) then {
      _unit setVariable ["ace_medical_airwayCollapsed", true, true];
    };
  };
};
