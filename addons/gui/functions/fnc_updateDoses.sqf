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

private _medListBox = findDisplay 38580 displayCtrl 71305;
private _doseListBox = findDisplay 38580 displayCtrl 71307;

// Event handler: When a medication is selected, update dose listbox with delay
_medListBox ctrlAddEventHandler ["LBSelChanged", {
    params ["_control", "_selectedIndex"];

    if (_selectedIndex >= 0) then {
        private _medItem = _control lbData _selectedIndex;
        systemChat format ["Selected _medItem: %1", _medItem];

        private _doseListBox = findDisplay 38580 displayCtrl 71307;
        if (isNull _doseListBox) exitWith { systemChat "ERROR: _doseListBox is NULL in event!"; };

        systemChat "Scheduled dose list population...";

        private _capturedMedItem = _medItem;

        [{

            params ["_doseListBox", "_capturedMedItem"];

            if (isNil "_capturedMedItem" || {_capturedMedItem == ""}) exitWith { 
                systemChat "ERROR: Delayed _medItem is EMPTY!"; 
            };
            if (isNull _doseListBox) exitWith { 
                systemChat "ERROR: Delayed _doseListBox is NULL!"; 
            };

            systemChat "Executing dose list population...";
            lbClear _doseListBox;

            private _medParts = _capturedMedItem splitString "_";
            private _medBaseName = _medParts select (count _medParts - 1);
            systemChat format ["Computed _medBaseName: %1", _medBaseName];

            private _doseLevels = [1, 2, 3];

            {
                private _stringtableKey = format ["STR_KAT_Pharma_%1_Dose%2", _medBaseName, _x];
                private _localizedText = localize _stringtableKey;
                systemChat format ["Checking Key: %1, Result: %2", _stringtableKey, _localizedText];

                if (_localizedText != _stringtableKey && {_localizedText != ""}) then {
                    private _index = _doseListBox lbAdd _localizedText;
                    _doseListBox lbSetValue [_index, _x];
                    systemChat format ["Added Dose: %1", _localizedText];
                };
            } forEach _doseLevels;

        }, [_doseListBox, _capturedMedItem], 0.05] call CBA_fnc_waitAndExecute;
    };
}];
