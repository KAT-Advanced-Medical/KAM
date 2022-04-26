#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles updating the Medical Menu UI for the current target.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_medical_gui_fnc_menuPFH
 *
 * Public: No
 *
 * THIS IS MODYFIED TO ALLOW THE "CHECK UNIT MEDICAL MENU" ZEUS MODULE TO WORK
 */

// Check if menu should stay open for target
if(isNUll findDisplay 312) then {
	if !([ACE_player, ace_medical_gui_target, ["isNotInside", "isNotSwimming"]] call ace_common_fnc_canInteractWith && {[ACE_player, ace_medical_gui_target] call ace_medical_gui_fnc_canOpenMenu}) then {
		closeDialog 0;
		// Show hint if distance condition failed
		if ((ACE_player distance ace_medical_gui_target > ace_medical_gui_maxDistance) && {vehicle ACE_player != vehicle ace_medical_gui_target}) then {
			[["$STR_ACE_Medical_DistanceToFar", ace_medical_gui_target call ace_common_fnc_getName], 2] call ace_common_fnc_displayTextStructured;
		};
	};
};

// Get the Medical Menu display
private _display = uiNamespace getVariable ["ace_medical_gui_menuDisplay", displayNull];
if (isNull _display) exitWith {};

// Update treatment category buttons
[_display] call ace_medical_gui_fnc_updateCategories;

// Update treatment actions for current category
[_display] call ace_medical_gui_fnc_updateActions;

// Update injury list
private _ctrlInjuries = _display displayCtrl IDC_INJURIES;
[_ctrlInjuries, ace_medical_gui_target, ace_medical_gui_selectedBodyPart] call ace_medical_gui_fnc_updateInjuryList;

// Update body image
private _ctrlBodyImage = _display displayCtrl IDC_BODY_GROUP;
[_ctrlBodyImage, ace_medical_gui_target] call ace_medical_gui_fnc_updateBodyImage;

// Update activity and quick view logs
private _ctrlActivityLog = _display displayCtrl IDC_ACTIVITY;
private _activityLog = ace_medical_gui_target getVariable [MED_LOG_VARNAME("activity"), []];
[_ctrlActivityLog, _activityLog] call ace_medical_gui_fnc_updateLogList;

private _ctrlQuickView = _display displayCtrl IDC_QUICKVIEW;
private _quickView = ace_medical_gui_target getVariable [MED_LOG_VARNAME("quick_view"), []];
[_ctrlQuickView, _quickView] call ace_medical_gui_fnc_updateLogList;

// Update triage status
[_display, ace_medical_gui_target] call ace_medical_gui_fnc_updateTriageStatus;
