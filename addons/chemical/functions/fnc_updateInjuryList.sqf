#include "script_component.hpp"
///////////

///////////
params ["_ctrl", "_target","_selectionN"];
private _entries = [];





// Add selected body part name
private _bodyPartName = [
    "STR_ACE_Medical_GUI_HEAD",
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

private _poisentype = _target getVariable ["kat_medical_poisenType",""];
if(_target getVariable ["kat_chemical_airPoisend",false]) then{
    _entries pushBack [LLSTRING(Intoxikation), [0.4,0,0.5,1]];
};



// Indicate current body part fracture status
switch (GET_FRACTURES(_target) select _selectionN) do {
    case 1: {
        _entries pushBack [localize "STR_ACE_Medical_GUI_Status_Fractured", [1, 0, 0, 1]];
    };
    case -1: {
        if (ace_medical_fractured in [2, 3]) then { // Ignore if the splint has no effect
            _entries pushBack [localize "STR_ACE_Medical_GUI_Status_SplintApplied", [0.2, 0.2, 1, 1]];
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

private _fnc_processWounds = {
    params ["_wounds", "_format", "_color"];

    {
        _x params ["_woundClassID", "_bodyPartN", "_amountOf"];

        if (_selectionN == _bodyPartN && {_amountOf > 0}) then {
            private _classIndex = _woundClassID / 10;
            private _category   = _woundClassID % 10;

            private _className = ace_medical_damage_woundsData select _classIndex select 6;
            private _suffix = ["Minor", "Medium", "Large"] select _category;
            private _woundName = localize format ["STR_ACE_Medical_Damage_%1_%2", _className, _suffix];

            private _woundDescription = if (_amountOf >= 1) then {
                format ["%1x %2", ceil _amountOf, _woundName]
            } else {
                format [localize "STR_ACE_Medical_GUI_Status_PartialX", _woundName]
            };

            _woundEntries pushBack [format [_format, _woundDescription], _color];
        };
    } forEach _wounds;
};

[GET_OPEN_WOUNDS(_target), "%1", [1, 1, 1, 1]] call _fnc_processWounds;
[GET_BANDAGED_WOUNDS(_target), "[B] %1", [0.88, 0.7, 0.65, 1]] call _fnc_processWounds;
[GET_STITCHED_WOUNDS(_target), "[S] %1", [0.7, 0.7, 0.7, 1]] call _fnc_processWounds;

// Handle no wound entries
if (_woundEntries isEqualTo []) then {
    _entries pushBack [localize "STR_ACE_medical_treatment_NoInjuriesBodypart", [1, 1, 1, 1]];
} else {
    _entries append _woundEntries;
};




lbClear _ctrl;
{
    _x params ["_text", "_color"];

    _ctrl lbSetColor [_ctrl lbAdd _text, _color];
} forEach _entries;

_ctrl lbSetCurSel -1;