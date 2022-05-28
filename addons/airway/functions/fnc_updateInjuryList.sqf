#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates injury list for given body part for the target.
 *
 * Arguments:
 * 0: Injury list <CONTROL>
 * 1: Target <OBJECT>
 * 2: Body part <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrlInjuries, _target, 0] call ace_medical_gui_fnc_updateInjuryList
 *
 * Public: No
 */

params ["_ctrl", "_target", "_selectionN"];

private _entries = [];

// Add selected body part name
private _bodyPartName = [
    "STR_ACE_medical_gui_Head",
    "STR_ACE_medical_gui_Torso",
    "STR_ACE_medical_gui_LeftArm",
    "STR_ACE_medical_gui_RightArm",
    "STR_ACE_medical_gui_LeftLeg",
    "STR_ACE_medical_gui_RightLeg"
] select _selectionN;

_entries pushBack [localize _bodyPartName, [1, 1, 1, 1]];

// Indicate if unit is bleeding at all
if (IS_BLEEDING(_target)) then {
    _entries pushBack [localize "STR_ACE_medical_gui_Status_Bleeding", [1, 0, 0, 1]];
};

// Give a qualitative description of the blood volume lost
switch (GET_HEMORRHAGE(_target)) do {
    case 1: {
        _entries pushBack [localize "STR_ACE_medical_gui_Lost_Blood1", [1, 1, 0, 1]];
    };
    case 2: {
        _entries pushBack [localize "STR_ACE_medical_gui_Lost_Blood2", [1, 0.67, 0, 1]];
    };
    case 3: {
        _entries pushBack [localize "STR_ACE_medical_gui_Lost_Blood3", [1, 0.33, 0, 1]];
    };
    case 4: {
        _entries pushBack [localize "STR_ACE_medical_gui_Lost_Blood4", [1, 0, 0, 1]];
    };
};

// Indicate if a tourniquet is applied
if (HAS_TOURNIQUET_APPLIED_ON(_target,_selectionN)) then {
    _entries pushBack [localize "STR_ACE_medical_gui_Status_Tourniquet_Applied", [0.77, 0.51, 0.08, 1]];
};

// Indicate current body part fracture status
switch (GET_FRACTURES(_target) select _selectionN) do {
    case 1: {
        _entries pushBack [localize "STR_ACE_medical_gui_Status_Fractured", [1, 0, 0, 1]];
    };
    case -1: {
        if ((ace_medical_fractures) in [2, 3]) then { 
            _entries pushBack [localize "STR_ACE_medical_gui_Status_SplintApplied", [0.2, 0.2, 1, 1]];    
        };
    };
};

// Indicate the amount of pain the unit is in
if (_target call ace_common_fnc_isAwake) then {
    private _pain = GET_PAIN_PERCEIVED(_target);
    if (_pain > 0) then {
        private _painText = switch (true) do {
            case (_pain > 0.5): {
                "STR_ACE_medical_treatment_Status_SeverePain";
            };
            case (_pain > 0.1): {
                "STR_ACE_medical_treatment_Status_Pain";
            };
            default {
                "STR_ACE_medical_treatment_Status_MildPain";
            };
        };
        _entries pushBack [localize _painText, [1, 1, 1, 1]];
    };
};

// Add entries for open, bandaged, and stitched wounds
private _woundEntries = [];

private _fnc_getWoundDescription = {
    private _classIndex = _woundClassID / 10;
    private _category = _woundClassID % 10;
    private _className = ace_medical_damage_woundClassNames select _classIndex;
    private _suffix = ["Minor", "Medium", "Large"] select _category;
    private _woundName = localize format ["STR_ACE_medical_damage_%1_%2", _className, _suffix];
    if (_amountOf >= 1) then {
        format ["%1x %2", ceil _amountOf, _woundName];
    } else {
        format [localize "STR_ACE_medical_gui_PartialX", _woundName];
    };
};

{
    _x params ["_woundClassID", "_bodyPartN", "_amountOf"];
    if (_selectionN == _bodyPartN) then {
        if (_amountOf > 0) then {
            _woundEntries pushBack [call _fnc_getWoundDescription, [1, 1, 1, 1]];
        } else {
            // ace_medical_treatment_advancedBandages
            // Disabled == 0
            // Enabled == 1
            // EnabledCanReopen == 2
            if (ace_medical_treatment_advancedBandages < 2) then {
                _woundEntries pushBack [format ["[B] %1", call _fnc_getWoundDescription], [0.7, 0.7, 0.7, 1]];
            };
        };
    };
} forEach GET_OPEN_WOUNDS(_target);

{
    _x params ["_woundClassID", "_bodyPartN", "_amountOf"];
    if (_selectionN == _bodyPartN && {_amountOf > 0}) then {
        _woundEntries pushBack [format ["[B] %1", call _fnc_getWoundDescription], [0.88, 0.7, 0.65, 1]];
    };
} forEach GET_BANDAGED_WOUNDS(_target);

{
    _x params ["_woundClassID", "_bodyPartN", "_amountOf"];
    if (_selectionN == _bodyPartN && {_amountOf > 0}) then {
        _woundEntries pushBack [format ["[S] %1", call _fnc_getWoundDescription], [0.7, 0.7, 0.7, 1]];
    };
} forEach GET_STITCHED_WOUNDS(_target);

// EDIT by Katalam & Tomcat
if (_target getVariable [QGVAR(airway), false] && _selectionN isEqualTo 0) then {
    private _a = _target getVariable [QGVAR(airway_item), ""];
    if !(_a isEqualTo "") then {
        private _text = format [LSTRING(%1_Display), _a];
        _woundEntries pushback [localize _text, [0.1, 1, 1, 1]];
    };
};

if (_target getVariable [QGVAR(overstretch), false] && _selectionN isEqualTo 0) then {
    _woundEntries pushback [localize LSTRING(overstretched), [0.1, 1, 1, 1]];
};

if (_target getVariable [QGVAR(recovery), false] && _selectionN isEqualTo 0) then {
    _woundEntries pushback [localize LSTRING(RecoveryPosition), [0.1, 1, 1, 1]];
};

private _tensionhemothorax = false;
if (!(kat_breathing_showPneumothorax_dupe)) then {
    if ((_target getVariable ["KAT_medical_tensionpneumothorax", false]) || (_target getVariable ["KAT_medical_hemopneumothorax", false])) then {
            _tensionhemothorax = true;
    };
};

if (_target getVariable ["KAT_medical_pneumothorax", false] && _selectionN isEqualTo 1 && !(kat_breathing_pneumothorax_hardcore) && !(_tensionhemothorax)) then {
    _woundEntries pushback [localize ELSTRING(breathing,pneumothorax_mm), [1,1,1,1]];
};

if (_target getVariable ["KAT_medical_hemopneumothorax", false] && _selectionN isEqualTo 1 && !(kat_breathing_tensionhemothorax_hardcore)) then {
    _woundEntries pushback [localize ELSTRING(breathing,hemopneumothorax_mm), [1,1,1,1]];
};

if (_target getVariable ["KAT_medical_tensionpneumothorax", false] && _selectionN isEqualTo 1 && !(kat_breathing_tensionhemothorax_hardcore)) then {
    _woundEntries pushback [localize ELSTRING(breathing,tensionpneumothorax_mm), [1,1,1,1]];
};

// Show receiving IV volume remaining
private _totalIvVolume = 0;
private _saline = 0;
private _blood = 0;
private _plasma = 0;

{
    _x params ["_volumeRemaining", "_type"];
    switch (_type) do {
        case ("Saline"): {
        _saline = _saline + _volumeRemaining;
        };
        case ("Blood"): {
        _blood = _blood + _volumeRemaining;
        };
        case ("Plasma"): {
        _plasma = _plasma + _volumeRemaining;
        };
    };
    _totalIvVolume = _totalIvVolume + _volumeRemaining;
} forEach (_target getVariable ["ace_medical_ivBags", []]);

if (_totalIvVolume >= 1) then {
    if (_saline > 1) then {
        _entries pushBack ["Saline: " + (format [localize "STR_ACE_medical_treatment_receivingIvVolume", floor _saline]), [1, 1, 1, 1]];
    };
    if (_blood > 1) then {
        _entries pushBack ["Blood: " + (format [localize "STR_ACE_medical_treatment_receivingIvVolume", floor _blood]), [1, 1, 1, 1]];
    };
    if (_plasma > 1) then {
        _entries pushBack ["Plasma: " + (format [localize "STR_ACE_medical_treatment_receivingIvVolume", floor _plasma]), [1, 1, 1, 1]];
    };
};

//Handle IV placement
private _placed = _target getVariable [QEGVAR(pharma,IVplaced), false];
private _site = _target getVariable [QEGVAR(pharma,IVsite), 0];

if (_placed && {_site == _selectionN}) then {
    if (_site > 1) then {
        private _text = format ["STR_kat_pharma_%1_Display", "IV_16"];
        _woundEntries pushback [localize _text, [0.3, 0.3, 0.5, 1]];
    } else {
        private _text = format ["STR_kat_pharma_%1_Display", "IO_45"];
        _woundEntries pushback [localize _text, [0.3, 0.3, 0.5, 1]];
    };
};

// Handle no wound entries
if (_woundEntries isEqualTo []) then {
    _entries pushBack [localize "STR_ACE_medical_treatment_NoInjuriesBodypart", [1, 1, 1, 1]];
} else {
    _entries append _woundEntries;
};

// Add all entries to injury list
lbClear _ctrl;

{
    _x params ["_text", "_color"];

    _ctrl lbSetColor [_ctrl lbAdd _text, _color];
} forEach _entries;

_ctrl lbSetCurSel -1;
