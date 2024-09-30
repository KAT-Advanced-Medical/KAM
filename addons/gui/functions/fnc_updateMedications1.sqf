#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks the medications in the players inventory and then populates the listbox with the medications,
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_player] call kat_medical_gui_fnc_updateMedication;
 *
 * Public: No
 */

private _medications = [
    "ACE_morphine",
    "ACE_epinephrine",
    "kat_epinephrineIV"
];

private _medicationsFound = {
    params ["_medications"];
    private _inventory = items player;
    private _found = [];
    {
        if (_x in _medications) then {
            _found pushBack _x;
        };
    } forEach _inventory;
    
    _found
};
private _display = uiNamespace getVariable [QACEGVAR(medical_gui,menuDisplay), displayNull];
private _listBox = _display displayCtrl 71305;
private _foundMedications = [_medications] call _medicationsFound;
private _populateListBox = {
    params ["_foundMedications", "_listBox"];
    
    lbClear _listBox;

    {
        private _classname = _x;
        private _count = [player, _classname] call ace_common_fnc_getCountOfItem; 
        if (_count > 0) then {
            private _config = configFile >> "CfgWeapons" >> _classname;
            private _displayName = getText (_config >> "displayName");
            private _picture = getText (_config >> "picture");
            private _data = (_classname splitString "_") select 2;

            private _index = _listBox lbAdd _displayName;
            _listBox lbSetPicture [_index, _picture];
            _listBox lbSetData [_index, _data];
        };
    } forEach _foundMedications;
};
[_foundMedications, _listBox] call _populateListBox;