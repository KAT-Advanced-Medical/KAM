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

// Create the ACE actions for each medication, dose type, and syringe type
private _actions = [];

{
    private _medication = _x;
    {
        private _syringeType = _x;
        {
            private _doseType = _x;

            // Construct the class name based on medication, syringe type, and dose type
            private _className = format ["kat_syringe_%1_%2_%3", _medication, _syringeType, _doseType];

            // Check if the class exists in CfgWeapons
            if (isClass (configFile >> "CfgWeapons" >> _className)) then {
                // Format the stringtable key to include medication, dose type, and syringe type
                private _stringtableKey = format ["STR_KAT_Pharma_SyringeAction_%1_%2_%3", _medication, _syringeType, _doseType];

                // Localize the action display name using the custom stringtable entry
                private _displayName = localize _stringtableKey;

                // Format the action variable name to include medication, dose type, and syringe type
                private _actionVarName = format [QGVAR(syringe_action_%1_%2_%3), _medication, _syringeType, _doseType];

                // Create the action
                private _action = [_actionVarName, _displayName, "", FUNC(prepareSyringe), {true}, {}, [_medication, _syringeType, _doseType]] call ACEFUNC(interact_menu,createAction);

                // Add the action to the actions array
                _actions pushBack [_action, [], _target];
            };
        } forEach _doseTypes;
    } forEach _syringeTypes;
} forEach _medications;

_actions