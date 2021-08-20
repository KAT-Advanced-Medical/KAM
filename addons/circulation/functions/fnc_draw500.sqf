/*
 * Author: Battlekeeper, modified by YetheSamartaka
 * Handles drawign 500ml of blood
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [medic, medic] call kat_circulation_fnc_draw500;
 *
 * Public: No
 */

params ["_medic","_patient"];

_medic = _this select 0;
_patient = _this select 1;
_bloodtype = [_patient] call kat_circulation_fnc_bloodType;

private _bloodVolume = (_patient getVariable ["ace_medical_bloodVolume", 6.0]);
switch (_bloodtype) do {
  case "O": { 
    _medic addItem "kat_bloodIV_O_500";
  };
  case "A": { 
    _medic addItem "kat_bloodIV_A_500";
  };
  case "B": { 
    _medic addItem "kat_bloodIV_B_500";
  };
  case "AB": { 
    _medic addItem "kat_bloodIV_AB_500";
  };
};
_patient setVariable ["ace_medical_bloodVolume", _bloodVolume - 0.5];