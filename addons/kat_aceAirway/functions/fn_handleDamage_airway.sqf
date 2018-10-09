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

if (false) exitWith {}; // TO-DO CBA getVariable

if !(_selectionName isEqualTo "head") exitWith {};

[{
  if (_unit getVariable ["ace_medical_inReviveState", false]) then {
    if (_amountOfDamage > 0.5) then {
      if (random(1) >= 0.8) then {
        if !(_unit getVariable["ace_medical_airwayCollapsed", false]) then {
          _unit setVariable ["ace_medical_airwayCollapsed", true, true];
          [_unit, serverTime, "C"] call kat_aceAirway_fnc_handleDie;
        };
      };
    if (random[0, 50, 100] isEqualTo 1) then {
      if !(_unit getVariable["ace_medical_airwayOccluded", false]) then {
        _unit setVariable ["ace_medical_airwayOccluded", true, true];
        [_unit, serverTime, "O"] call kat_aceAirway_fnc_handleDie;
      };
    };
  };
};
}, [], 2] call CBA_fnc_waitAndExecute;
