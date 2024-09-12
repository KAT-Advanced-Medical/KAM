#include "..\script_component.hpp"
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

// Define dose types
private _doseTypes = ["1", "2"];

// Define syringe types
private _syringeTypes = ["5ml", "10ml"];

// Define the medications list
private _allMedications = [
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

// Filter the player's items to get all medications
private _medications = [];
{
    if (_x in _allMedications) then {
        _medications pushBackUnique _x;
    };
    // Fallback for additional mods
    if ((getNumber (configFile >> "CfgWeapons" >> _x >> "isMedication")) > 0) then {
        _medications pushBackUnique _x;
    };
} forEach (items _player);

// Create the ACE actions for each medication
private _actions = [];
private _condition = {true};

{
    private _medication = _x;

    // Get the medication's display name from the config
    private _medicationDisplayName = getText (configFile >> "CfgWeapons" >> _medication >> "displayName");

    // Create a parent action for the medication
    private _parentActionVarName = format ["STR_KAT_Pharma_SyringeAction_%1", _medication];
    private _parentAction = [_parentActionVarName, _medicationDisplayName, "", {}, _condition, {}, [], {true}] call ACEFUNC(interact_menu,createAction);

    // Create child actions for each dose and syringe type combination
    private _childActions = [];
    {
        private _syringeType = _x;
        {
            private _doseType = _x;

            // Format the stringtable key to include medication, dose type, and syringe type
            private _stringtableKey = format ["STR_KAT_Pharma_SyringeAction_%1_%2_%3", _medication, _syringeType, _doseType];

            // Localize the action display name using the custom stringtable entry
            private _displayName = localize _stringtableKey;

            // Format the action variable name to include medication, dose type, and syringe type
            private _actionVarName = format [QGVAR(syringe_action_%1_%2_%3), _medication, _syringeType, _doseType];

            // Create the child action
            private _childAction = [_actionVarName, _displayName, "", FUNC(prepareSyringe), _condition, {}, [_medication, _syringeType, _doseType]] call ACEFUNC(interact_menu,createAction);

            // Add the child action to the child actions array
            _childActions pushBack _childAction;
        } forEach _doseTypes;
    } forEach _syringeTypes;

    // Attach child actions to the parent action
    private _parentActionWithChildren = [_parentActionVarName, _medicationDisplayName, "", {}, _condition, {}, _childActions, {true}] call ACEFUNC(interact_menu,createAction);

    // Add the parent action (with children) to the actions array
    _actions pushBack [_parentActionWithChildren, [], _target];

} forEach _medications;

_actions