#include "script_component.hpp"
/*
 * Author: Glowbal Edit: Katalam
 * Update all UI information in the medical menu
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, some_display] call ace_medical_menu_fnc_updateUIInfo;
 *
 * Public: No
 */

params ["_target", "_display"];

if (isNil "_display" || {isNull _display}) exitWith {};

private _selectionN = ace_medical_menu_selectedBodyPart;
if (_selectionN < 0 || {_selectionN > 5}) exitWith {};

private _genericMessages = [];
private _partText = ["STR_ACE_medical_Head", "STR_ACE_medical_Torso", "STR_ACE_medical_LeftArm", "STR_ACE_medical_RightArm", "STR_ACE_medical_LeftLeg", "STR_ACE_medical_RightLeg"] select _selectionN;
_genericMessages pushBack [localize _partText, [1, 1, 1, 1]];

if (_target getVariable ["ace_medical_isBleeding", false]) then {
    _genericMessages pushBack [localize "STR_ACE_medical_Status_Bleeding", [1, 0.1, 0.1, 1]];
};

if (_target getVariable ["ace_medical_hasLostBlood", 0] > 1) then {
    _genericMessages pushBack [localize "STR_ACE_medical_Status_Lost_Blood", [1, 0.1, 0.1, 1]];
};

if ((_target getVariable ["ace_medical_tourniquets", [0, 0, 0, 0, 0, 0]] select _selectionN) > 0) then {
    _genericMessages pushBack [localize "STR_ACE_medical_Status_Tourniquet_Applied", [0.77, 0.51, 0.08, 1]];
};

// EDIT by Katalam
if (_target getVariable [QGVAR(airway), false] && _selectionN isEqualTo 0) then {
    private _a = _target getVariable [QGVAR(airway_item), ""];
    if !(_a isEqualTo "") then {
      private _text = format [LSTRING(%1_Display), _a];
      _genericMessages pushback [localize _text, [0.1, 1, 1, 1]];
    };
};

if (_target getVariable [QGVAR(overstretch), false] && _selectionN isEqualTo 0) then {
  _genericMessages pushback [localize LSTRING(overstretched), [0.1, 1, 1, 1]];
};
// END of EDIT

if (_target getVariable ["ace_medical_hasPain", false]) then {
    _genericMessages pushBack [localize "STR_ACE_medical_Status_Pain", [1, 1, 1, 1]];
};

private _totalIvVolume = 0;
private _bloodBags = _target getVariable ["ace_medical_ivBags", []];
{
    _x params ["_bagVolumeRemaining"];
    _totalIvVolume = _totalIvVolume + _bagVolumeRemaining;
} foreach _bloodBags;

if (_totalIvVolume >= 1) then {
    _genericMessages pushBack [format [localize "STR_ACE_medical_receivingIvVolume", floor _totalIvVolume], [1, 1, 1, 1]];
};

private _damaged = [false, false, false, false, false, false];
private _selectionBloodLoss = [0, 0, 0, 0, 0, 0];

// EDIT by Katalam
if (_target getVariable ["ace_medical_airwayCollapsed", false] && _selectionN isEqualTo 1) then {
    _genericMessages pushback [localize LSTRING(pneumothorax_mm), [1,1,1,1]];
};
// END of EDIT

private _allInjuryTexts = [];
if ((ace_medical_level >= 2) && {[_target] call ace_medical_fnc_hasMedicalEnabled}) then {
    private _openWounds = _target getVariable ["ace_medical_openWounds", []];
    {
        private _amountOf = _x select 3;
        // Find how much this bodypart is bleeding
        if (_amountOf > 0) then {
            _damaged set [_x select 2, true];
            _selectionBloodLoss set [_x select 2, (_selectionBloodLoss select (_x select 2)) + (20 * ((_x select 4) * _amountOf))];

            if (_selectionN == (_x select 2)) then {
            // Collect the text to be displayed for this injury [ Select injury class type definition - select the classname DisplayName (6th), amount of injuries for this]
                if (_amountOf >= 1) then {
                    // TODO localization
                    _allInjuryTexts pushBack [format["%2x %1", (ace_medical_AllWoundInjuryTypes select (_x select 1)) select 6, ceil _amountOf], [1,1,1,1]];
                } else {
                    // TODO localization
                    _allInjuryTexts pushBack [format["Partial %1", (ace_medical_AllWoundInjuryTypes select (_x select 1)) select 6], [1,1,1,1]];
                };
            };
        };
    } forEach _openWounds;

    private _bandagedwounds = _target getVariable ["ace_medical_bandagedWounds", []];
    {
        private _amountOf = _x select 3;
        // Find how much this bodypart is bleeding
        if !(_damaged select (_x select 2)) then {
            _selectionBloodLoss set [_x select 2, (_selectionBloodLoss select (_x select 2)) + (20 * ((_x select 4) * _amountOf))];
        };
        if (_selectionN == (_x select 2)) then {
            // Collect the text to be displayed for this injury [ Select injury class type definition - select the classname DisplayName (6th), amount of injuries for this]
            if (_amountOf > 0) then {
                if (_amountOf >= 1) then {
                    // TODO localization
                    _allInjuryTexts pushBack [format ["[B] %2x %1", (ace_medical_AllWoundInjuryTypes select (_x select 1)) select 6, ceil _amountOf], [0.88,0.7,0.65,1]];
                } else {
                    // TODO localization
                    _allInjuryTexts pushBack [format ["[B] Partial %1", (ace_medical_AllWoundInjuryTypes select (_x select 1)) select 6], [0.88,0.7,0.65,1]];
                };
            };
        };
    } forEach _bandagedwounds;
} else {

    // Add all bleeding from wounds on selection
    private _openWounds = _target getVariable ["ace_medical_openWounds", []];
    {
        private _amountOf = _x select 3;
        // Find how much this bodypart is bleeding
        if (_amountOf > 0) then {
            _damaged set [_x select 2, true];
            _selectionBloodLoss set [_x select 2, (_selectionBloodLoss select (_x select 2)) + (20 * ((_x select 4) * _amountOf))];
        };
    } forEach _openWounds;

    private _bandagedwounds = _target getVariable ["ace_medical_bandagedWounds", []];
    {
        private _amountOf = _x select 3;
        // Find how much this bodypart is bleeding
        if !(_damaged select (_x select 2)) then {
            _selectionBloodLoss set [_x select 2, (_selectionBloodLoss select (_x select 2)) + (20 * ((_x select 4) * _amountOf))];
        };
    } forEach _bandagedwounds;

    private _bloodLossOnSelection = _selectionBloodLoss select _selectionN;
    if (_bloodLossOnSelection > 0) then {
        private _severity = switch (true) do {
            case (_bloodLossOnSelection > 0.5): {localize "STR_ACE_medical_HeavilyWounded"};
            case (_bloodLossOnSelection > 0.1): {localize "STR_ACE_medical_LightlyWounded"};
            default {localize "STR_ACE_medical_VeryLightlyWounded"};
        };
        private _part = localize ([
            "STR_ACE_medical_Head",
            "STR_ACE_medical_Torso",
            "STR_ACE_medical_LeftArm",
            "STR_ACE_medical_RightArm",
            "STR_ACE_medical_LeftLeg",
            "STR_ACE_medical_RightLeg"
        ] select _selectionN);
        _allInjuryTexts pushBack [format ["%1 %2", _severity, toLower _part], [1,1,1,1]];
    };
};

[_selectionBloodLoss, _damaged, _display] call ace_medical_menu_fnc_updateBodyImage;
[_display, _genericMessages, _allInjuryTexts] call ace_medical_menu_fnc_updateInformationLists;
[_display, _target getVariable ["ace_medical_tourniquets", [0,0,0,0,0,0]]] call ace_medical_fnc_updateTourniquets;

[_display, _target getVariable ["ace_medical_logFile_activity_view", []]] call ace_medical_menu_fnc_updateActivityLog;
[_display, _target getVariable ["ace_medical_logFile_quick_view", []]] call ace_medical_menu_fnc_updateQuickViewLog;

private _triageStatus = [_target] call ace_medical_fnc_getTriageStatus;
(_display displayCtrl 2000) ctrlSetText (_triageStatus select 0);
(_display displayCtrl 2000) ctrlSetBackgroundColor (_triageStatus select 2);
