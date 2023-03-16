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

// Clear all action buttons
{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlRemoveAllEventHandlers "ButtonClick";
    _ctrl ctrlShow false;
} forEach IDCS_ACTION_BUTTON;

// Handle triage list (no actions shown)
private _ctrlTriage = _display displayCtrl IDC_TRIAGE_CARD;
private _showTriage = _selectedCategory == "triage";
_ctrlTriage ctrlEnable _showTriage;

lbClear _ctrlTriage;

if (_showTriage) exitWith {
    [_ctrlTriage, ACEGVAR(medical_gui,target)] call ACEFUNC(medical_gui,updateTriageCard);
};

// Show treatment options on action buttons
private _idcIndex = 0;

{
    _x params ["_displayName", "_category", "_condition", "_statement"];

    // Check action category and condition
    if (_category == _selectedCategory && {call _condition}) then {
        private _ctrl = _display displayCtrl (IDCS_ACTION_BUTTON select _idcIndex);
        _ctrl ctrlSetText _displayName;
        _ctrl ctrlShow true;

        _ctrl ctrlAddEventHandler ["ButtonClick", _statement];
        _ctrl ctrlAddEventHandler ["ButtonClick", {ACEGVAR(medical_gui,pendingReopen) = true}];

        _idcIndex = _idcIndex + 1;
    };
} forEach ACEGVAR(medical_gui,actions);
