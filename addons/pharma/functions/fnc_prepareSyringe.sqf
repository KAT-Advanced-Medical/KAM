#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Removes a syringe and a given medication and
 * returns a "crafted" syringe with fluid 
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Player <NUMBER>
 * 2: Params <ARRAY>
 *  0: Class name of medication <STRING>
 *  1: Syringe type <STRING>
 *  2: Dose type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, player, ["kat_TXA", "1", "5ml"]] call kat_pharma_fnc_prepareSyringe;
 *
 * Public: No
 */

params ["_target", "_player", "_params"];
_params params ["_className", "_syringeType", "_doseType"];

// Combine class name, dose type, and syringe type to form the final syringe class name
private _syringeClassName = format ["Syringe_%1_%2_%3", _className, _syringeType, _doseType];

// Check if the syringe class exists
private _hasSyringe = isClass (configFile >> "CfgWeapons" >> _syringeClassName);

if (!_hasSyringe) exitWith {
    hint format ["Syringe type for %1 with %2 dose and %3 syringe does not exist.", _className, _doseType, _syringeType];
};

// Remove the base syringe and the medication from the player's inventory
private _baseSyringe = format ["kat_%1", _syringeType];
_player removeItem _baseSyringe;
_player removeItem _className;

// Add the crafted syringe with fluid to the player's inventory
_player addItem _syringeClassName;