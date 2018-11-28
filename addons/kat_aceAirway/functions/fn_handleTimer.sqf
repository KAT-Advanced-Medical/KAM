/*
 * Author: Katalam
 * Death time handler for airway damage
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Time <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, CBA_missionTime] call kat_aceAirway_fnc_handleTimer;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], "_time"];

if (!local _unit) exitWith {
  ["deathTimerA", [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
};

if (kat_aceBreathing_enable) exitWith {
  ["deathTimerB", [_unit, CBA_missionTime], _unit] call CBA_fnc_targetEvent;
};

if !(kat_aceAirway_enable) exitWith {};

[{
  params ["_args", "_idPFH"];
  _args params ["_unit", "_startTime"];
  private _alive = _unit getVariable ["ACE_isUnconscious", false];
  if ((_alive || _unit getVariable ["kat_aceAirway_airway", false]) && !(_unit getVariable ["ace_medical_airwayOccluded", false])) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
  };
  if ((CBA_missionTime - _startTime >= kat_aceAirway_deathTimer) && ((!(_unit getVariable ["kat_aceAirway_overstretch", false]) && _unit getVariable ["ace_medical_airwayCollapsed", false]) || _unit getVariable ["ace_medical_airwayOccluded", false])) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
    [_unit, true] call ace_medical_fnc_setDead;
  };
}, 1, [_unit, _time]] call CBA_fnc_addPerFrameHandler;
