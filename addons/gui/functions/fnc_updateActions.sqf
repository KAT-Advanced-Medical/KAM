#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates the action buttons based currently avaiable treatments.
 *
 * Arguments:
 * 0: Medical Menu display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_display] call ace_medical_gui_fnc_updateActions
 *
 * Public: No
 */

params ["_display"];

private _selectedCategory = ACEGVAR(medical_gui,selectedCategory);

private _group = _display displayCtrl IDC_ACTION_BUTTON_GROUP;
private _actionButtons = allControls _group;

// Handle triage list (no actions shown)
private _ctrlTriage = _display displayCtrl IDC_TRIAGE_CARD;
private _showTriage = _selectedCategory == "triage";
_ctrlTriage ctrlEnable _showTriage;
_group ctrlEnable !_showTriage;

lbClear _ctrlTriage;

if (_showTriage) exitWith {
    { ctrlDelete _x } forEach _actionButtons;
    [_ctrlTriage, ACEGVAR(medical_gui,target)] call ACEFUNC(medical_gui,updateTriageCard);
};

// Show treatment options on action buttons
private _shownIndex = 0;
{
    _x params ["_displayName", "_category", "_condition", "_statement"];

    // Check action category and condition
    if (_category == _selectedCategory && {call _condition}) then {
        private _ctrl = if (_shownIndex >= count _actionButtons) then {
            _actionButtons pushBack (_display ctrlCreate ["ACE_Medical_Menu_ActionButton", -1, _group]);
        };
        _ctrl = _actionButtons # _shownIndex;
        _ctrl ctrlRemoveAllEventHandlers "ButtonClick";
        _ctrl ctrlSetPositionY POS_H(1.1 * _shownIndex);
        _ctrl ctrlCommit 0;

        _ctrl ctrlSetText _displayName;
        _ctrl ctrlShow true;

        _ctrl ctrlAddEventHandler ["ButtonClick", _statement];
        _ctrl ctrlAddEventHandler ["ButtonClick", {ACEGVAR(medical_gui,pendingReopen) = true}];

        _shownIndex = _shownIndex + 1;
    };
} forEach ACEGVAR(medical_gui,actions);

{ ctrlDelete _x } forEach (_actionButtons select [_shownIndex, 9999]);