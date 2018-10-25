/*
 * Author: Katalam
 * Airway Management
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 * 2: Treatment classname <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [medic, patient, "Selectionname", "larynx"] call kat_aceAirway_fnc_treatmentAdvanced_airway
 *
 * Public: Yes
 */

params ["_caller", "_target", "_className"];

if (_target getVariable ["kat_aceAirway_airway", false]) exitWith {
   _output = localize "STR_kat_aceAirway_Airway_already";
   [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
   false;
};

private _removeItem = "ACE_guedel";
if (_className isEqualTo "larynx") then {_removeItem = "ACE_larynx"};

[_caller, _target, _removeItem] call ace_medical_fnc_useItem;

switch (_className) do {
  case "larynx": {
    if (local _target) then {
      ["treatmentLarynx", [_target, _removeItem]] call CBA_fnc_localEvent;
    } else {
      ["treatmentLarynx", [_target, _removeItem], _target] call CBA_fnc_targetEvent;
    };
  };
  case "guedel": {
    if (random 100 < 5) exitWith {
      _output = localize "STR_kat_aceAirway_Airway_NA";
      [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
    };
    if (local _target) then {
      ["treatmentGuedel", [_target, _removeItem]] call CBA_fnc_localEvent;
    } else {
      ["treatmentGuedel", [_target, _removeItem], _target] call CBA_fnc_targetEvent;
    };
  };
  default {};
};

true;
