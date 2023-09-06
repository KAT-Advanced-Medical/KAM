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

params ["_ctrlGroup", "_target"];

// Get tourniquets, damage, and blood loss for target
private _tourniquets = GET_TOURNIQUETS(_target);
private _fractures = GET_FRACTURES(_target);
private _bodyPartDamage = _target getVariable [QACEGVAR(medical,bodyPartDamage), [0, 0, 0, 0, 0, 0]];
private _bodyPartBloodLoss = [0, 0, 0, 0, 0, 0];

{
    _x params ["", "_bodyPartN", "_amountOf", "_bleeding"];
    _bodyPartBloodLoss set [_bodyPartN, (_bodyPartBloodLoss select _bodyPartN) + (_bleeding * _amountOf)];
} forEach GET_OPEN_WOUNDS(_target);

{
    _x params ["_bodyPartIDC", ["_tourniquetIDC", -1], ["_fractureIDC", -1]];

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
    [IDC_BODY_TORSO,    -1, -1, -1],
    [IDC_BODY_ARMLEFT,  IDC_BODY_ARMLEFT_T,  IDC_BODY_ARMLEFT_B, -1],
    [IDC_BODY_ARMRIGHT, IDC_BODY_ARMRIGHT_T, IDC_BODY_ARMRIGHT_B, -1],
    [IDC_BODY_LEGLEFT,  IDC_BODY_LEGLEFT_T,  IDC_BODY_LEGLEFT_B, -1],
    [IDC_BODY_LEGRIGHT, IDC_BODY_LEGRIGHT_T, IDC_BODY_LEGRIGHT_B, -1]
];

// Airway
private _ctrlGuedelTube = _ctrlGroup controlsGroupCtrl IDC_BODY_HEAD_GUEDELTUBE;
private _ctrlKingLT = _ctrlGroup controlsGroupCtrl IDC_BODY_HEAD_KINGLT;

private _airwayItem = _target getVariable [QEGVAR(airway,airway_item), ""];

if !(_airwayItem isEqualTo "") then {
    if (_airwayItem isEqualTo "Larynxtubus") then {
        _ctrlGuedelTube ctrlShow false;
        _ctrlKingLT ctrlShow true;
    } else {
        _ctrlGuedelTube ctrlShow true;
        _ctrlKingLT ctrlShow false;
    };
} else {
    _ctrlGuedelTube ctrlShow false;
    _ctrlKingLT ctrlShow false;
};

// Breathing
private _ctrlPulseOximeterRight = _ctrlGroup controlsGroupCtrl IDC_BODY_RIGHTARM_PULSEOX;
private _ctrlPulseOximeterLeft = _ctrlGroup controlsGroupCtrl IDC_BODY_LEFARM_PULSEOX;
private _ctrlChestSeal = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_CHESTSEAL;
private _ctrlChestInjury = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_PNEUMOTHORAX;

if (_target getVariable [QEGVAR(breathing,activeChestSeal), false]) then {
    _ctrlChestSeal ctrlShow true;
} else {
    _ctrlChestSeal ctrlShow false;
};

if (EGVAR(breathing,PneumothoraxAlwaysVisible)) then {
    if(_target getVariable [QEGVAR(breathing,pneumothorax), 0] > 0) then {
        _ctrlChestInjury ctrlShow true;
    } else {
        _ctrlChestInjury ctrlShow false;
    };
} else {
    if (_target getVariable [QEGVAR(breathing,deepPenetratingInjury), false] || (_target getVariable [QEGVAR(breathing,pneumothorax), 0] > 0)) then {
        _ctrlChestInjury ctrlShow true;
    } else {
        _ctrlChestInjury ctrlShow false;
    };
};

if (_target getVariable [QEGVAR(breathing,pulseoximeter), false]) then {
    if ((_target getVariable [QEGVAR(breathing,PulseOximeter_Attached), [0,0]] select 0) > 0) then {
        _ctrlPulseOximeterLeft ctrlShow true;
    } else {
        _ctrlPulseOximeterLeft ctrlShow false;
    };
    if ((_target getVariable [QEGVAR(breathing,PulseOximeter_Attached), [0,0]] select 1) > 0) then {
        _ctrlPulseOximeterRight ctrlShow true;
    } else {
        _ctrlPulseOximeterRight ctrlShow false;
    };
} else {
    _ctrlPulseOximeterLeft ctrlShow false;
    _ctrlPulseOximeterRight ctrlShow false;
};

// Chemical
private _ctrlAirInfected = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_I;
if (_target getVariable [QEGVAR(chemical,airPoisoning), false]) then {
    _ctrlAirInfected ctrlShow true;
} else {
    _ctrlAirInfected ctrlShow false;
};

// Circulation
private _ctrlAEDPads = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_AED_PADS;
private _ctrlAEDVitalsMonitorRight = _ctrlGroup controlsGroupCtrl IDC_BODY_RIGHTARM_AED_VITALS;
private _ctrlAEDVitalsMonitorLeft = _ctrlGroup controlsGroupCtrl IDC_BODY_LEFTARM_AED_VITALS;

if (_target getVariable [QEGVAR(circulation,DefibrillatorPads_Connected), false]) then {
    _ctrlAEDPads ctrlShow true;
} else {
    _ctrlAEDPads ctrlShow false;
};

if (_target getVariable [QEGVAR(circulation,AED_X_VitalsMonitor_Connected), false]) then {
    if (((_target getVariable [QEGVAR(circulation,AED_X_VitalsMonitor_Provider), [objNull, -1, 3]]) select 2) isEqualTo 3) then {
        _ctrlAEDVitalsMonitorRight ctrlShow true;
        _ctrlAEDVitalsMonitorLeft ctrlShow false;
    } else {
        _ctrlAEDVitalsMonitorRight ctrlShow false;
        _ctrlAEDVitalsMonitorLeft ctrlShow true;
    };
} else {
    _ctrlAEDVitalsMonitorRight ctrlShow false;
    _ctrlAEDVitalsMonitorLeft ctrlShow false;
};

// Pharmacy
private _ctrlIVLeftArm = _ctrlGroup controlsGroupCtrl IDC_BODY_LEFTARM_IV;
private _ctrlIVRightArm = _ctrlGroup controlsGroupCtrl IDC_BODY_RIGHTARM_IV;
private _ctrlIVLeftLeg = _ctrlGroup controlsGroupCtrl IDC_BODY_LEFTLEG_IV;
private _ctrlIVRightLeg = _ctrlGroup controlsGroupCtrl IDC_BODY_RIGHTLEG_IV;
private _ctrlIO = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_IO;

private _IVArray = _target getVariable [QEGVAR(pharma,IV), [0,0,0,0,0,0]];

{
    switch (_IVArray select (_forEachIndex + 2)) do {
        case 0: {
            _x ctrlShow false;
        };
        default {
            _x ctrlShow true;
        };
    };
} forEach [_ctrlIVLeftArm, _ctrlIVRightArm, _ctrlIVLeftLeg, _ctrlIVRightLeg];

if ((_IVArray select 1) isEqualTo 1) then {
    _ctrlIO ctrlShow true;
} else {
    _ctrlIO ctrlShow false;
};