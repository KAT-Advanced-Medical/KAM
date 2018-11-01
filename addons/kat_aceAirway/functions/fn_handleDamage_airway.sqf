/*
 * Author: Katalam
 * Handling of the airway injuries.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Name Of Hit Selection <STRING>
 * 2: Amount Of Damage <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, "leg", 2] call kat_aceAirway_fnc_handleDamage_airway
 *
 * Public: No
 */

params ["_unit", "_selectionName", "_amountOfDamage"];

if !(kat_aceAirway_enable) exitWith {};

//if !(_selectionName in ["head", "neck", "face_hub", "body"]) exitWith {};

if (_amountOfDamage > 0.5) then {
  if (random(100) <= kat_aceAirway_probability_collapsed) then {
    if !(_unit getVariable ["ace_medical_airwayCollapsed", false]) then {
      _unit setVariable ["ace_medical_airwayCollapsed", true, true];
    };
  };
  if (random(100) <= kat_aceAirway_probability_occluded) then {
    if !(_unit getVariable ["ace_medical_airwayOccluded", false] && (_unit getVariable ["kat_aceAirway_airway_item", ""] isEqualTo "larynx")) then {
      _unit setVariable ["ace_medical_airwayOccluded", true, true];
    };
  };
};
