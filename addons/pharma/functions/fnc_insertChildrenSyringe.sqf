#include "script_component.hpp"
/*
 * Author: Katalam
 * Insert children actions for medication sub ace self action
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Player <NUMBER>
 * 2: Params <ANY>
 *
 * Return Value:
 * 0: Actions <ARRAY OF ARRAYS>
 *
 * Example:
 * [player, player, []] call kat_pharma_fnc_insertChildrenSyringe;
 *
 * Public: No
 */

params ["_target", "_player", "_params"];

private _allMedications = [
    "kat_naloxone",
    "kat_EACA",
    "kat_TXA",
    "kat_norepinephrine",
    "kat_phenylephrine",
    "kat_nitroglycerin",
    "kat_amiodarone",
    "kat_lidocaine",
    "kat_atropine",
    "kat_ketamine",
    "kat_fentanyl",
    "kat_nalbuphine",
    "kat_lorazepam",
    "kat_flumazenil",
    "kat_etomidate"
];

// filter the players items to get all medicines
private _medications = [];
{
    if (_x in _allMedications) exitWith {
        _medications pushBackUnique _x;
    };
    // fallback for additonal mods
    if ((getNumber (configFile >> "CfgWeapons" >> _x >> "isMedication")) > 0) then {
        _medications pushBackUnique _x;
    };
} forEach (items _player);

// create the ace actions
private _actions = [];
private _condition = {true};
{
    private _displayName = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
    private _actionVarName = format [QGVAR(syringe_action_%1), _x];
    private _action = [_actionVarName, _displayName, "", FUNC(prepareSyringe), _condition, {}, _x] call ACEFUNC(interact_menu,createAction);

    _actions pushBack [_action, [], _target];
} forEach _medications;

_actions
