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
 * [player, cursorTarget, "head", "Accuvac"] call kat_airway_fnc_treatmentSuctionLocal;
 *
 * Public: No
 */

params ["", "_target", "", "_className"];

_target setVariable [QGVAR(occluded), false, true];

_className = str formatText ["kat_%1", toLower _className];
private _item = if (isClass (configFile >> "CfgWeapons" >> _className)) then {
    getText (configFile >> "CfgWeapons" >> _className >> "displayName");
} else {
    "N/A";
};

[_target, _Item] call ace_medical_treatment_fnc_addToTriageCard;

true;
