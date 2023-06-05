#include "script_component.hpp"
/*
 * Author: Glowbal, SilentSpike, mharis001
 * Updates the body image for given target.
 *
 * Arguments:
 * 0: Body image controls group <CONTROL>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, _target] call ace_medical_gui_fnc_updateBodyImage
 *
 * Public: No
 */

[] spawn {
    disableSerialization;
    private _display = uiNamespace getVariable ["ace_medical_gui_menuDisplay", displayNull];
    private _ctrlBodyImage = _display displayCtrl IDC_BODY_GROUP;
    private _torso_infected = _display ctrlCreate ["RscPicture", 6011,_ctrlBodyImage];
    _torso_infected ctrlShow false;
    _torso_infected ctrlSetText QPATHTOF(data\body_image\torso_i.paa);
    _torso_infected ctrlSetPosition[0,0,POS_W(12.33),POS_H(12.33)];
    _torso_infected ctrlCommit 0;
};

params ["_ctrlGroup", "_target"];

// Get tourniquets, damage, and blood loss for target
private _tourniquets = GET_TOURNIQUETS(_target);
private _fractures = GET_FRACTURES(_target);
private _infectedtype = _target getVariable [QGVAR(poisonType),""];
private _bodyPartDamage = _target getVariable [QACEGVAR(medical,bodyPartDamage), [0, 0, 0, 0, 0, 0]];
private _bodyPartBloodLoss = [0, 0, 0, 0, 0, 0];

{
    _x params ["", "_bodyPartN", "_amountOf", "_bleeding"];
    _bodyPartBloodLoss set [_bodyPartN, (_bodyPartBloodLoss select _bodyPartN) + (_bleeding * _amountOf)];
} forEach GET_OPEN_WOUNDS(_target);

{
    _x params ["_bodyPartIDC", ["_tourniquetIDC", -1], ["_fractureIDC", -1], ["_infectedIDC", -1]];

    if (_infectedIDC != -1) then {
        private _ctrlairInfected = _ctrlGroup controlsGroupCtrl _infectedIDC;
        if(_target getVariable [QGVAR(airPoisoning),false]) then{
            _ctrlairInfected ctrlShow true;
        } else {
            _ctrlairInfected ctrlShow false;
        };
    };

    // Show or hide the tourniquet icon
    if (_tourniquetIDC != -1) then {
        private _hasTourniquet = _tourniquets select _forEachIndex > 0;
        private _ctrlTourniquet = _ctrlGroup controlsGroupCtrl _tourniquetIDC;
        _ctrlTourniquet ctrlShow _hasTourniquet;
    };

    // Show or hide fractrue/bones
    if (_fractureIDC != -1) then {
        private _ctrlBone = _ctrlGroup controlsGroupCtrl _fractureIDC;
        switch (_fractures select _forEachIndex) do {
            case 0: {
                _ctrlBone ctrlShow false;
            };
            case 1: {
                _ctrlBone ctrlShow true;
                _ctrlBone ctrlSetTextColor [1, 0, 0, 1];
            };
            case -1: {
                if (ace_medical_fractures in [2, 3]) then {
                    _ctrlBone ctrlShow true;
                    _ctrlBone ctrlSetTextColor [0, 0, 1, 1];
                } else {
                    _ctrlBone ctrlShow false;
                };
            };
        };
    };

    // Update body part color based on blood loss and damage
    private _bloodLoss = _bodyPartBloodLoss select _forEachIndex;
    private _bodyPartColor = if (_bloodLoss > 0) then {
        [_bloodLoss] call ACEFUNC(medical_gui,bloodLossToRGBA);
    } else {
        private _damage = _bodyPartDamage select _forEachIndex;
        [_damage] call ACEFUNC(medical_gui,damageToRGBA);
    };

    private _ctrlBodyPart = _ctrlGroup controlsGroupCtrl _bodyPartIDC;
    _ctrlBodyPart ctrlSetTextColor _bodyPartColor;
} forEach [
    [IDC_BODY_HEAD,     -1, -1, -1],
    [IDC_BODY_TORSO,    -1, -1, IDC_BODY_TORSO_I],
    [IDC_BODY_ARMLEFT,  IDC_BODY_ARMLEFT_T,  IDC_BODY_ARMLEFT_B, -1],
    [IDC_BODY_ARMRIGHT, IDC_BODY_ARMRIGHT_T, IDC_BODY_ARMRIGHT_B, -1],
    [IDC_BODY_LEGLEFT,  IDC_BODY_LEGLEFT_T,  IDC_BODY_LEGLEFT_B, -1],
    [IDC_BODY_LEGRIGHT, IDC_BODY_LEGRIGHT_T, IDC_BODY_LEGRIGHT_B, -1]
];
