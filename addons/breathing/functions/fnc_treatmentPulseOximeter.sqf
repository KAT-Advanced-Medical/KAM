#include "script_component.hpp"
/*
 * Author: Katalam
 * docks a pulseoximeter on the patient
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body part <STRING>
 * 3: Treatment class name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "leftarm", "Pulseoximeter"] call kat_breathing_fnc_treatmentAdvanced_pulseoximeter;
 *
 * Public: No
 */

params ["_caller", "_target", "_selectionName", "_className"];

if (local _target) then {
    [QGVAR(treatmentPulseoximeterLocal), [_caller, _target, _selectionName, _className]] call CBA_fnc_localEvent;
} else {
    [QGVAR(treatmentPulseoximeterLocal), [_caller, _target, _selectionName, _className], _target] call CBA_fnc_targetEvent;
};
