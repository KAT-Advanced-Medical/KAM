#include "script_component.hpp"
_medic =  _this select 0;
_patient = _this select 1;

[_medic,_patient] spawn {
params ["_medic","_patient"];
_medic =_medic;
_patient =  _patient;

sleep 0.001;
[14, [], {}, {}, "Listening"] call ace_common_fnc_progressBar;
private _heartRate = _patient getVariable ["ace_medical_heartRate", 80];
_pneumothorax = _patient getVariable ["KAT_medical_pneumothorax", false];
_hemopneumothorax = _patient getVariable ["KAT_medical_hemopneumothorax", false];
_tensionpneumothorax = _patient getVariable ["KAT_medical_tensionpneumothorax", false];
if !(_heartRate == 0) then {
  if (_pneumothorax) then {
      _random = round random 1;
        if (_random == 1) then {
          playSound "tensionpneumothorax";
          sleep 7;
          playSound "normalbreathing";
          sleep 7;
        } else {
          playSound "normalbreathing";
          sleep 7;
          playSound "tensionpneumothorax";
          if (true) exitWith {true};
        };
  } else {  
  if (_hemopneumothorax) then {
    _random = round random 1;
      if (_random == 1) then {
        playSound "hemothoraxbreathing";
        sleep 7;
        playSound "normalbreathing";
        sleep 7;
      } else {
        playSound "normalbreathing";
        sleep 7;
        playSound "hemothoraxbreathing";
        sleep 7;
        if (true) exitWith {true};
      };
  } else {
  if (_tensionpneumothorax) then {
      _random = round random 1;
        if (_random == 1) then {
          playSound "tensionpneumothorax";
          sleep 7;
          playSound "normalbreathing";
          sleep 7;
        } else {
          playSound "normalbreathing";
          sleep 7;
          playSound "tensionpneumothorax";
          if (true) exitWith {true};
        };
  } else {
    playSound "normalbreathing";
    sleep 7;
    playSound "normalbreathing";
    sleep 7;
    if (true) exitWith {true};
  };
  };
  };
  } else {
    sleep 14;
  };
};
true