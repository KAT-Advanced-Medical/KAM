/*
 * Author: Katalam
 * Handling death timer for airway injuries
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceAirway_fnc_handleTimer;
 *
 * Public: No
 */

params ["_unit", "_time", "_timeWithoutAir"];

if !(local _unit) then {
  ["deathTimer", ["_unit", CBA_missionTime, kat_aceAirway_deathTimer], _unit] call CBA_fnc_targetEvent;
};

if !(_unit getVariable ["ACE_isUnconscious", false]) exitWith {};

[{
  params ["_args", "_idPFH"];
  _args params ["_unit", "_startTime"];
  _alive = _unit getVariable ["ACE_isUnconscious", false];
  if (_alive || _unit getVariable ["kat_aceAirway_airway", false]) then {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
  };
  if ((CBA_missionTime - _startTime >= kat_aceAirway_deathTimer) && (!(_unit getVariable ["kat_aceAirway_airway", false]) && !(_unit getVariable ["kat_aceAirway_overstretch", false]))) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
    _unit call ace_medical_fnc_setDead;
  };
  _a = (_unit getVariable "ace_medical_airwayStatus") - 0.1;
  _unit setVariable ["ace_medical_airwayStatus", _a];
}, 1, [_unit, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;
