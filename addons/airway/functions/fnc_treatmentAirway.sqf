#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for collapsing local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body part <STRING>
 * 3: Treatment class name <STRING>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget, "head", "npa"] call KAM_airway_fnc_treatmentAirwayLocal;
 *
 * Public: No
 */

params ["_caller", "_target", "_bodyPart", "_className"];

if !(local _target) exitWith {
    [QGVAR(treatmentAirwayLocal), [_caller, _target, _bodyPart, _className], _target] call CBA_fnc_targetEvent;
};

_className = str formatText ["KAM_%1", toLower _className];
_target setVariable [QGVAR(airway), [true, _className], true];
_target setVariable [QGVAR(obstruction), false, true];

private _item = if (isClass (configFile >> "CfgWeapons" >> _className)) then {
    getText (configFile >> "CfgWeapons" >> _className >> "displayName");
} else {
    "N/A";
};

[_target, _item] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(tube_log), [[_caller] call ace_common_fnc_getName, _item]] call ace_medical_treatment_fnc_addToLog;
[_target, "activity_view", LSTRING(tube_log), [[_caller] call ace_common_fnc_getName, _item]] call ace_medical_treatment_fnc_addToLog;

true;
