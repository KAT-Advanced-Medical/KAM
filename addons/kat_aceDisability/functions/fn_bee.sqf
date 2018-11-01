/*
 * Author: Katalam
 * Function for the allergical reaction to a bee thing
 *
 * Arguments:
 * 0: _target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_aceDisability_fnc_bee;
 *
 * Public: No
 */

diag_log _this;

params ["_unit"];

_unit setVariable ["kat_aceDisability_allergicalreaction", true, true];
_unit setVariable ["kat_aceAirway_swollen", true, true];
_message = localize "STR_kat_aceDisability_feelingbad";
[_message, 1.5, _unit] call ace_common_fnc_displayTextStructured;
[{[_this select 0, true] call ace_medical_fnc_setUnconscious}, [_unit], 10] call CBA_fnc_waitAndExecute;

/*
if (kat_aceAirway_enable) then {
  _unit setVariable ["kat_aceAirway_swollen", true];
  [{
    params ["_args", "_idPFH"];
    _args params ["_unit", "_startTime"];
    if !(_unit getVariable ["kat_aceDisability_allergicalreaction", false]) then {
      [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    if ((CBA_missionTime - _startTime >= kat_aceAirway_deathTimer) && (_unit getVariable ["kat_aceDisability_allergicalreaction", false])) exitWith {
      [_idPFH] call CBA_fnc_removePerFrameHandler;
      _unit call ace_medical_fnc_setDead;
    };
    _a = (_unit getVariable "ace_medical_airwayStatus") - 0.1;
    _unit setVariable ["ace_medical_airwayStatus", _a];
  }, 1, [_unit, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;
};
*/

true;
