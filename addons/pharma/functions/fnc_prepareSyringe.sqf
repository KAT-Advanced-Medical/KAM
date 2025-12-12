#include "..\script_component.hpp"
/*
 * Author: Katalam, modified by Cplhardcore
 * Removes a syringe and a given medication and
 * returns a "crafted" syringe with fluid 
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Class name of medication <STRING>
 * 2: Syringe type <STRING>
 * 3: Dose type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "TXA", "5ml", "1"] call kat_pharma_fnc_prepareSyringe;
 *
 * Public: No
 */
params ["_player", "_medicationType", "_syringeType", "_doseType"];

private _syringeClassName = format ["kat_syringe_%1_%2_%3", _medicationType, _syringeType, _doseType];
private _baseSyringe     = format ["kat_%1_syringe", _syringeType];
private _katClassName     = "kat_" + _medicationType;

private _container = objNull;
private _where = "";
if (_baseSyringe in uniformItems _player) then {
    _container = uniformContainer _player;
    _where = "uniform";
};
if (_container isEqualTo objNull && {_baseSyringe in vestItems _player}) then {
    _container = vestContainer _player;
    _where = "vest";
};
if (_container isEqualTo objNull && {_baseSyringe in backpackItems _player}) then {
    _container = backpackContainer _player;
    _where = "backpack";
};
_player removeItem _baseSyringe;
_player removeItem _katClassName;
switch (_where) do {
    case "uniform":  { _player addItemToUniform  _syringeClassName };
    case "vest":     { _player addItemToVest     _syringeClassName };
    case "backpack": { _player addItemToBackpack _syringeClassName };
    default          { _player addItem           _syringeClassName };
};
private _syringeDisplayName = getText (configFile >> "CfgWeapons" >> _syringeClassName >> "displayName");
private _name = format [LELSTRING(GUI,Prepared_Syringe), _syringeDisplayName];

[_name, 2, _player, 10] call ACEFUNC(common,displayTextStructured);
[ACEFUNC(medical_gui,openMenu), ACEGVAR(medical_gui,target)] call CBA_fnc_execNextFrame;