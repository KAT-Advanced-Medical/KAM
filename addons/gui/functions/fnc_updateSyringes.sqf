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

private _syringes = [
    "kat_10ml_syringe", 
    "kat_5ml_syringe"
];

private _syringesFound = {
    params ["_syringes"];
    
    private _inventory = (items player) + (magazines player);
    private _found = [];

    {
        if (_x in _syringes) then {
            _found pushBack _x;  // Store found medication
        };
    } forEach _inventory;

    _found  // Return the list of found medications
};

private _listBox = findDisplay 38580 displayCtrl 71303;
private _foundSyringes = [_syringes] call _syringesFound;

private _populateListBox = {
    params ["_foundSyringes", "_listBox"];

    lbClear _listBox;  // Clear the listbox before adding new entries

    {
        private _classname = _x;  // Medication class name

        // Only proceed if the medication is found
        if (_classname != "") then {
            private _config = configFile >> "CfgWeapons" >> _classname;
            private _displayName = getText (_config >> "displayName");
            private _picture = getText (_config >> "picture");
            private _data = (_classname splitString "_") select 1;  // Adjust index as needed

            // Display medication name in the listbox
            private _entryText = format ["%1", _displayName];  // Only show the name
            private _index = _listBox lbAdd _entryText;

            // Set the picture and data for the listbox entry
            _listBox lbSetPicture [_index, _picture];
            _listBox lbSetData [_index, _data];
        };
    } forEach _foundSyringes;  // Iterate through the found medications
};

// Populate the listbox with found medications
[_foundSyringes, _listBox] call _populateListBox;