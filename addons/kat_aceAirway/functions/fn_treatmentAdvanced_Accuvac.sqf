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

params ["_caller", "_target", "_selectionName"];

private _part = [_selectionName] call FUNC(selectionNameToNumber);
if (!_part == 0) exitWith {
    [QEGVAR(common,displayTextStructured), ["Not allowed"], [_caller]] call CBA_fnc_targetEvent;
    false;
};

private _airway = _target getVariable [QGVAR(airwayOccluded), false];
if (!_airway) exitWith {
   _output = localize LSTRING(Status_Airway_NotNeeded);
   [QEGVAR(common,displayTextStructured), [_output, 1.5, _caller], [_caller]] call CBA_fnc_targetEvent;
   false;
};

if (local _target) then {
    [QGVAR(treatmentAdvanced_AccuvacLocal), [_target, _selectionName]] call CBA_fnc_localEvent;
} else {
    [QGVAR(treatmentAdvanced_AccuvacLocal), [_target, _selectionName], _target] call CBA_fnc_targetEvent;
};

true;
