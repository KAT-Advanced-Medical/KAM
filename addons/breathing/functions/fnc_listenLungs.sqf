#include "script_component.hpp"
/*
 * Author: Battlekeeper, modified by YetheSamartaka and Tomcat
 * Handles listening to lungs.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_listenLungs;
 *
 * Public: No
 */

params ["_medic","_patient"];

//[14, [], {}, {}, "Listening"] call ace_common_fnc_progressBar;

if ((_patient getVariable [QACEGVAR(medical,heartRate), 80]) isEqualTo 0) exitWith {};

private _volume = GVAR(stethoscopeSoundVolume);

_random = round random 1;

if (_patient getVariable [QGVAR(pneumothorax), false]) exitWith {
  if (_random >= 0.5) then {
    playSoundUI ["tensionpneumothoraxbreathing", _volume, 1];
    sleep 7;
    playSoundUI ["normalbreathing", _volume, 1];
  } else {
    playSoundUI ["normalbreathing", _volume, 1];
    sleep 7;
    playSoundUI ["tensionpneumothoraxbreathing", _volume, 1];
  };
};

if (_patient getVariable [QGVAR(hemopneumothorax), false]) exitWith {
  if (_random >= 0.5) then {
    playSoundUI ["hemothoraxbreathing", _volume, 1];
    sleep 7;
    playSoundUI ["normalbreathing", _volume, 1];
  } else {
    playSoundUI ["normalbreathing", _volume ,1];
    sleep 7;
    playSoundUI ["hemothoraxbreathing", _volume, 1];
  };
};

if (_patient getVariable [QGVAR(tensionpneumothorax), false]) exitWith {
  if (_random >= 0.5) then {
    playSoundUI ["tensionpneumothoraxbreathing", _volume, 1];
    sleep 7;
    playSoundUI ["normalbreathing", _volume, 1];
  } else {
    playSoundUI ["normalbreathing", _volume, 1];
    sleep 7;
    playSoundUI ["tensionpneumothoraxbreathing", _volume, 1];
  };
};

playSoundUI ["normalbreathing", _volume, 1];
sleep 7;
playSoundUI ["normalbreathing", _volume, 1];