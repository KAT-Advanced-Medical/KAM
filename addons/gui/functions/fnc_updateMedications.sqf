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
hint str "updating medications";
disableSerialization;

private _medications = [
    "ACE_morphine",
    "ACE_epinephrine",
    "kat_epinephrineIV"
];

private _medicationsFound = {
    params ["_medications"];
    
    private _inventory = (items player) + (magazines player);
    private _found = [];

    {
        if (_x in _medications) then {
            _found pushBack _x;  // Store found medication
        };
    } forEach _inventory;

    _found  // Return the list of found medications
};

private _listBox = findDisplay 38580 displayCtrl 71305;
private _foundMedications = [_medications] call _medicationsFound;

private _populateListBox = {
    params ["_foundMedications", "_listBox"];

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
    } forEach _foundMedications;  // Iterate through the found medications
};

// Populate the listbox with found medications
[_foundMedications, _listBox] call _populateListBox;