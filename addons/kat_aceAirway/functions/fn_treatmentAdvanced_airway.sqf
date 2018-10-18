/*
 * Author: Katalam
 * Airway Management
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 * 2: SelectionName <STRING>
 * 3: Treatment classname <STRING>
 * 4: Item <STRING>
 * 5: specific Spot <NUMBER> (default: -1)
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [medic, patient, "Selectionname", "larynx"] call kat_aceAirway_fnc_treatmentAdvanced_airway
 *
 * Public: Yes
 */

diag_log text format ["Medic: %1", _this select 0];
diag_log text format ["Patient: %1", _this select 1];
diag_log text "treatmentAdvanced_airway";

params ["_caller", "_target", "_selectionName", "_className"];

if (_target getVariable ["kat_aceAirway_airway", false]) exitWith {
   _output = localize "STR_kat_aceAirway_Airway_already";
   [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
   false;
};
if (_target getVariable ["ace_medical_inReviveState", false]) exitWith {
  _output = localize "STR_kat_aceAirway_Airway_NA";
  [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
};

private _removeItem = "ACE_guedel";
if (_className isEqualTo "larynx") then {_removeItem = "ACE_larynx"};

[_caller, _target, _removeItem] call ace_medical_fnc_useItem;

diag_log text "treatmentAdvanced_airway_useItem";

switch (_className) do {
  case "larynx": {
    if (local _target) then {
      diag_log text "treatmentAdvanced_airway_larynx";
      ["treatmentLarynx", [_target, _removeItem]] call CBA_fnc_localEvent;
    } else {
      diag_log text "treatmentAdvanced_airway_larynxNot";
      ["treatmentLarynx", [_target, _removeItem], _target] call CBA_fnc_targetEvent;
    };
  };
  case "guedel": {
    if (!random 100 < 5) exitWith {
      _output = localize "STR_kat_aceAirway_Airway_NA";
      [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
    };
    if (local _target) then {
      diag_log text "treatmentAdvanced_airway_guedel";
      ["treatmentGuedel", [_target, _removeItem]] call CBA_fnc_localEvent;
    } else {
      diag_log text "treatmentAdvanced_airway_guedelNot";
      ["treatmentGuedel", [_target, _removeItem], _target] call CBA_fnc_targetEvent;
    };
  };
  default {};
};

diag_log text "treatmentAdvanced_airway_true";

true;
