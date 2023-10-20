#include "..\script_component.hpp"
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
if(isNull findDisplay 312) then {
    if !([ACE_player, ACEGVAR(medical_gui,target), ["isNotInside", "isNotSwimming"]] call ACEFUNC(common,canInteractWith) && {[ACE_player, ACEGVAR(medical_gui,target)] call ACEFUNC(medical_gui,canOpenMenu)}) then {
        closeDialog 0;
        // Show hint if distance condition failed
        if ((ACE_player distance ACEGVAR(medical_gui,target) > ACEGVAR(medical_gui,maxDistance)) && {vehicle ACE_player != vehicle ACEGVAR(medical_gui,target)}) then {
            [[ACELLSTRING(medical,DistanceToFar), ACEGVAR(medical_gui,target) call ACEFUNC(common,getName)], 2] call ACEFUNC(common,displayTextStructured);
        };
    };
};

// Get the Medical Menu display
private _display = uiNamespace getVariable [QACEGVAR(medical_gui,menuDisplay), displayNull];
if (isNull _display) exitWith {};

// Update treatment category buttons
[_display] call ACEFUNC(medical_gui,updateCategories);

// Update treatment actions for current category
[_display] call ACEFUNC(medical_gui,updateActions);

// Update injury list
private _ctrlInjuries = _display displayCtrl IDC_INJURIES;
[_ctrlInjuries, ACEGVAR(medical_gui,target), ACEGVAR(medical_gui,selectedBodyPart)] call ACEFUNC(medical_gui,updateInjuryList);

// Update body image
private _ctrlBodyImage = _display displayCtrl IDC_BODY_GROUP;
[_ctrlBodyImage, ACEGVAR(medical_gui,target), ACEGVAR(medical_gui,selectedBodyPart)] call ACEFUNC(medical_gui,updateBodyImage);

// Update activity and quick view logs
private _ctrlActivityLog = _display displayCtrl IDC_ACTIVITY;
private _activityLog = ACEGVAR(medical_gui,target) getVariable [MED_LOG_VARNAME("activity"), []];
[_ctrlActivityLog, _activityLog] call ACEFUNC(medical_gui,updateLogList);

private _ctrlQuickView = _display displayCtrl IDC_QUICKVIEW;
private _quickView = ACEGVAR(medical_gui,target) getVariable [MED_LOG_VARNAME("quick_view"), []];
[_ctrlQuickView, _quickView] call ACEFUNC(medical_gui,updateLogList);

// Update triage status
[_display, ACEGVAR(medical_gui,target)] call ACEFUNC(medical_gui,updateTriageStatus);
