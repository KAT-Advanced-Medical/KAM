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
        if (_x in _medications) then {
            _found pushBack _x; 
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
        private _classname = _x;
        if (_classname != "") then {
            private _config = configFile >> "CfgWeapons" >> _classname;
            private _displayName = getText (_config >> "displayName");
            private _picture = getText (_config >> "picture");
            private _data = toLower ((_classname splitString "_") select 1);
            private _entryText = format ["%1", _displayName];  
            private _index = _listBox lbAdd _entryText;
            _listBox lbSetPicture [_index, _picture];
            _listBox lbSetData [_index, _data];
        };
    } forEach _foundMedications; 
};

[_foundMedications, _listBox] call _populateListBox; }, [], 0.1] call CBA_fnc_waitAndExecute;