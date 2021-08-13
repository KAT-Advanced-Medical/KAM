/*
 * Author: Battlekeeper, modified by YetheSamartaka
 * Handles drawign 250ml of blood
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

if (_bloodtype == "O") then {
      _medic addItem "kat_bloodIV_O_250";
      private _bloodVolume = (_patient getVariable ["ace_medical_bloodVolume", 6.0]);
      _patient setVariable ["ace_medical_bloodVolume", _bloodVolume - 0.25];
      } else {
        if (_bloodtype == "A") then {
          _medic addItem "kat_bloodIV_A_250";
          private _bloodVolume = (_patient getVariable ["ace_medical_bloodVolume", 6.0]);
      _patient setVariable ["ace_medical_bloodVolume", _bloodVolume - 0.25];
          } else {
            if (_bloodtype == "B") then {
              _medic addItem "kat_bloodIV_B_250";
              private _bloodVolume = (_patient getVariable ["ace_medical_bloodVolume", 6.0]);
      _patient setVariable ["ace_medical_bloodVolume", _bloodVolume - 0.25];
              } else {
                if (_bloodtype == "AB") then {
                  _medic addItem "kat_bloodIV_AB_250";
                private _bloodVolume = (_patient getVariable ["ace_medical_bloodVolume", 6.0]);
      _patient setVariable ["ace_medical_bloodVolume", _bloodVolume - 0.25];
                };
              };
            };
          };