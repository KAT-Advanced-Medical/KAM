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
 * [medic, patient, "Selectionname", "guedel", "guedel", -1] call kat_aceAirway_fnc_treatmentAdvanced_larynx
 *
 * Public: Yes
 */

params ["_caller", "_target", "_selectionName", "_className", "_items", "", ["_specificSpot", -1]];

if (local _target) then {
    [QGVAR(treatmentAdvanced_guedelLocal), [_target, _className, _selectionName, _specificSpot]] call CBA_fnc_localEvent;
} else {
    [QGVAR(treatmentAdvanced_guedelLocal), [_target, _className, _selectionName, _specificSpot], _target] call CBA_fnc_targetEvent;
};

true;
