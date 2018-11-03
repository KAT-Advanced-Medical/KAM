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
  private _alive = _unit getVariable ["ACE_isUnconscious", false];
  if (_alive || _unit getVariable ["ace_medical_occluded", false] || _unit getVariable ["ace_medical_collapsed", false]) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
    ["aliveTimerB", [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
  };
  if (_unit getVariable ["ace_medical_airwayStatus", 100] isEqualTo 0) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
    [_unit, true] call ace_medical_fnc_setDead;
  };
  if (CBA_missionTime - _startTime > 60) then {
    private _newValue = (_unit getVariable ["ace_medical_airwayStatus", 100]) - 1;
    _unit setVariable ["ace_medical_airwayStatus", _newValue, true];
  } else {
    private _newValue = (_unit getVariable ["ace_medical_airwayStatus", 100]) - 0.2;
    _unit setVariable ["ace_medical_airwayStatus", _newValue, true];
  };
}, 1, [_unit, _time]] call CBA_fnc_addPerFrameHandler;
