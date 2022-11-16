#include "script_component.hpp"
/*
ADV-aceCPR - by Belbo - edited by Katalam (new syntax and different sound) and YetheSamartaka(PowerUp sound on/off setting)
*/

params ["_args"];
_args params ["_medic", "_patient"];

if !(_medic getVariable ["kat_soundplayed", false]) then {
    _medic setVariable ["kat_soundplayed", true, true];
    _args spawn {
        params ["_medic", "_patient"];
        // 8 seconds treatment time
        playsound3D [QPATHTOF_SOUND(sounds\standclear.wav), _medic, false, getPosASL _medic, 5, 1, 15]; // 1.2 seconds
        sleep 1.5;
        if !(_medic getVariable ["kat_soundplayed", false]) exitWith {};
        if (GVAR(AED_BeepsAndCharge)) then {
        playsound3D [QPATHTOF_SOUND(sounds\powerup.wav), _medic, false, getPosASL _medic, 5, 1, 15]; // 7.6 seconds
        };
        sleep 7.7; // 9.2 seconds
        if !(_medic getVariable ["kat_soundplayed", false]) exitWith {};
        playsound3D [QPATHTOF_SOUND(sounds\bump.wav), _medic, false, getPosASL _medic, 5, 1, 15]; // 0.8 seconds
        sleep 1; // 10.2 seconds
        if !(_medic getVariable ["kat_soundplayed", false]) exitWith {};
        playsound3D [QPATHTOF_SOUND(sounds\checkpulse.wav), _medic, false, getPosASL _medic, 5, 1, 15]; // 1.1 seconds
        _medic setVariable ["kat_soundplayed", false, true];
    };
};

//return:

private _return = if !([_patient] call ace_common_fnc_isAwake) then {true} else {false};

_return;
