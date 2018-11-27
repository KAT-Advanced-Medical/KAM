/*
 * Author: Katalam
 * Function for the allergical reaction.
 *
 * Arguments:
 * 0: _target <OBJECT>
 * 1: _className <STRING>
 * 2: _swollen <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "HoneyBee", true] call kat_aceDisability_fnc_allergicalReaction
 *
 * Public: No
 */

params ["_unit", "_className", "_swollen"];

if !(kat_aceDisability_enable) exitWith {};

// message for the player, that he feel sick
private _message = localize "STR_kat_aceDisability_feelingbad";
[_message, 1.5, _unit] call ace_common_fnc_displayTextStructured;

// visual effect for the player
private _effect = objNull;
private _classNameEffect = objNull;
switch (random 2) do {
  case 0: {
    _classNameEffect = "ColorCorrections";
    _effect = ppEffectCreate ["ColorCorrections", 5100];
    _effect ppEffectEnable true;
    _effect ppEffectForceInNVG true;
    _effect ppEffectAdjust [
      1,
      1,
      0,
      [0, 0, 0, 0],
      [1, 1, 1, 0],
      [0.6, 0.6, 0.2, 0],
      [-1, -1, 0, 1, 0, 0, 0]
    ];
    _effect ppEffectCommit 30;
  };
  case 1: {
    _classNameEffect = "WetDistortion";
    _effect = ppEffectCreate ["WetDistortion", 300];
    _effect ppEffectEnable true;
    _effect ppEffectForceInNVG true;
    _effect ppEffectAdjust [
      1,
      0,
      1,
      4.10,
      3.70,
      2.50,
      1.85,
      0.0054,
      0.0041,
      0.05,
      0.0070,
      1,
      1,
      1,
      1
    ];
    _effect ppEffectCommit 30;
    };
    default {};
};

// set allergical reaction variable with pp effect and boolean swollen
_unit setVariable ["kat_aceDisability_allergicalreaction", [_className, _effect, _classNameEffect], true];
if !(_unit getVariable ["kat_aceAirway_swollen", false]) then {
	_unit setVariable ["kat_aceAirway_swollen", _swollen, true];
};

// hearrate adjustment for the allergical reaction
[_unit, 50, 10, {}] call ace_medical_fnc_addHeartRateAdjustment;
//[{[_this select 0, true] call ace_medical_fnc_setUnconscious}, [_unit], 30] call CBA_fnc_waitAndExecute;


true;
