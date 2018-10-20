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
 * [medic, patient] call kat_aceAirway_fnc_treatmentAdvanced_accuvac
 *
 * Public: Yes
 */

params ["_caller", "_target"];

if !(_target getVariable ["ace_medical_airwayOccluded", false]) exitWith {
  _output = localize "STR_kat_aceAirway_Accuvac_NA";
  [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
};

if (local _target) then {
  ["treatmentAccuvac", [_target, "Accuvac"]] call CBA_fnc_localEvent;
} else {
  ["treatmentAccuvac", [_target, "Accuvac"], _target] call CBA_fnc_targetEvent;
};

true;
