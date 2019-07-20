#include "script_component.hpp"
#define HAS_TOURNIQUET_APPLIED_ON(unit,index) ((unit getVariable ["ace_medical_tourniquets", [0,0,0,0,0,0]] select index) > 0)
#define GET_HEMORRHAGE(unit)        (unit getVariable ["ace_medical_hemorrhage",0])
#define IS_BLEEDING(unit)           (unit getVariable ["ace_medical_isBleeding",false])
#define GET_PAIN_PERCEIVED(unit)    ((0 max (unit getVariable ["ace_medical_pain",0]) - (unit getVariable ["ace_medical_painSuppress",0])) min 1)
#define HAS_AIRWAY(unit,index)    (index == 0 && {unit getVariable [QGVAR(airway), [false, ""]] select 0})
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
    "STR_ACE_Medical_GUI_Head",
    "STR_ACE_Medical_GUI_Torso",
	"STR_ACE_Medical_GUI_LeftArm",
	"STR_ACE_Medical_GUI_RightArm",
	"STR_ACE_Medical_GUI_LeftLeg",
	"STR_ACE_Medical_GUI_RightLeg"
] select _selectionN;

_entries pushBack [localize _bodyPartName, [1, 1, 1, 1]];

// Indicate if unit is bleeding at all
if (IS_BLEEDING(_target)) then {
    _entries pushBack [localize "STR_ACE_Medical_GUI_Status_Bleeding", [1, 0, 0, 1]];
};

// Give a qualitative description of the blood volume lost
switch (GET_HEMORRHAGE(_target)) do {
    case 1: {
        _entries pushBack [localize "STR_ACE_Medical_GUI_Lost_Blood1", [1, 0, 0, 1]];
    };
    case 2: {
        _entries pushBack [localize "STR_ACE_Medical_GUI_Lost_Blood2", [1, 0, 0, 1]];
    };
    case 3: {
        _entries pushBack [localize "STR_ACE_Medical_GUI_Lost_Blood3", [1, 0, 0, 1]];
    };
    case 4: {
        _entries pushBack [localize "STR_ACE_Medical_GUI_Lost_Blood4", [1, 0, 0, 1]];
    };
};

// Indicate if a tourniquet is applied
if (HAS_TOURNIQUET_APPLIED_ON(_target,_selectionN)) then {
    _entries pushBack [localize "STR_ACE_Medical_GUI_Status_Tourniquet_Applied", [0.77, 0.51, 0.08, 1]];
};

// EDIT by Katalam
// Airway control?
if (HAS_AIRWAY(_target,_selectionN)) then {
	private _a = _target getVariable [QGVAR(airway), [false, ""]] select 1;
	if (isClass (configFile >> "CfgWeapons" >> _a)) then {
	    private _text = getText (configFile >> "CfgWeapons" >> _a >> "displayName");
		_entries pushBack [_text, [0.1, 1, 1, 1]];
	};
};
// END of EDIT

// Indicate the amount of pain the unit is in
if ([_target] call ace_common_fnc_isAwake) then {
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

// Show receiving IV volume remaining
private _totalIvVolume = 0;
{
    _x params ["_volumeRemaining"];
    _totalIvVolume = _totalIvVolume + _volumeRemaining;
} forEach (_target getVariable ["ace_medical_ivBags", []]);

if (_totalIvVolume >= 1) then {
    _entries pushBack [format [localize "STR_ACE_medical_treatment_receivingIvVolume", floor _totalIvVolume], [1, 1, 1, 1]];
};

// Add entries for open, bandaged, and stitched wounds
private _woundEntries = [];

private _fnc_getWoundDescription = {
    private _classIndex = _woundClassID / 10;
    private _category = _woundClassID % 10;
    private _className = ace_medical_damage_woundsData select _classIndex select 6;
    private _suffix = ["Minor", "Medium", "Large"] select _category;
    private _woundName = localize format ["STR_ACE_medical_damage_%1_%2", _className, _suffix];
    if (_amountOf >= 1) then {
        format ["%1x %2", ceil _amountOf, _woundName];
    } else {
        format ["Partial %1", _woundName];
    };
};

{
    _x params ["_woundClassID", "_bodyPartN", "_amountOf"];
    if (_selectionN == _bodyPartN) then {
        if (_amountOf > 0) then {
            _woundEntries pushBack [call _fnc_getWoundDescription, [1, 1, 1, 1]];
        } else {
            if !(ace_medical_treatment_advancedBandages && {ace_medical_treatment_woundReopening}) then {
                _woundEntries pushBack [format ["[B] %1", call _fnc_getWoundDescription], [0.7, 0.7, 0.7, 1]];
            };
        };
    };
} forEach (_target getVariable ["ace_medical_openWounds", []]);

{
    _x params ["_woundClassID", "_bodyPartN", "_amountOf"];
    if (_selectionN == _bodyPartN && {_amountOf > 0}) then {
        _woundEntries pushBack [format ["[B] %1", call _fnc_getWoundDescription], [0.88, 0.7, 0.65, 1]];
    };
} forEach (_target getVariable ["ace_medical_bandagedWounds", []]);

{
    _x params ["_woundClassID", "_bodyPartN", "_amountOf"];
    if (_selectionN == _bodyPartN && {_amountOf > 0}) then {
        _woundEntries pushBack [format ["[S] %1", call _fnc_getWoundDescription], [0.7, 0.7, 0.7, 1]];
    };
} forEach (_target getVariable ["ace_medical_stitchedWounds", []]);

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
    private _index = _ctrl lbAdd _text;
    _ctrl lbSetColor [_index, _color];
    _ctrl lbSetSelectColor [_index, _color];
} forEach _entries;
