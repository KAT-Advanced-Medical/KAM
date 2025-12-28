#include "..\script_component.hpp"
/*
 * Author: Glowbal, kymckay, mharis001
 * Updates the body image for given target.
 *
 * Arguments:
 * 0: Body image controls group <CONTROL>
 * 1: Target <OBJECT>
 * 2: Body part <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, _target, 0] call ace_medical_gui_fnc_updateBodyImage
 *
 * Public: No
 */

params ["_ctrlGroup", "_target", "_selectionN"];
TRACE_3("Params",_ctrlGroup,_target,_selectionN);

// Get tourniquets, damage, and blood loss for target
private _tourniquets = GET_TOURNIQUETS(_target);
private _fractures = GET_FRACTURES(_target);
private _bodyPartDamage = GET_BODYPART_DAMAGE(_target);
private _damageThreshold = GET_DAMAGE_THRESHOLD(_target);
private _bodyPartBloodLoss = [0,0,0,0,0,0,0,0,0,0,0,0];
private _surgicalBlock = GET_SURGICAL_TOURNIQUETS(_target);

TRACE_5("Medical state",
    _tourniquets,
    _fractures,
    _bodyPartDamage,
    _damageThreshold,
    _surgicalBlock
);

// Calculate blood loss per body part
{
    private _partIndex = ALL_BODY_PARTS find _x;
    TRACE_2("Open wounds body part",_x,_partIndex);

    {
        _x params ["_woundClassID", "_amountOf", "_bleeding"];
        private _classIndex = _woundClassID / 10;
        private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;

        TRACE_4("Wound",
            _woundClassID,
            _className,
            _amountOf,
            _bleeding
        );

        if !(_className in ["InternalBleeding"]) then {
            _bodyPartBloodLoss set [
                _partIndex,
                (_bodyPartBloodLoss select _partIndex) + (_bleeding * _amountOf)
            ];
        };
    } forEach _y;
} forEach GET_OPEN_WOUNDS(_target);

TRACE_1("Body part blood loss",_bodyPartBloodLoss);

// UI update loop
{
    _x params ["_bodyPartIDC", "_selectedIDC", ["_tourniquetIDC", -1], ["_fractureIDC", -1]];
    private _selected = _forEachIndex == _selectionN;

    TRACE_4("UI element",
        _forEachIndex,
        _bodyPartIDC,
        _selected,
        _tourniquetIDC
    );

    private _ctrlSelected = _ctrlGroup controlsGroupCtrl _selectedIDC;
    _ctrlSelected ctrlSetTextColor ACEGVAR(medical_gui,bodypartOutlineColor);
    _ctrlSelected ctrlShow _selected;
    TRACE_4("UI element",
        _ctrlSelected,
        _selectedIDC,
        _selected,
        _tourniquetIDC
    );
    // Tourniquet icon
    if (_tourniquetIDC != -1) then {
        private _hasTourniquet =
            (_tourniquets select _forEachIndex > 0)
            && (_surgicalBlock select _forEachIndex == 0);

        TRACE_2("Tourniquet",_forEachIndex,_hasTourniquet);

        private _ctrlTourniquet = _ctrlGroup controlsGroupCtrl _tourniquetIDC;
        _ctrlTourniquet ctrlShow _hasTourniquet;
    };

    // Fracture / bone state
    if (_fractureIDC != -1) then {
        private _fractureState = _fractures select _forEachIndex;
        TRACE_2("Fracture state",_forEachIndex,_fractureState);

        private _ctrlBone = _ctrlGroup controlsGroupCtrl _fractureIDC;

        switch (_fractureState) do {
            case 0: {
                _ctrlBone ctrlShow false;
            };
            case 1: {
                _ctrlBone ctrlShow true;
                _ctrlBone ctrlSetTextColor [1, 0, 0, 1];
            };
            case -1;
            case -2: {
                if (ACEGVAR(medical,fractures) in [2, 3]) then {
                    _ctrlBone ctrlShow true;
                    _ctrlBone ctrlSetTextColor [0, 0, 1, 1];
                } else {
                    _ctrlBone ctrlShow false;
                };
            };
            case -3: {
                if (ACEGVAR(medical,fractures) in [2, 3]) then {
                    _ctrlBone ctrlShow true;
                    _ctrlBone ctrlSetTextColor [1, 0, 1, 1];
                } else {
                    _ctrlBone ctrlShow false;
                };
            };
        };
    };

    // Body part coloring
    private _bloodLoss = _bodyPartBloodLoss select _forEachIndex;
    private _bodyPartColor = if (_bloodLoss > 0) then {

        TRACE_2("Blood loss color",_forEachIndex,_bloodLoss);
        [_bloodLoss] call ACEFUNC(medical_gui,bloodLossToRGBA);

    } else {

        private _damage = _bodyPartDamage select _forEachIndex;

        TRACE_3("Damage pre-scale",_forEachIndex,_damage,_damageThreshold);

        switch (true) do {
            case (_forEachIndex > 7): {
                if (
                    ACEGVAR(medical,limbDamageThreshold) != 0
                    && {[false, !isPlayer _target, true] select ACEGVAR(medical,useLimbDamage)}
                ) then {
                    _damageThreshold = _damageThreshold * ACEGVAR(medical,limbDamageThreshold);
                } else {
                    _damageThreshold = LIMPING_DAMAGE_THRESHOLD * 4;
                };
            };

            case (_forEachIndex > 3): {
                if (
                    ACEGVAR(medical,limbDamageThreshold) != 0
                    && {[false, !isPlayer _target, true] select ACEGVAR(medical,useLimbDamage)}
                ) then {
                    _damageThreshold = _damageThreshold * ACEGVAR(medical,limbDamageThreshold);
                } else {
                    _damageThreshold = FRACTURE_DAMAGE_THRESHOLD * 4;
                };
            };

            case (_forEachIndex > 1): {
                _damageThreshold = _damageThreshold * 1.5;
            };

            default {
                _damageThreshold = _damageThreshold * 1.5;
            };
        };

        _damage = (_damage / (0.01 max _damageThreshold)) min 1;

        TRACE_3("Damage post-scale",_forEachIndex,_damage,_damageThreshold);
        [_damage] call ACEFUNC(medical_gui,damageToRGBA);
    };

    private _ctrlBodyPart = _ctrlGroup controlsGroupCtrl _bodyPartIDC;
    TRACE_3("bodyParts",_ctrlGroup,_ctrlBodyPart,_bodyPartIDC);
    _ctrlBodyPart ctrlSetTextColor _bodyPartColor;

} forEach [
    [IDC_BODY_HEAD, IDC_BODY_HEAD_S],
    [IDC_BODY_NECK, IDC_BODY_NECK_S],
    [IDC_BODY_CHEST, IDC_BODY_CHEST_S],
    [IDC_BODY_TORSO, IDC_BODY_TORSO_S],
    [IDC_BODY_ARMLEFT, IDC_BODY_ARMLEFT_S, IDC_BODY_ARMLEFT_T, IDC_BODY_ARMLEFT_B],
    [IDC_BODY_ARMUPPERLEFT, IDC_BODY_ARMUPPERLEFT_S, IDC_BODY_ARMUPPERLEFT_T, IDC_BODY_ARMUPPERLEFT_B],
    [IDC_BODY_ARMRIGHT, IDC_BODY_ARMRIGHT_S, IDC_BODY_ARMRIGHT_T, IDC_BODY_ARMRIGHT_B],
    [IDC_BODY_ARMUPPERRIGHT, IDC_BODY_ARMUPPERRIGHT_S, IDC_BODY_ARMUPPERRIGHT_T, IDC_BODY_ARMUPPERRIGHT_B],
    [IDC_BODY_LEGLEFT, IDC_BODY_LEGLEFT_S, IDC_BODY_LEGLEFT_T, IDC_BODY_LEGLEFT_B],
    [IDC_BODY_LEGUPPERLEFT, IDC_BODY_LEGUPPERLEFT_S, IDC_BODY_LEGUPPERLEFT_T, IDC_BODY_LEGUPPERLEFT_B],
    [IDC_BODY_LEGRIGHT, IDC_BODY_LEGRIGHT_S, IDC_BODY_LEGRIGHT_T, IDC_BODY_LEGRIGHT_B],
    [IDC_BODY_LEGUPPERRIGHT, IDC_BODY_LEGUPPERRIGHT_S, IDC_BODY_LEGUPPERRIGHT_T, IDC_BODY_LEGUPPERRIGHT_B]
];

[QACEGVAR(medical_gui,updateBodyImage), [_ctrlGroup, _target, _selectionN]] call CBA_fnc_localEvent;
