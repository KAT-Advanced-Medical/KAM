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
 * [player, cursorTarget, "head", "Accuvac"] call KAM_airway_fnc_treatmentSuction;
 *
 * Public: No
 */

params ["_caller", "_target", "_bodyPart", "_className"];

if !(local _target) exitWith {
    [QGVAR(treatmentSuctionLocal), [_caller, _target, _bodyPart, _className], _target] call CBA_fnc_targetEvent;
};

private _change = 25;
if (_className isEqualTo (toLower "turnaround")) exitWith {
    _change = 10;
};

private _oldMl = _target getVariable [QGVAR(bloodInAirway), 0];
private _newMl = (_oldMl - _change) max 0;
_target setVariable [QGVAR(bloodInAirway), _newMl, true];

if (_newMl < 25) then {
    _target setVariable [QGVAR(occluded), false, true];
};

_className = format ["KAM_%1", toLower _className];

private _item = if (isClass (configFile >> "CfgWeapons" >> _className)) then {
    getText (configFile >> "CfgWeapons" >> _className >> "displayName");
} else {
    "N/A";
};

[_target, _Item] call ace_medical_treatment_fnc_addToTriageCard;

true;
