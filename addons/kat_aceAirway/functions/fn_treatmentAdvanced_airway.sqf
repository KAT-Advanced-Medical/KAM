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
 * [medic, patient, "Larynxtubus"] call kat_aceAirway_fnc_treatmentAdvanced_airway
 *
 * Public: Yes
 */

params ["_caller", "_target", "_className"];
/*
if (_target getVariable ["kat_aceAirway_airway", false]) exitWith {
   _output = localize "STR_kat_aceAirway_Airway_already";
   [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
   false;
};

switch (_className) do {
  case "Larynxtubus": {
    _Item = localize "STR_kat_aceAirway_Larynx_Display";
    if (local _target) then {
      ["treatmentLarynx", [_target, _Item]] call CBA_fnc_localEvent;
    } else {
      ["treatmentLarynx", [_target, _Item], _target] call CBA_fnc_targetEvent;
    };
  };
  case "Guedeltubus": {
    _Item = localize "STR_kat_aceAirway_Guedel_Display";
    if (random 100 < 5) exitWith {
      _output = localize "STR_kat_aceAirway_Airway_NA";
      [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
    };
    if (local _target) then {
      ["treatmentGuedel", [_target, _Item]] call CBA_fnc_localEvent;
    } else {
      ["treatmentGuedel", [_target, _Item], _target] call CBA_fnc_targetEvent;
    };
  };
  default {};
};
*/

if (local _target) then {
  ["treatmentAirway", [_caller, _target, _Item]] call CBA_fnc_localEvent;
} else {
  ["treatmentAirway", [_caller, _target, _Item], _target] call CBA_fnc_targetEvent;
};

true;
