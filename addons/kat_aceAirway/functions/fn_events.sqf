/*
 * Author: Katalam
 * CBA Events function
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceAirway_fnc_events;
 *
 * Public: No
 */

["treatmentLarynx", {_this call kat_aceAirway_fnc_treatmentAdvanced_larynxLocal}] call CBA_fnc_addEventHandler;
["treatmentGuedel", {_this call kat_aceAirway_fnc_treatmentAdvanced_guedelLocal}] call CBA_fnc_addEventHandler;
["treatmentAccuvac", {_this call kat_aceAirway_fnc_treatmentAdvanced_accuvacLocal}] call CBA_fnc_addEventHandler;

["ace_unconscious", {
  params ["_unit", "_state"];
  if (_state) then {
  _unit call kat_aceAirway_fnc_init;
  } else {
    if (_unit getVariable ["ace_medical_airwayCollapsed", false] || _unit getVariable ["ace_medical_airwayOccluded", false]) then {
      [_unit, CBA_missionTime, kat_aceAirway_deathTimer] call kat_aceAirway_fnc_handleTimer;
    };
  };
}] call CBA_fnc_addEventHandler;

["deathTimer", {_this call kat_aceAirway_fnc_handleTimer}] call CBA_fnc_addEventHandler;
