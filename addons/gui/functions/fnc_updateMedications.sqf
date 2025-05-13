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
    "kat_TXA",
    "kat_morphineIV",
    "kat_adenosineIV",
    "kat_atropineIV",
    "kat_alteplase",
    "ACE_salineIV_250",
    "kat_doxapram"
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

    // Get selected syringe type (e.g., "5ml", "10ml", "SalineIV")
    private _syringeListBox = findDisplay 38580 displayCtrl 71303;
    private _selectedIndex = lbCurSel _syringeListBox;
    if (_selectedIndex == -1) exitWith { systemChat "No syringe type selected, Commander."; };

    private _selectedDose = _syringeListBox lbData _selectedIndex;

    // List of items compatible with SalineIV
    private _salineIVWhitelist = [
        "kat_epinephrineIV",
        "kat_morphineIV",
        "kat_etomidate"
    ];

    private _doseVariants = ["Dose1", "Dose2", "Dose3"];

    {
        private _medItem = _x select 0;
        private _medCount = _x select 1;

        if (_medItem != "") then {
            private _parts = _medItem splitString "_";
            private _medName = if ((count _parts) > 1) then {_parts select 1} else {_medItem};

            private _valid = false;
            systemchat str _medItem;
            systemchat str _selectedDose;
            if (_selectedDose == "SalineIV") then {
                _valid = _medItem in _salineIVWhitelist;
            } else {
                {
                    private _key = format ["STR_KAT_Pharma_%1_%2_%3", _medName, _selectedDose, _x];
                    if (localize _key != _key) exitWith { _valid = true };
                } forEach _doseVariants;
            };

            if (_valid) then {
                private _config = configFile >> "CfgWeapons" >> _medItem;
                private _displayName = getText (_config >> "displayName");
                private _picture = getText (_config >> "picture");
                private _entryText = format ["%1 (x%2)", _displayName, _medCount];
                private _index = _listBox lbAdd _entryText;
                _listBox lbSetPicture [_index, _picture];
                _listBox lbSetData [_index, toLower _medName];
            };
        };
    } forEach _foundMedications;
};

[_foundMedications, _listBox] call _populateListBox; }, [], 0.01] call CBA_fnc_waitAndExecute;