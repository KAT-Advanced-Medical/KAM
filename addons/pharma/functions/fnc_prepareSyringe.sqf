#include "..\script_component.hpp"
/*
 * Author: Katalam, modified by Cplhardcore
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
 * [player, player, ["TXA", "1", "5ml"]] call kat_pharma_fnc_prepareSyringe;
 *
 * Public: No
 */
params ["_player", "_medicationType", "_syringeType", "_doseType"];

private _syringeClassName = format ["kat_syringe_%1_%2_%3", _medicationType, _syringeType, _doseType];
private _hasSyringe = isClass (configFile >> "CfgWeapons" >> _syringeClassName);
if (!_hasSyringe) exitWith {
    hint format ["This syringe combination does not exist. kat_syringe %1 %2 %3", _medicationType, _syringeType, _doseType];
    [{hint ""}, [], 5] call CBA_fnc_waitAndExecute;
};
private _baseSyringe = format ["kat_%1_syringe", _syringeType];
_player removeItem _baseSyringe;
_katClassName = "kat_" + _medicationType;
_player removeItem _katClassName;
_player addItem _syringeClassName;
private _syringeDisplayName = getText (configFile >> "CfgWeapons" >> _syringeClassName >> "displayName");
hint format ["Prepared syringe: %1", _syringeDisplayName];
[{hint ""}, [], GVAR(prepTime_PrepSyringe)] call CBA_fnc_waitAndExecute;