#include "..\script_component.hpp"
/*
 * Author: Katalam, modified by Cplhardcore
 * Adds sub actions for preparing syringes
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

private _doseTypes = ["1", "2"];
private _syringeTypes = ["5ml"];
private _allMedications = [
    "kat_EACA",
    "kat_TXA",
    "kat_norepinephrine",
    "kat_phenylephrine",
    "kat_nitroglycerin",
    "kat_amiodarone",
    "kat_atropine",
    "kat_epinephrineIV"
];

private _medications = [];
{
    if (_x in _allMedications) then {
        _medications pushBackUnique _x;
    };
} forEach (items _player);

private _actions = [];

{
    private _medication = _x;
    {
        private _syringeType = _x;
        {
            private _doseType = _x;

    
            private _className = format ["kat_syringe_%1_%2_%3", _medication, _syringeType, _doseType];

            if (isClass (configFile >> "CfgWeapons" >> _className)) then {
                
                private _stringtableKey = format ["STR_KAT_Pharma_SyringeAction_%1_%2_%3", _medication, _syringeType, _doseType];

                private _displayName = localize _stringtableKey;

                private _actionVarName = format [QGVAR(syringe_action_%1_%2_%3), _medication, _syringeType, _doseType];

                private _action = [_actionVarName, _displayName, "", FUNC(prepareSyringe), {true}, {}, [_medication, _syringeType, _doseType]] call ACEFUNC(interact_menu,createAction);

                _actions pushBack [_action, [], _target];
            };
        } forEach _doseTypes;
    } forEach _syringeTypes;
} forEach _medications;

_actions
