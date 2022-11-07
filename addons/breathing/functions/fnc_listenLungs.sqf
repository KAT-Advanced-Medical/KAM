#include "script_component.hpp"
/*
 * Author: Battlekeeper, modified by YetheSamartaka and Tomcat
 * Handles listeting to Lungs.
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

if ((_patient getVariable ["ace_medical_heartRate", 80]) isEqualTo 0) exitWith {};

_random = round random 1;

if (_patient getVariable [QGVAR(pneumothorax), false]) exitWith {
  if (_random >= 0.5) then {
    playSound "tensionpneumothorax";
    sleep 7;
    playSound "normalbreathing";
  } else {
    playSound "normalbreathing";
    sleep 7;
    playSound "tensionpneumothorax";
  };
};

if (_patient getVariable [QGVAR(hemopneumothorax), false]) exitWith {
  if (_random >= 0.5) then {
    playSound "hemothoraxbreathing";
    sleep 7;
    playSound "normalbreathing";
  } else {
    playSound "normalbreathing";
    sleep 7;
    playSound "hemothoraxbreathing";
  };
};

if (_patient getVariable [QGVAR(tensionpneumothorax), false]) exitWith {
  if (_random >= 0.5) then {
    playSound "tensionpneumothorax";
    sleep 7;
    playSound "normalbreathing";
  } else {
    playSound "normalbreathing";
    sleep 7;
    playSound "tensionpneumothorax";
  };
};

playSound "normalbreathing";
sleep 7;
playSound "normalbreathing";
