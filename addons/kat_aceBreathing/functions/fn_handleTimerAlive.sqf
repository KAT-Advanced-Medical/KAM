/*
 * Author: Katalam
 * Handling alive timer for breathing
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Time <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, CBA_missionTime] call kat_aceBreathing_fnc_handleTimerAlive;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], "_time"];

if !(kat_aceBreathing_enable) exitWith {};

if (!local _unit) then {
 ["aliveTimerB", [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
};

[{
  params ["_args", "_idPFH"];
  _args params ["_unit", "_startTime"];
  if (_unit getVariable ["ace_medical_airwayStatus", 100] isEqualTo 100) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
  };
  if (CBA_missionTime - _startTime > 100) then {
    private _newValue = (_unit getVariable ["ace_medical_airwayStatus", 100]) + kat_aceBreathing_spo2_after_value; // You have 110 sec to get back to 100 % saturation if you waked up at 70 with 1 and 0.2
    _unit setVariable ["ace_medical_airwayStatus", _newValue, true];
  } else {
    private _newValue = (_unit getVariable ["ace_medical_airwayStatus", 100]) + kat_aceBreathing_spo2_before_value;
    _unit setVariable ["ace_medical_airwayStatus", _newValue, true];
  };
}, 1, [_unit, _time]] call CBA_fnc_addPerFrameHandler;
