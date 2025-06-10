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

private _syringeListBox = findDisplay 38580 displayCtrl 71303;
_syringeListBox ctrlRemoveAllEventHandlers "LBSelChanged";
_syringeListBox ctrlAddEventHandler ["LBSelChanged", {
    params ["_control", "_selectedIndex"];

    private _medications = [
        "kat_amiodarone", "kat_atropine", "kat_EACA", "kat_epinephrineIV",
        "kat_etomidate", "kat_fentanyl", "kat_flumazenil", "kat_ketamine",
        "kat_lidocaine", "kat_lorazepam", "kat_nalbuphine", "kat_nitroglycerin",
        "kat_norepinephrine", "kat_phenylephrine", "kat_TXA", "kat_morphineIV",
        "kat_adenosineIV", "kat_atropineIV", "kat_alteplase", "kat_doxapram", "ACE_salineIV_250"
    ];

    private _inventory = (items player) + (magazines player);
    private _found = [];

    {
        private _item = _x;
        if (_item in _medications) then {
            private _existingIndex = -1;
            {
                if ((_x select 0) == _item) exitWith { _existingIndex = _forEachIndex };
            } forEach _found;

            if (_existingIndex == -1) then {
                _found pushBack [_item, 1];
            } else {
                _found set [_existingIndex, [_item, (_found select _existingIndex select 1) + 1]];
            };
        };
    } forEach _inventory;
    diag_log str _found;

    private _listBox = findDisplay 38580 displayCtrl 71305;
    lbClear _listBox;

    private _selectedSyringe = _control lbData _selectedIndex;
    if (_selectedSyringe == "") exitWith { systemChat "No syringe selected, Commander."; };

    private _salineIVWhitelist = [
        "kat_epinephrineIV", "kat_morphineIV", "kat_etomidate", "kat_doxapram", "kat_norepinephrine", "kat_nitroglycerin"
    ];
    private _5mlWhitelist = [
        "kat_amiodarone", "kat_atropine", "kat_EACA", "kat_epinephrineIV",
        "kat_etomidate", "kat_fentanyl", "kat_flumazenil", "kat_ketamine",
        "kat_lidocaine", "kat_lorazepam", "kat_nalbuphine", "kat_phenylephrine", "kat_TXA", "kat_morphineIV",
        "kat_adenosineIV", "kat_atropineIV", "kat_alteplase", "kat_doxapram", "ACE_salineIV_250"
    ];
    private _10mlWhitelist = [
        "kat_fentanyl", "kat_ketamine",
        "kat_lidocaine", "kat_nalbuphine","kat_TXA", "kat_morphineIV"
    ];

    private _entries = [];

    {
        private _medItem = _x select 0;
        private _medCount = _x select 1;

        if (_medItem == "") exitWith {};

        private _valid = switch (_selectedSyringe) do {
            case "salineiv": { _medItem in _salineIVWhitelist };
            case "5ml":      { _medItem in _5mlWhitelist };
            case "10ml":     { _medItem in _10mlWhitelist };
            default { false };
        };

        if (_valid) then {
            private _config = configFile >> "CfgWeapons" >> _medItem;
            private _displayName = getText (_config >> "displayName");
            _entries pushBack [_displayName, _medItem, _medCount];
        };
    } forEach _found;

    _entries sort true;

    {
        private _displayName = _x select 0;
        private _medItem = _x select 1;
        private _medCount = _x select 2;
        private _medName = (toLower _medItem) splitString "_" select 1;
        private _picture = getText (configFile >> "CfgWeapons" >> _medItem >> "picture");
        private _entryText = format ["%1 (x%2)", _displayName, _medCount];
        private _index = _listBox lbAdd _entryText;
        _listBox lbSetPicture [_index, _picture];
        _listBox lbSetData [_index, toLower _medName];
    } forEach _entries;
}];

