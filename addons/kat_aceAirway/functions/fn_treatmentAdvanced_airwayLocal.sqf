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
 * [medic, patient, "Larynxtubus"] call kat_aceAirway_fnc_treatmentAdvanced_airwayLocal
 *
 * Public: Yes
 */

params ["_caller", "_target", "_className"];

if (_target getVariable ["kat_aceAirway_airway", false]) exitWith {
   private _output = localize "STR_kat_aceAirway_Airway_already";
   [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
   false;
};
if ((random 100 < 5) && (_className isEqualTo "Guedeltubus")) exitWith {
  private _output = localize "STR_kat_aceAirway_Airway_NA";
  [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
};

_target setVariable ["kat_aceAirway_airway", true, true];
_target setVariable ["ace_medical_airwayCollapsed", false, true];

switch (_className) do {
  case "Larynxtubus": {
    private _Item = localize "STR_kat_aceAirway_Larynx_Display";
    _target setVariable ["kat_aceAirway_airway_item", "larynx", true];
  };
  case "Guedeltubus": {
    private _Item = localize "STR_kat_aceAirway_Guedel_Display";
    _target setVariable ["kat_aceAirway_airway_item", "guedel", true];
  };
  default {};
};
[_target, _Item] call ace_medical_fnc_addToTriageCard;
[_target, "quick_view", localize "STR_kat_aceAirway_airway_log", [[_player] call ace_common_fnc_getName, _Item]] call ace_medical_fnc_addToLog;

true;
