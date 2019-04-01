#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for collapsing
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body part <STRING>
 * 3: Treatment class name <STRING>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget, "npa"] call kat_airway_fnc_treatment_airway;
 *
 * Public: No
 */

params ["_caller", "_target", "_bodyPart", "_className"];

if (local _target) then {
    ["treatmentAirway", [_caller, _target, _bodyPart, _className]] call CBA_fnc_localEvent;
} else {
    ["treatmentAirway", [_caller, _target, _bodyPart, _className], _target] call CBA_fnc_targetEvent;
};

true;
