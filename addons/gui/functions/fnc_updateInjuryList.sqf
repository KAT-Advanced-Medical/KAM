#include "..\script_component.hpp"
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
private _nonissueColor = [1, 1, 1, 0.33];
private _wounds = GET_OPEN_WOUNDS(_target);
private _hasExternalBleeding = false;

{
    private _bodyPart = _x;
    private _woundList = _wounds get _bodyPart;

    {
        private _woundClassID = _x select 0;
        private _amountOf     = _x select 1;
        private _bleeding     = _x select 2;

        private _classIndex = _woundClassID / 10;
        private _className  = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
        if (
            _amountOf > 0 
            && {_className != "InternalBleeding"} 
            && {_bleeding > 0}
        ) exitWith {
            _hasExternalBleeding = true;
        };
    } forEach _woundList;

    if (_hasExternalBleeding) exitWith {};
} forEach (keys _wounds);

// Indicate if unit is bleeding at all
if (_hasExternalBleeding && (IS_BLEEDING(_target))) then {
    switch (GVAR(showBleeding)) do {
        case 1: {
        //  Just show whether the unit is bleeding at all
            _entries pushBack [localize ACELSTRING(medical_gui,Status_Bleeding), [1, 0, 0, 1]];
        };
        case 2: {
            // Give a qualitative description of the rate of bleeding
            private _cardiacOutput = [_target] call EFUNC(vitals,getCardiacOutput);
            private _bleedRate = GET_BLOOD_LOSS(_target);
            private _bleedRateKO = BLOOD_LOSS_KNOCK_OUT_THRESHOLD * (_cardiacOutput max 0.05);
            // Use nonzero minimum cardiac output to prevent all bleeding showing as massive during cardiac arrest
            switch (true) do {
                case (_bleedRate < _bleedRateKO * BLEED_RATE_SLOW): {
                    _entries pushBack [localize ACELSTRING(medical_gui,Bleed_Rate1), [1, 1, 0, 1]];
                };
                case (_bleedRate < _bleedRateKO * BLEED_RATE_MODERATE): {
                    _entries pushBack [localize ACELSTRING(medical_gui,Bleed_Rate2), [1, 0.67, 0, 1]];
                };
                case (_bleedRate < _bleedRateKO * BLEED_RATE_SEVERE): {
                    _entries pushBack [localize ACELSTRING(medical_gui,Bleed_Rate3), [1, 0.33, 0, 1]];
                };
                default {
                    _entries pushBack [localize ACELSTRING(medical_gui,Bleed_Rate4), [1, 0, 0, 1]];
                };
            };
        };
        case 3: {
            // Give a qualitative description of the rate of bleeding on a limb by limb basis
            if (HAS_LIMB_BLEEDING(_target,_selectionN)) then {
                private _cardiacOutput = [_target] call EFUNC(vitals,getCardiacOutput);

                private _bleedRate = GET_BODY_PART_RATE(_target,_selectionN);
                private _bleedRateKO = BLOOD_LOSS_KNOCK_OUT_THRESHOLD * (_cardiacOutput max 0.05);
                // Use nonzero minimum cardiac output to prevent all bleeding showing as massive during cardiac arrest
                switch (true) do {
                    case (_bleedRate < (_bleedRateKO * BLEED_RATE_SLOW * 8)): {
                        _entries pushBack [localize ACELSTRING(medical_gui,Bleed_Rate1), [1, 1, 0, 1]];
                    };
                    case (_bleedRate < (_bleedRateKO * BLEED_RATE_MODERATE * 8)): {
                        _entries pushBack [localize ACELSTRING(medical_gui,Bleed_Rate2), [1, 0.67, 0, 1]];
                    };
                    case (_bleedRate < (_bleedRateKO * BLEED_RATE_SEVERE * 8)): {
                        _entries pushBack [localize ACELSTRING(medical_gui,Bleed_Rate3), [1, 0.33, 0, 1]];
                    };
                    default {
                        _entries pushBack [localize ACELSTRING(medical_gui,Bleed_Rate4), [1, 0, 0, 1]];
                    };
                };
            };
        };
    };
} else {
    _entries pushBack [localize ACELSTRING(medical_gui,Status_Nobleeding), _nonissueColor];
};

if (ACEGVAR(medical_gui,showBloodlossEntry)) then {
    // Give a qualitative description of the blood volume lost
    switch (GET_HEMORRHAGE(_target)) do {
        case 0: {
            if (ACEGVAR(medical_gui,showInactiveStatuses)) then {_entries pushBack [localize ACELSTRING(medical_gui,Lost_Blood0), _nonissueColor];};
        };
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

// Show receiving IV volume remaining
private _totalIvVolume = 0;
private _saline = 0;
private _blood = 0;
private _plasma = 0;
private _ringers = 0;
private _packedRBC = 0;
private _MorphineIVInfusion = 0;
private _EpinephrineIVInfusion = 0;
private _EtomidateIVInfusion = 0;
private _DoxapramIVInfusion = 0;
private _NitroglycerinIVInfusion = 0;
private _NorepinephrineIVInfusion = 0;
{
    _x params ["_volumeRemaining", "_type", "_partIndex"];
    if (_partIndex == _selectionN) then{
        switch (_type) do {
        case "Saline": {
            _saline = _saline + _volumeRemaining;
        };
        case "Blood": {
            _blood = _blood + _volumeRemaining;
        };
        case "Plasma": {
            _plasma = _plasma + _volumeRemaining;
        };
        case "Ringers Lactate": {
            _ringers = _ringers + _volumeRemaining;
        };
        case "PackedRBC": {
            _packedRBC = _packedRBC + _volumeRemaining;
        };
        case "Morphine_IVInfusion": {
            _MorphineIVInfusion = _MorphineIVInfusion + _volumeRemaining;
        };
        case "Epinephrine_IVInfusion": {
            _EpinephrineIVInfusion = _EpinephrineIVInfusion + _volumeRemaining;
        };
        case "Etomidate_IVInfusion": {
            _EtomidateIVInfusion = _EtomidateIVInfusion + _volumeRemaining;
        };
        case "Doxapram_IVInfusion": {
            _DoxapramIVInfusion = _DoxapramIVInfusion + _volumeRemaining;
        };
        case "Nitroglycerin_IVInfusion": {
            _NitroglycerinIVInfusion = _NitroglycerinIVInfusion + _volumeRemaining;
        };
        case "Norepinephrine_IVInfusion": {
            _NorepinephrineIVInfusion = _NorepinephrineIVInfusion + _volumeRemaining;
        };
    };
    _totalIvVolume = _totalIvVolume + _volumeRemaining;
    };
} forEach (_target getVariable [QACEGVAR(medical,ivBags), []]);

if (_totalIvVolume > 0) then {
    if (_saline > 0) then {
        _entries pushBack [format [localize ACELSTRING(medical_treatment,receivingSalineIvVolume), floor _saline], [1, 1, 1, 1]];
    };
    if (_blood > 0) then {
        _entries pushBack [format [localize ACELSTRING(medical_treatment,receivingBloodIvVolume), floor _blood], [1, 1, 1, 1]];
    };
    if (_plasma > 0) then {
        _entries pushBack [format [localize ACELSTRING(medical_treatment,receivingPlasmaIvVolume), floor _plasma], [1, 1, 1, 1]];
    };
    if (_ringers > 0) then {
        _entries pushBack [format [localize ELSTRING(pharma,receivingRingers_LactateIvVolume), floor _ringers], [1, 1, 1, 1]];
    };
    if (_packedRBC > 0) then {
        _entries pushBack [format [localize ELSTRING(pharma,receivingPacked_RBCIvVolume), floor _packedRBC], [1, 1, 1, 1]];
    };
    if (_DoxapramIVInfusion > 0) then {
        _entries pushBack [format [localize ELSTRING(pharma,receivingDoxapramIVInfusionVolume), floor _DoxapramIVInfusion], [1, 1, 1, 1]];
    };
    if (_EpinephrineIVInfusion > 0) then {
        _entries pushBack [format [localize ELSTRING(pharma,receivingEpinephrineIVInfusionVolume), floor _EpinephrineIVInfusion], [1, 1, 1, 1]];
    };
    if (_EtomidateIVInfusion > 0) then {
        _entries pushBack [format [localize ELSTRING(pharma,receivingEtomidateIVInfusionVolume), floor _EtomidateIVInfusion], [1, 1, 1, 1]];
    };
    if (_MorphineIVInfusion > 0) then {
        _entries pushBack [format [localize ELSTRING(pharma,receivingMorphineIVInfusionVolume), floor _MorphineIVInfusion], [1, 1, 1, 1]];
    };
    if (_NitroglycerinIVInfusion > 0) then {
        _entries pushBack [format [localize ELSTRING(pharma,receivingNitroglycerinIVInfusionVolume), floor _NitroglycerinIVInfusion], [1, 1, 1, 1]];
    };
    if (_NorepinephrineIVInfusion > 0) then {
        _entries pushBack [format [localize ELSTRING(pharma,receivingNorepinephrineIVInfusionVolume), floor _NorepinephrineIVInfusion], [1, 1, 1, 1]];
    };
} else {
    _entries pushBack [localize ACELSTRING(medical_treatment,Status_NoIv), _nonissueColor];
};
if ((_target getVariable [QEGVAR(pharma,pressureBag), [0,0,0,0,0,0,0,0,0,0,0,0]] select _selectionN) > 0) then {
    if ((_target getVariable [QEGVAR(pharma,pressureBag), [0,0,0,0,0,0,0,0,0,0,0,0]] select _selectionN) == 1) then {
        _entries pushBack [localize ELSTRING(pharma,IVPressureBag), [1, 1, 1, 1]];
    } else {
        _entries pushBack [localize ELSTRING(pharma,IVSqueezed), [1, 1, 1, 1]];
    };
};
// Indicate the amount of pain the unit is in
if (_target call ACEFUNC(common,isAwake) && ((_target == ACE_Player) || {!isPlayer _target}))  then {
    if (GVAR(localPain) && ((_target == ACE_Player) || {!isPlayer _target})) then {
        private _pain = GET_PAIN_PERCEIVED(_target);
            if (_pain > 0) then {
            private _painText = switch (true) do {
                case (_pain > PAIN_UNCONSCIOUS): {
                    ACELSTRING(medical_treatment,Status_SeverePain);
                };
                case (_pain > (PAIN_UNCONSCIOUS / 5)): {
                    ACELSTRING(medical_treatment,Status_Pain);
                };
                default {
                    ACELSTRING(medical_treatment,Status_MildPain);
                };
            };
            _entries pushBack [localize _painText, [1, 1, 1, 1]];
        } else {
            if (ACEGVAR(medical_gui,showInactiveStatuses)) then {_entries pushBack [localize ACELSTRING(medical_treatment,Status_NoPain), _nonissueColor];};
        };
    } else {
        private _pain = GET_PAIN_PERCEIVED(_target);
            if (_pain > 0) then {
            private _painText = switch (true) do {
                case (_pain > PAIN_UNCONSCIOUS): {
                    ACELSTRING(medical_treatment,Status_SeverePain);
                };
                case (_pain > (PAIN_UNCONSCIOUS / 5)): {
                    ACELSTRING(medical_treatment,Status_Pain);
                };
                default {
                    ACELSTRING(medical_treatment,Status_MildPain);
                };
            };
            _entries pushBack [localize _painText, [1, 1, 1, 1]];
        } else {
            if (ACEGVAR(medical_gui,showInactiveStatuses)) then {_entries pushBack [localize ACELSTRING(medical_treatment,Status_NoPain), _nonissueColor];};
        };
    };
};

// Skip the rest as they're body part specific
if (_selectionN == -1) exitWith {
    // Add all entries to injury list
    lbClear _ctrl;

    {
        _x params ["_text", "_color"];

        _ctrl lbSetColor [_ctrl lbAdd _text, _color];
    } forEach _entries;

    _ctrl lbSetCurSel -1;
};

[QACEGVAR(medical_gui,updateInjuryListGeneral), [_ctrl, _target, _selectionN, _entries]] call CBA_fnc_localEvent;

// Add selected body part name
private _bodyPartName = [
    ACELSTRING(medical_gui,Head),
    ELSTRING(hitpoints,Neck),
    ELSTRING(hitpoints,Chest),
    ACELSTRING(medical_gui,Torso),
    ACELSTRING(medical_gui,LeftArm),
    ELSTRING(hitpoints,UpperLeftArm),
    ACELSTRING(medical_gui,RightArm),
    ELSTRING(hitpoints,UpperRightArm),
    ACELSTRING(medical_gui,LeftLeg),
    ELSTRING(hitpoints,UpperLeftLeg),
    ACELSTRING(medical_gui,RightLeg),
    ELSTRING(hitpoints,UpperRightLeg)
] select _selectionN;

_entries pushBack [localize _bodyPartName, [1, 1, 1, 1]];

// Damage taken tooltip
if (ACEGVAR(medical_gui,showDamageEntry)) then {
    private _bodyPartDamage = GET_BODYPART_DAMAGE(_target) select _selectionN;
    if (_bodyPartDamage > 0) then {
        private _damageThreshold = GET_DAMAGE_THRESHOLD(_target);
        switch (true) do {
            case (_selectionN > 7): { // legs: index 4 & 5
                if (ACEGVAR(medical,limbDamageThreshold) != 0 && {[false, !isPlayer _target, true] select ACEGVAR(medical,useLimbDamage)}) then { // Just indicate how close to the limping threshold we are
                    _damageThreshold = _damageThreshold * ACEGVAR(medical,limbDamageThreshold);
                } else {
                    _damageThreshold = FRACTURE_DAMAGE_THRESHOLD * 4;
                };
            };
            case (_selectionN > 3): { // arms: index 2 & 3
                if (ACEGVAR(medical,limbDamageThreshold) != 0 && {[false, !isPlayer _target, true] select ACEGVAR(medical,useLimbDamage)}) then { // Just indicate how close to the fracture threshold we are
                    _damageThreshold = _damageThreshold * ACEGVAR(medical,limbDamageThreshold);
                } else {
                    _damageThreshold = FRACTURE_DAMAGE_THRESHOLD * 4;
                };
            };
            case (_selectionN > 1): { // chest and torso index 2-3
                _damageThreshold = _damageThreshold * 1.5;
            };
            default { // Head and neck index 0-1
                _damageThreshold = _damageThreshold * 1.25;
            };

        };
        _bodyPartDamage = (_bodyPartDamage / (0.01 max _damageThreshold)) min 1;
        switch (true) do {
            case (_bodyPartDamage isEqualTo 1): {
                _entries pushBack [localize ACELSTRING(medical_gui,traumaSustained4), [_bodyPartDamage] call ACEFUNC(medical_gui,damageToRGBA)];
            };
            case (_bodyPartDamage >= 0.75): {
                _entries pushBack [localize ACELSTRING(medical_gui,traumaSustained3), [_bodyPartDamage] call ACEFUNC(medical_gui,damageToRGBA)];
            };
            case (_bodyPartDamage >= 0.5): {
                _entries pushBack [localize ACELSTRING(medical_gui,traumaSustained2), [_bodyPartDamage] call ACEFUNC(medical_gui,damageToRGBA)];
            };
            case (_bodyPartDamage >= 0.25): {
                _entries pushBack [localize ACELSTRING(medical_gui,traumaSustained1), [_bodyPartDamage] call ACEFUNC(medical_gui,damageToRGBA)];
            };
        };
    };
};

// Indicate if a tourniquet is applied
if (HAS_TOURNIQUET_ACTUAL(_target,_selectionN)) then {
    if ((GET_KAT_TOURNIQUETS(_target) select _selectionN) >= 1) then {
        _entries pushBack [format ["%1 [%2]", localize ACELSTRING(medical_gui,Status_Tourniquet_Applied), _target getVariable [QEGVAR(circulation,tourniquetTime), [0,0,0,0,0,0,0,0,0,0,0,0]] select _selectionN], [0.77, 0.51, 0.08, 1]];
    } else {
        _entries pushBack [format ["[H] %1 [%2]", localize ACELSTRING(medical_gui,Status_Tourniquet_Applied), _target getVariable [QEGVAR(circulation,tourniquetTime), [0,0,0,0,0,0,0,0,0,0,0,0]] select _selectionN], [0.77, 0.51, 0.08, 1]];
    };
};
    

private _warmerPlaced = _target getVariable [QEGVAR(hypothermia,fluidWarmer), [0,0,0,0,0,0,0,0,0,0,0,0]];

if (_warmerPlaced select _selectionN == 1) then {
    _entries pushBack [LELSTRING(hypothermia,LineWarmer), [1, 0.75, 0.18, 1]];
};

// Indicate current body part fracture status
switch (GET_FRACTURES(_target) select _selectionN) do {
    case 1: {
        _entries pushBack [localize ACELSTRING(medical_gui,Status_Fractured), [1, 0, 0, 1]];
    };
    case -1: {
        if (ACEGVAR(medical,fractures) in [2, 3]) then { // Ignore if the splint has no effect
            _entries pushBack [localize ACELSTRING(medical_gui,Status_SplintApplied), [0.2, 0.2, 1, 1]];
        };
    };
    case -2: {
        if (ACEGVAR(medical,fractures) in [2, 3]) then { // Ignore if the splint has no effect
            _entries pushBack [localize LSTRING(Status_SplintWrapped), [0.2, 0.2, 1, 1]];
        };
    };
};

[QACEGVAR(medical_gui,updateInjuryListPart), [_ctrl, _target, _selectionN, _entries, _bodyPartName]] call CBA_fnc_localEvent;

// Add entries for open, bandaged, and stitched wounds
private _woundEntries = [];

private _fnc_processWounds = {
    params ["_wounds", "_format", "_color"];

    {
        _x params ["_woundClassID", "_amountOf"];

        if (_amountOf > 0) then {
            private _classIndex = _woundClassID / 10;
            private _category   = _woundClassID % 10;
            private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
            if (_className in ["InternalBleeding", "Evisceration"]) exitWith {};
            private _suffix = ["Minor", "Medium", "Large"] select _category;
            private _woundName = localize format [LSTRING(%1_%2), _className, _suffix];

            private _woundDescription = if (_amountOf >= 1) then {
                format ["%1x %2", ceil _amountOf, _woundName]
            } else {
                format [localize ACELSTRING(medical_gui,PartialX), _woundName]
            };

            _woundEntries pushBack [format [_format, _woundDescription], _color];
        };
    } forEach (_wounds getOrDefault [ALL_BODY_PARTS select _selectionN, []]);
};

private _fnc_processCoagWounds = {
    params ["_wounds", "_format", "_color"];

    private _aggregatedWounds = createHashMap;

    {
        _x params ["_woundClassID", "_amountOf"];

        if (_amountOf > 0) then {
            private _existing = _aggregatedWounds getOrDefault [_woundClassID, 0];
            _aggregatedWounds set [_woundClassID, _existing + _amountOf];
        };
    } forEach (_wounds getOrDefault [ALL_BODY_PARTS select _selectionN, []]);

    {
        private _woundClassID = _x;
        private _amountOf = _y;

        private _classIndex = _woundClassID / 10;
        private _category   = _woundClassID % 10;

        private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
        if (_className in ["InternalBleeding", "Evisceration"]) then { continue };

        private _suffix = ["Minor", "Medium", "Large"] select _category;
        private _woundName = localize format [LSTRING(%1_%2), _className, _suffix];

        private _woundDescription = if (_amountOf >= 1) then {
            format ["%1x %2", ceil _amountOf, _woundName]
        } else {
            format [localize ACELSTRING(medical_gui,PartialX), _woundName]
        };

        _woundEntries pushBack [format [_format, _woundDescription], _color];

    } forEach _aggregatedWounds;
};

[GET_OPEN_WOUNDS(_target), "%1", [1, 1, 1, 1]] call _fnc_processWounds;
[GET_COAGED_WOUNDS(_target), "[C] %1", [0.88, 0.7, 0.65, 1]] call _fnc_processCoagWounds;
[GET_WRAPPED_WOUNDS(_target), "[W] %1", [0.88, 0.7, 0.65, 1]] call _fnc_processWounds;
[GET_BANDAGED_WOUNDS(_target), "[B] %1", [0.88, 0.7, 0.65, 1]] call _fnc_processWounds;
[GET_STITCHED_WOUNDS(_target), "[S] %1", [0.7, 0.7, 0.7, 1]] call _fnc_processWounds;

[QACEGVAR(medical_gui,updateInjuryListWounds), [_ctrl, _target, _selectionN, _woundEntries, _bodyPartName]] call CBA_fnc_localEvent;

// Handle no wound entries
if (_woundEntries isEqualTo []) then {
    _entries pushBack [localize ACELSTRING(medical_treatment,NoInjuriesBodypart), _nonissueColor];
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
