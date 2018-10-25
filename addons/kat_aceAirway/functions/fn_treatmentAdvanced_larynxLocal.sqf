/*
 * Author: Katalam
 * Handles the airway management of a patient.
 *
 * Arguments:
 * 0: The patient <OBJECT>
 * 1: Item used classname <STRING>
 *
 *
 * Return Value:
 * True
 *
 * Example:
 * [bob, "classname"] call kat_aceAirway_fnc_treatmentAdvanced_larynxLocal
 *
 * Public: No
 */

params ["_target", "_Item"];

diag_log text "Llocal";

_target setVariable ["kat_aceAirway_airway", true, true];
_target setVariable ["kat_aceAirway_airway_item", "larynx"];

_target setVariable ["ace_medical_airwayCollapsed", false];

[_target, _Item] call ace_medical_fnc_addToTriageCard;
//[_target, "activity", localize "STR_kat_aceAirway_activity", [[_caller, false, true] call ace_common_fnc_getName, localize "STR_kat_aceAirway_Larynx_Display"]] call ace_medical_fnc_addToLog;

true;
