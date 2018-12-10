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

["treatmentPulseoximeter", {_this call kat_aceBreathing_fnc_treatmentAdvanced_pulseoximeterLocal}] call CBA_fnc_addEventHandler;
["deathTimerBreathing", {_this call kat_aceBreathing_fnc_handleTimer}] call CBA_fnc_addEventHandler;
["aliveTimerBreathing", {_this call kat_aceBreathing_fnc_handleTimerAlive}] call CBA_fnc_addEventHandler;

["ace_unconscious", {
  params ["_unit", "_state"];
  if !(_state) exitWith {};
  if (_unit getVariable ["ace_medical_airwayCollapsed", false] || _unit getVariable ["ace_medical_airwayOccluded", false]) then {
    [_unit, CBA_missionTime] call kat_aceBreathing_fnc_handleTimer;
  };
}] call CBA_fnc_addEventHandler;
