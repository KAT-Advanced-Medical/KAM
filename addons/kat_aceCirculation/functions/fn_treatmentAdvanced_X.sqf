/*
 * Author: Katalam
 * Handle the X Series Defi for the patient.
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_aceCirculation_fnc_treatmentAdvanced_X
 *
 * Public: No
 */

params ["_player", "_target"];

if (_target getVariable ["kat_aceCirculation_X", false]) exitWith {
  private _output = localize "STR_KAT_aceCirculation_X_already";
  [_output, 1.5, _player] call ace_common_fnc_displayTextStructured;
};

_target setVariable ["kat_aceCirculation_X", true, true];
_player setVariable ["kat_aceCirculation_use", true, true];

if (_target getVariable ["ace_medical_heartRate", 80] > 0) then {
  playsound3D ["kat_aceCirculation\sounds\noshock.wav", _target, false, getPosASL _target, 8, 1, 15];
};

// medical menu log
private _string = "HR: %1 BP: %2/%3";
[{
  params ["_args", "_idPFH"];
  _args params ["_string", "_target"];
	if !(_target getVariable ["kat_aceCirculation_X", false]) exitWith {
		[_idPFH] call CBA_fnc_removePerFrameHandler;
	};
	[_target, "quick_view", _string, [round (_target getVariable ["ace_medical_heartRate", 80]), (round (_target getVariable ["ace_medical_bloodPressure", [80,120]] select 1)), (round (_target getVariable ["ace_medical_bloodPressure", [80,120]] select 0))]] call ace_medical_fnc_addToLog;
}, 1, [_string, _target]] call CBA_fnc_addPerFrameHandler;

// 300 sec is maximum for monitoring, then you have to connect it again. It's more something that you can't forget to remove it.
[{
  params ["_player", "_target"];
  (_target distance2D _player) > 50;
}, {
  params ["_player", "_target"];
  _target setVariable ["kat_aceCirculation_X", false, true];
  private _output = localize "STR_KAT_aceCirculation_X_Action_Remove";
  [_output, 1.5, _player] call ace_common_fnc_displayTextStructured;
  _target setVariable ['kat_aceCirculation_X', false, true];
  _player setVariable ['kat_aceCirculation_use', false, true];
}, [_player, _target], 300, {
  params ["_player", "_target"];
  _target setVariable ["kat_aceCirculation_X", false, true];
  private _output = localize "STR_KAT_aceCirculation_X_Action_Remove";
  [_output, 1.5, _player] call ace_common_fnc_displayTextStructured;
  _target setVariable ['kat_aceCirculation_X', false, true];
  _player setVariable ['kat_aceCirculation_use', false, true];
}] call CBA_fnc_waitUntilAndExecute;

// the heart rate sound
[_target, _player] spawn {
  params ["_target", "_player"];
  while {_target getVariable ["kat_aceCirculation_X", false]} do {
    private _hr = _target getVariable ["ace_medical_heartRate", 80];
    if (_hr <= 0) then {
      private _soundPath1 = _player getVariable ["kat_aceCirculation_X_sound1", "kat_aceCirculation\sounds\noheartrate.wav"];
      playsound3D [_soundPath1, _target, false, getPosASL _target, 5, 1, 15];
      sleep 1.48;
    } else {
      private _sleep = 60 / _hr;
      private _soundPath2 = _player getVariable ["kat_aceCirculation_X_sound2", "kat_aceCirculation\sounds\heartrate.wav"];
      playsound3D [_soundPath2, _target, false, getPosASL _target, 8, 1, 15];
      sleep 0.25;
      sleep _sleep;
    };
  };
};
