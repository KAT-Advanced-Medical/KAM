/*
ADV-aceCPR - by Belbo - edited by Katalam (new syntax and different sound)
*/

params ["_args"];
_args params ["_caller", "_target"];

if !(_caller getVariable ["adv_aceCPR_var_soundplayed", false]) then {
	_caller setVariable ["adv_aceCPR_var_soundplayed", true];
	_args spawn {
		params ["_caller", "_target"];
		// 8 seconds treatment time
		playsound3D ["kat_aceCirculation\sounds\standclear.wav", _caller, false, getPosASL _caller, 5, 1, 15]; // 1.2 seconds
		sleep 1.5;
		playsound3D ["kat_aceCirculation\sounds\powerup.wav", _caller, false, getPosASL _caller, 5, 1, 15]; // 7.6 seconds
		sleep 7.7; // 9.2 seconds
		playsound3D ["kat_aceCirculation\sounds\bump.wav", _caller, false, getPosASL _caller, 5, 1, 15]; // 0.8 seconds
		sleep 1; // 10.2 seconds
		playsound3D ["kat_aceCirculation\sounds\checkpulse.wav", _caller, false, getPosASL _caller, 5, 1, 15]; // 1.1 seconds
		_caller setVariable ["adv_aceCPR_var_soundplayed", false];
	};
};

//return:

private _return = if !([_target] call ace_common_fnc_isAwake) then {true} else {false};

_return;
