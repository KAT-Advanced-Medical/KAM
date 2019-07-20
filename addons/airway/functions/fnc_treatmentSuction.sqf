#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for occluding local
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
 * [player, cursorTarget, "head", "Accuvac"] call KAM_airway_fnc_treatmentSuctionLocal;
 *
 * Public: No
 */

params ["_caller", "_target", "_bodyPart", "_className"];

if !(local _target) exitWith {
    [QGVAR(treatmentSuctionLocal), [_caller, _target, _bodyPart, _className], _target] call CBA_fnc_targetEvent;
};

if (_className isEqualTo (toLower "turnaround") && {random(100) < 35}) exitWith {
    private _output = localize LSTRING(turnaround_left);
    [_output, 1.5, _caller] call ace_common_fnc_displayTextStructured;
    false;
};

_className = str formatText ["KAM_%1", toLower _className];
_target setVariable [QGVAR(occluded), false, true];

private _item = if (isClass (configFile >> "CfgWeapons" >> _className)) then {
    getText (configFile >> "CfgWeapons" >> _className >> "displayName");
} else {
    "N/A";
};

[_target, _Item] call ace_medical_treatment_fnc_addToTriageCard;

true;
