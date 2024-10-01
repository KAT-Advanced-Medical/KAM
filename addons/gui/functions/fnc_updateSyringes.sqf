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
        if (_x in _syringes) then {
            _found pushBack _x;
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
        private _classname = _x;

        if (_classname != "") then {
            private _config = configFile >> "CfgWeapons" >> _classname;
            private _displayName = getText (_config >> "displayName");
            private _picture = getText (_config >> "picture");
            private _data = (_classname splitString "_") select 1;
            private _entryText = format ["%1", _displayName]; 
            private _index = _listBox lbAdd _entryText;
            _listBox lbSetPicture [_index, _picture];
            _listBox lbSetData [_index, _data];
        };
    } forEach _foundSyringes; 
};

[_foundSyringes, _listBox] call _populateListBox;}, [], 0.1] call CBA_fnc_waitAndExecute;