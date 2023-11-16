#include "..\script_component.hpp"
/*
 * Author: Miss Heda, Blue
 * Checks if unit has required items to refill a FAK slot.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Magazine <STRING>
 * 2: FAK Type <NUMBER>
 * 3: Slot <NUMBER>
 *
 * Return Value:
 * Can repack <BOOLEAN>
 *
 * Example:
 * [player, "kat_IFAK_Magazine", 0, 1] call kat_misc_fnc_FAK_checkRepack;
 *
 * Public: No
 */

params ["_unit", "_item", "_type", "_slotToCheck"];

if (!([_unit, _item] call ACEFUNC(common,hasMagazine)) && {(magazinesAmmoFull [_unit, true]) findIf {_x select 0 isEqualTo _item} isEqualTo -1}) exitWith {false};

private _return = true;

private _fnc_getTargetItemCount = {
    params ["_unit", "_className", ["_targetCount", 1], ["_magazine", false]];
    
    private _total = 0;

    if !(_magazine) then {
        private _uniformArray = getItemCargo uniformContainer _unit;
        private _index = (_uniformArray select 0) findIf {_x isEqualTo _className};

        if (_index != -1) then {
            _total = ((_uniformArray select 1) select _index);
        };
        
        if (_total >= _targetCount) exitWith {_total};

        private _vestArray = getItemCargo vestContainer _unit;
        _index = (_vestArray select 0) findIf {_x isEqualTo _className};

        if (_index != -1) then {
            _total = _total + ((_vestArray select 1) select _index);
        };

        if (_total >= _targetCount) exitWith {_total};

        private _backpackArray = getItemCargo backpackContainer _unit;
        _index = (_backpackArray select 0) findIf {_x isEqualTo _className};

        if (_index != -1) then {
            _total = _total + ((_backpackArray select 1) select _index);
        };
    } else {
        private _uniformArray = getMagazineCargo uniformContainer _unit;
        private _index = (_uniformArray select 0) findIf {_x isEqualTo _className};

        if (_index != -1) then {
            _total = ((_uniformArray select 1) select _index);
        };

        if (_total >= _targetCount) exitWith {_total};

        private _vestArray = getMagazineCargo vestContainer _unit;
        _index = (_vestArray select 0) findIf {_x isEqualTo _className};

        if (_index != -1) then {
            _total = _total + ((_vestArray select 1) select _index);
        };

        if (_total >= _targetCount) exitWith {_total};

        private _backpackArray = getMagazineCargo backpackContainer _unit;
        _index = (_backpackArray select 0) findIf {_x isEqualTo _className};

        if (_index != -1) then {
            _total = _total + ((_backpackArray select 1) select _index);
        };
    };
    _total;
};

private _requiredItems = [];

switch (_type) do {
    case 0: {_requiredItems = missionNameSpace getVariable [QGVAR(IFAKContents), []];}; // IFAK
    case 1: {_requiredItems = missionNameSpace getVariable [QGVAR(AFAKContents), []];}; // AFAK
    default {_requiredItems = missionNameSpace getVariable [QGVAR(MFAKContents), []];}; // MFAK
};

{
    _x params ["_className", "_amount"];

    if (((_className call BIS_fnc_itemType) select 0) == "Item") then {
        if !([_unit, _className, _amount] call _fnc_getTargetItemCount >= _amount) exitWith {
            _return = false;
            break;
        };
    } else {
        if !([_unit, _className, _amount, true] call _fnc_getTargetItemCount >= _amount) exitWith {
            _return = false;
            break;
        };
    };
} forEach (_requiredItems select (_slotToCheck - 1));

_return