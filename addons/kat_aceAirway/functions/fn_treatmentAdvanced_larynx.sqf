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
 * [medic, patient, "Selectionname", "larynx", "larynx", -1] call kat_aceAirway_fnc_treatmentAdvanced_larynx
 *
 * Public: Yes
 */

params ["_caller", "_target", "_selectionName", "_className", "_items", "", ["_specificSpot", -1]];

if !(_selectionName isEqualTo "head") exitWith {};

private _airway = _target getVariable ["kat_aceAirway_airwayl", false];
if (_airway) exitWith {
   _output = localize "STR_aceAirway_Airway_already";
   [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
   false;
};
if !(_target getVariable ["ace_medical_inReviveState"), false]) exitWith {
  _output = localize "STR_aceAirway_Airway_NA";
  [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
};

private _removeItem = _items select 0;

[_caller, _target, str _removeItem] call ace_medical_fnc_useItem;

if (local _target) then {
  [_target, _removeItem, _selectionName] call kat_aceAirway_fnc_treatmentAdvanced_larynxLocal;
} else {
  [[_target, _removeItem, _selectionName], kat_aceAirway_fnc_treatmentAdvanced_larynxLocal] remoteExec ["call", _target];
};

true;
