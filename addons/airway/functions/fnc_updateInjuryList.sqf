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
    ACELSTRING(medical_gui,Head),
    ACELSTRING(medical_gui,Torso),
    ACELSTRING(medical_gui,LeftArm),
    ACELSTRING(medical_gui,RightArm),
    ACELSTRING(medical_gui,LeftLeg),
    ACELSTRING(medical_gui,RightLeg)
] select _selectionN;

_entries pushBack [localize _bodyPartName, [1, 1, 1, 1]];

// Indicate if unit is bleeding at all
if (IS_BLEEDING(_target)) then {
    _entries pushBack [localize ACELSTRING(medical_gui,Status_Bleeding), [1, 0, 0, 1]];
};

if(ACEGVAR(medical_gui,showBloodLossEntry)) then {
    // Give a qualitative description of the blood volume lost
    switch (GET_HEMORRHAGE(_target)) do {
        case 1: {
            _entries pushBack [localize ACELSTRING(medical_gui,Lost_Blood1), [1, 1, 0, 1]];
        };
        case 2: {
            _entries pushBack [localize ACELSTRING(medical_gui,Lost_Blood2), [1, 0.67, 0, 1]];
        };
        case 3: {
            _entries pushBack [localize ACELSTRING(medical_gui,Lost_Blood3), [1, 0.33, 0, 1]];
        };
        case 4: {
            _entries pushBack [localize ACELSTRING(medical_gui,Lost_Blood4), [1, 0, 0, 1]];
        };
    };
};

// Indicate if a tourniquet is applied
if (HAS_TOURNIQUET_APPLIED_ON(_target,_selectionN)) then {
    _entries pushBack [localize ACELSTRING(medical_gui,Status_Tourniquet_Applied), [0.77, 0.51, 0.08, 1]];
};

// Indicate current body part fracture status
switch (GET_FRACTURES(_target) select _selectionN) do {
    case 1: {
        _entries pushBack [localize ACELSTRING(medical_gui,Status_Fractured), [1, 0, 0, 1]];
    };
    case -1: {
        if ((ACEGVAR(medical,fractures)) in [2, 3]) then {
            _entries pushBack [localize ACELSTRING(medical_gui,Status_SplintApplied), [0.2, 0.2, 1, 1]];
        };
    };
};

// Indicate the amount of pain the unit is in
if (_target call ACEFUNC(common,isAwake)) then {
    private _pain = GET_PAIN_PERCEIVED(_target);
    if (_pain > 0) then {
        private _painText = switch (true) do {
            case (_pain > 0.5): {
                ACELSTRING(medical_treatment,Status_SeverePain);
            };
            case (_pain > 0.1): {
                ACELSTRING(medical_treatment,Status_Pain);
            };
            default {
                ACELSTRING(medical_treatment,Status_MildPain);
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
    private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
    private _suffix = ["Minor", "Medium", "Large"] select _category;
    private _woundName = localize format ["STR_ACE_medical_damage_%1_%2", _className, _suffix];
    if (_amountOf >= 1) then {
        format ["%1x %2", ceil _amountOf, _woundName];
    } else {
        format [localize ACELSTRING(medical_gui,PartialX), _woundName];
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
            if (ACEGVAR(medical_treatment,advancedBandages) < 2) then {
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

//INTOXICATION by DiGii
private _poisentype = _target getVariable [QEGVAR(chemical,poisenType),""];
if(_target getVariable [QEGVAR(chemical,airPoisoning),false]) then{
    _woundEntries pushBack [LELSTRING(chemical,Intoxikation), [0.4,0,0.5,1]];
};

// EDIT by Katalam & Tomcat
if (_target getVariable [QGVAR(airway), false] && _selectionN isEqualTo 0) then {
    private _a = _target getVariable [QGVAR(airway_item), ""];
    if !(_a isEqualTo "") then {
        private _text = format [LSTRING(%1_Display), _a];
        _woundEntries pushback [localize _text, [0.1, 1, 1, 1]];
    };
};

if (_target getVariable [QGVAR(overstretch), false] && _selectionN isEqualTo 0) then {
    _woundEntries pushback [LLSTRING(overstretched), [0.1, 1, 1, 1]];
};

if (_target getVariable [QGVAR(recovery), false]) then {
    _entries pushback [LLSTRING(RecoveryPosition), [0.1, 1, 1, 1]];
};

// Display cyanosis in overview tab, only when head/arms are selected
if (EGVAR(breathing,cyanosisShowInMenu) && (_selectionN in [0,2,3])) then {
    private _spO2 = 0;

    if (alive _target) then {
        _spO2 = GET_SPO2(_target);
    };

    if (_spO2 <= EGVAR(breathing,slightValue) || HAS_TOURNIQUET_APPLIED_ON(_target,_selectionN)) then {
        private _cyanosisArr = switch (true) do {
            case (HAS_TOURNIQUET_APPLIED_ON(_target,_selectionN));
            case (_spO2 <= EGVAR(breathing,severeValue)): {
                [LELSTRING(breathing,CyanosisStatus_Severe), [0.16, 0.16, 1, 1]];
            };
            case (_spO2 <= EGVAR(breathing,mildValue)): {
                [LELSTRING(breathing,CyanosisStatus_Mild), [0.16, 0.315, 1, 1]];
            };
            default {
                [LELSTRING(breathing,CyanosisStatus_Slight), [0.16, 0.47, 1, 1]];
            };
        };
        _entries pushBack [(_cyanosisArr select 0), (_cyanosisArr select 1)];
    };
};

private _tensionhemothorax = false;
if (!(EGVAR(breathing,showPneumothorax_dupe))) then {
    if ((_target getVariable [QEGVAR(breathing,hemopneumothorax), false]) || (_target getVariable [QEGVAR(breathing,tensionpneumothorax), false])) then {
        _tensionhemothorax = true;
    };
};

if (_target getVariable [QEGVAR(breathing,pneumothorax), false] && _selectionN isEqualTo 1 && !(EGVAR(breathing,pneumothorax_hardcore)) && !(_tensionhemothorax)) then {
    _woundEntries pushback [LELSTRING(breathing,pneumothorax_mm), [1,1,1,1]];
};

if (_target getVariable [QEGVAR(breathing,hemopneumothorax), false] && _selectionN isEqualTo 1 && !(EGVAR(breathing,tensionhemothorax_hardcore))) then {
    _woundEntries pushback [LELSTRING(breathing,hemopneumothorax_mm), [1,1,1,1]];
};

if (_target getVariable [QEGVAR(breathing,tensionpneumothorax), false] && _selectionN isEqualTo 1 && !(EGVAR(breathing,tensionhemothorax_hardcore))) then {
    _woundEntries pushback [LELSTRING(breathing,tensionpneumothorax_mm), [1,1,1,1]];
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
} forEach (_target getVariable [QACEGVAR(medical,ivBags), []]);

if (_totalIvVolume >= 1) then {
    if (_saline > 1) then {
        _entries pushBack ["Saline: " + (format [localize ACELSTRING(medical_treatment,receivingIvVolume), floor _saline]), [1, 1, 1, 1]];
    };
    if (_blood > 1) then {
        _entries pushBack ["Blood: " + (format [localize ACELSTRING(medical_treatment,receivingIvVolume), floor _blood]), [1, 1, 1, 1]];
    };
    if (_plasma > 1) then {
        _entries pushBack ["Plasma: " + (format [localize ACELSTRING(medical_treatment,receivingIvVolume), floor _plasma]), [1, 1, 1, 1]];
    };
};

//Handle IV placement
private _placed = _target getVariable [QEGVAR(pharma,IV), [0,0,0,0,0,0]];
private _IVactual = _placed select _selectionN;

if (_IVactual > 0) then {
    if (_IVactual == 1) then {
        _entries pushBack [LELSTRING(pharma,IO_45_Display), [0.3, 0.6, 0.3, 1]];
    } else {
        _entries pushBack [LELSTRING(pharma,IV_16_Display), [0.3, 0.6, 0.3, 1]];
    };
};

// Handle no wound entries
if (_woundEntries isEqualTo []) then {
    _entries pushBack [localize ACELSTRING(medical_treatment,NoInjuriesBodypart), [1, 1, 1, 1]];
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
