#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks the medications in the players inventory and then populates the listbox with the medications,
 *
 * Arguments:
 * none
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call kat_medical_gui_fnc_updateMedication;
 *
 * Public: No
 */

if !(EGVAR(pharma,AMS_Enabled)) exitWith {};
disableSerialization;

[{private _medications = [
    "kat_amiodarone",
    "kat_atropine",
    "kat_EACA",
    "kat_epinephrineIV",
    "kat_etomidate",
    "kat_fentanyl",
    "kat_flumazenil",
    "kat_ketamine",
    "kat_lidocaine",
    "kat_lorazepam",
    "kat_nalbuphine",
    "kat_nitroglycerin",
    "kat_norepinephrine",
    "kat_phenylephrine",
    "kat_TXA"
];

private _medicationsFound = {
    params ["_medications"];
    
    private _inventory = (items player) + (magazines player);
    private _found = [];

    {
        private _item = _x;
        if (_item in _medications) then {
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

private _listBox = findDisplay 38580 displayCtrl 71305;
private _foundMedications = [_medications] call _medicationsFound;

private _populateListBox = {
    params ["_foundMedications", "_listBox"];

    lbClear _listBox;
    {
        private _medItem = _x select 0;
        private _medCount = _x select 1; 
        if (_medItem != "") then {
            private _config = configFile >> "CfgWeapons" >> _medItem;
            private _displayName = getText (_config >> "displayName");
            private _picture = getText (_config >> "picture");
            private _data = toLower ((_medItem splitString "_") select 1);
            private _entryText = format ["%1 (x%2)", _displayName, _medCount];
            private _index = _listBox lbAdd _entryText;
            _listBox lbSetPicture [_index, _picture];
            _listBox lbSetData [_index, _data];
        };
    } forEach _foundMedications; 
};

[_foundMedications, _listBox] call _populateListBox; }, [], 0.1] call CBA_fnc_waitAndExecute;