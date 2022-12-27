#include "script_component.hpp"
/*
 * Author: Glowbal, mharis001
 * Handles opening the Medical Menu. Called from onLoad event.
 *
 * Arguments:
 * 0: Medical Menu display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call ace_medical_gui_fnc_onMenuOpen
 *
 * Public: No
 */

params ["_display"];

// Create background effects based on interact menu setting
if (ACEGVAR(interact_menu,menuBackground) == 1) then {[QACEGVAR(medical_gui,id), true] call ACEFUNC(common,blurScreen)};
if (ACEGVAR(interact_menu,menuBackground) == 2) then {0 cutRsc [QACEGVAR(interact_menu,menuBackground), "PLAIN", 1, false]};

// Fix mouse moving randomly
[{
    [{setMousePosition _this}, _this] call CBA_fnc_execNextFrame;
}, getMousePosition] call CBA_fnc_execNextFrame;

// Set target name as title
private _ctrlTitle = _display displayCtrl IDC_TITLE;
_ctrlTitle ctrlSetText ([ACEGVAR(medical_gui,target)] call ACEFUNC(common,getName));

// Initially hide the triage select buttons
[_display] call ACEFUNC(medical_gui,toggleTriageSelect);

// Store display and add PFH to update it
uiNamespace setVariable [QACEGVAR(medical_gui,menuDisplay), _display];
["ace_medicalMenuOpened", [ACE_player, ACEGVAR(medical_gui,target), _display]] call CBA_fnc_localEvent;

if (ACEGVAR(medical_gui,menuPFH) != -1) exitWith {
    TRACE_1("Menu PFH already running",ACEGVAR(medical_gui,menuPFH));
};

ACEGVAR(medical_gui,menuPFH) = [ACEFUNC(medical_gui,menuPFH), 0, []] call CBA_fnc_addPerFrameHandler;

// Hide categories if they don't have any actions (airway)
private _list = [
    [IDC_TRIAGE, true],
    [IDC_EXAMINE, true],
    [IDC_BANDAGE, "bandage"],
    [IDC_MEDICATION, "medication"],
    [IDC_AIRWAY, "airway"],
    [IDC_ADVANCED, "advanced"],
    [IDC_SURGERY, "surgery"],
    [IDC_DRAG, "drag"],
    [IDC_TOGGLE, true]
];
private _countEnabled = {
    _x params ["", "_category"];
    if (_category isEqualType "") then { _x set [1, (ACEGVAR(medical_gui,actions) findIf {_category == _x select 1}) > -1]; };
    _x select 1
} count _list;
private _offsetX = POS_X(1.5) + 0.5 * (POS_X(12) - POS_X(_countEnabled * 1.5));
{
    _x params ["_idc", "_enabled"];
    private _ctrl = _display displayCtrl _idc;
    if (_enabled) then {
        _ctrl ctrlSetPositionX _offsetX;
        _ctrl ctrlCommit 0;
        _offsetX = _offsetX + POS_W(1.5);
    } else {
        _ctrl ctrlShow false;
    };
} forEach _list;