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
 * call kat_aceBreathing_fnc_events;
 *
 * Public: No
 */

["treatmentPulsoxymeter", {_this call kat_aceBreathing_fnc_treatmentAdvanced_pulsoxymeterLocal}] call CBA_fnc_addEventHandler;
/*
["ace_unconscious", {
  params ["_unit", "_state"];
  if !(_state) exitWith {
    _unit call kat_aceAirway_fnc_init;
  };
  if (_unit getVariable ["ace_medical_airwayCollapsed", false] || _unit getVariable ["ace_medical_airwayOccluded", false]) then {
    [_unit, CBA_missionTime] call kat_aceAirway_fnc_handleTimer;
  };
}] call CBA_fnc_addEventHandler;
*/
//The handle for oxygen saturation
