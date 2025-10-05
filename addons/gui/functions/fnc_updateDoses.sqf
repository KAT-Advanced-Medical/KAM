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
 * [] call kat_medical_gui_fnc_updateDoses;
 *
 * Public: No
 */

disableSerialization;
private _medListBox = findDisplay 38580 displayCtrl 71305;
_medListBox ctrlRemoveAllEventHandlers "LBSelChanged";  
_medListBox ctrlAddEventHandler ["LBSelChanged", {
    params ["_control", "_selectedIndex"];
    if (_selectedIndex >= 0) then {
        private _medItem = _control lbData _selectedIndex;
        private _capturedMedItem = _medItem;

        [{
            params ["_capturedMedItem"];

            private _syringeListBox = findDisplay 38580 displayCtrl 71303;
            private _syringeSelected = lbCurSel _syringeListBox;
            private _syringeType = _syringeListBox lbData _syringeSelected;

            private _doseListBox = findDisplay 38580 displayCtrl 71307;
            lbClear _doseListBox;

            if (isNil "_capturedMedItem" || {_capturedMedItem == ""}) exitWith {}; 

            private _medParts = _capturedMedItem splitString "_";
            private _medBaseName = _medParts select -1;
            switch (true) do {
                case (_syringeType in ["salineiv100", "salineiv"]): {
                    private _index = _doseListBox lbAdd LLSTRING(Infusion);
                    _doseListBox lbSetValue [_index, 4];
                };
                default {
                    private _doseLevels = [10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30];

                    {
                    private _testClass = format ["kat_syringe_%1_%2_%3", _medBaseName, _syringeType, _x];

                    if (isClass(configFile >> "CfgWeapons" >> _testClass)) then {
                        private _stringtableKey = format ["STR_KAT_Pharma_SyringeDisplay_%1_%2_%3", _medBaseName, _syringeType, _x];
                        private _localizedText = localize _stringtableKey;
                        private _doseText = (_localizedText splitString " ") select 3;
                        private _index = _doseListBox lbAdd _doseText;
                        _doseListBox lbSetValue [_index, _x];
                        };
                    } forEach _doseLevels;
                };
            };

        }, [_capturedMedItem], 0.05] call CBA_fnc_waitAndExecute;
    };
}];