/*
 * Author: Katalam
 * Handling death timer for breathing
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Time <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, CBA_missionTime] call kat_aceBreathing_fnc_handleTimer;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], "_time"];

if !(kat_aceBreathing_enable) exitWith {};

if (!local _unit) then {
 ["deathTimerB", [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
};

[{
  params ["_args", "_idPFH"];
  _args params ["_unit", "_startTime"];
  private _alive = [_unit] call ace_common_fnc_isAwake;
  if (_alive || !(_unit getVariable ["ace_medical_airwayOccluded", false] || _unit getVariable ["ace_medical_airwayCollapsed", false])) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
    ["aliveTimerB", [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
  };
  if (_unit getVariable ["kat_aceAirway_overstretch", false] && !(_unit getVariable ["ace_medical_airwayOccluded", false])) exitWith {};
  if (_unit getVariable ["ace_medical_airwayStatus", 100] <= 5) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
    [_unit, true] call ace_medical_fnc_setDead;
  };
  if (CBA_missionTime - _startTime > 100) then {
    private _newValue = (_unit getVariable ["ace_medical_airwayStatus", 100]) - kat_aceBreathing_spo2_after_value; //You will have 110 sec to be forced in unconscious state with 1 and 0.2
    _unit setVariable ["ace_medical_airwayStatus", _newValue, true];
  } else {
    private _newValue = (_unit getVariable ["ace_medical_airwayStatus", 100]) - kat_aceBreathing_spo2_before_value;
    _unit setVariable ["ace_medical_airwayStatus", _newValue, true];
  };
}, 1, [_unit, _time]] call CBA_fnc_addPerFrameHandler;
