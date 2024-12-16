#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks the syringes in the players inventory and then populates the listbox with the syringes,
 *
 * Arguments:
 * none
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call kat_medical_gui_fnc_updateSyringes;
 *
 * Public: No
 */
if !(EGVAR(pharma,AMS_Enabled)) exitWith {};
disableSerialization;

[{private _syringes = [
    "kat_10ml_syringe", 
    "kat_5ml_syringe"
];

private _syringesFound = {
    params ["_syringes"];
    
    private _inventory = (items player) + (magazines player);
    private _found = [];

    {
        private _item = _x;
        if (_item in _syringes) then {
            private _existingIndex = -1;
            {
                if ((_x select 0) == _item) exitWith {_existingIndex = _forEachIndex};
            } forEach _found;

            if (_existingIndex == -1) then {
                _found pushBack [_item, 1];
            } else {
                _found set [_existingIndex, [_item, (_found select _existingIndex select 1) + 1]];
            };
        };
    } forEach _inventory;

    _found
};

private _listBox = findDisplay 38580 displayCtrl 71303;
private _foundSyringes = [_syringes] call _syringesFound;

private _populateListBox = {
    params ["_foundSyringes", "_listBox"];

    lbClear _listBox;
    {
        private _syringeItem = _x select 0;
        private _syringeCount = _x select 1; 
        if (_syringeItem != "") then {
            private _config = configFile >> "CfgWeapons" >> _syringeItem;
            private _displayName = getText (_config >> "displayName");
            private _picture = getText (_config >> "picture");
            private _data = toLower ((_syringeItem splitString "_") select 1);
            private _entryText = format ["%1 (x%2)", _displayName, _syringeCount];
            private _index = _listBox lbAdd _entryText;
            _listBox lbSetPicture [_index, _picture];
            _listBox lbSetData [_index, _data];
        };
    } forEach _foundSyringes; 
};

[_foundSyringes, _listBox] call _populateListBox; }, [], 0.01] call CBA_fnc_waitAndExecute;