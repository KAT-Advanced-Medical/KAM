#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut
 * Handles any visual effects of medical.
 * Note: Heart beat sounds run in a different PFH - see fnc_effectHeartBeat.
 *
 * Arguments:
 * 0: Manual, instant update <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_medical_feedback_fnc_handleEffects
 *
 * Public: No
 */
params [["_manualUpdate", false]];

if (ACEGVAR(common,OldIsCamera) || {!alive ACE_player}) exitWith {
    [false, 0] call ACEFUNC(medical_feedback,effectUnconscious);
    [false]    call ACEFUNC(medical_feedback,effectPain);
    [false]    call ACEFUNC(medical_feedback,effectBloodVolume);
    [false]    call ACEFUNC(medical_feedback,effectBloodVolumeIcon);
    [false]    call ACEFUNC(medical_feedback,effectBleeding);
};

BEGIN_COUNTER(handleEffects);

// - Current state info -------------------------------------------------------
private _bleedingStrength = GET_BLOOD_LOSS(ACE_player);
private _bloodVolume      = GET_BLOOD_VOLUME_LITERS(ACE_player);
private _unconscious      = IS_UNCONSCIOUS(ACE_player);
private _heartRate        = GET_HEART_RATE(ACE_player);
private _pain             = GET_PAIN_PERCEIVED(ACE_player);
private _wounds = GET_OPEN_WOUNDS(ACE_player);
private _bleedRates = ACE_player getVariable [VAR_BODY_BLEED_RATE, [0,0,0,0,0,0,0,0,0,0,0,0]];
private _hasExternalBleeding = (selectMax _bleedRates) > 0;
// Indicate if unit is bleeding at all
if (_hasExternalBleeding) then {
    _bleedingStrength = _bleedingStrength;
} else {
    _bleedingStrength = 0;
};

if ((!ACEGVAR(medical_feedback,heartBeatEffectRunning)) && {_heartRate != 0} && {(_heartRate > 160) || {_heartRate < 60}}) then {
    TRACE_1("Starting heart beat effect",_heartRate);
    ACEGVAR(medical_feedback,heartBeatEffectRunning) = true;
    [] call ACEFUNC(medical_feedback,effectHeartBeat);
};

// - Visual effects -----------------------------------------------------------
[_unconscious, 2] call ACEFUNC(medical_feedback,effectUnconscious);
[
    true,
    linearConversion [BLOOD_VOLUME_CLASS_2_HEMORRHAGE, BLOOD_VOLUME_CLASS_4_HEMORRHAGE, _bloodVolume, 0, 1, true]
] call ACEFUNC(medical_feedback,effectBloodVolume);
[
    true,
    ceil linearConversion [
        BLOOD_VOLUME_CLASS_2_HEMORRHAGE, BLOOD_VOLUME_CLASS_4_HEMORRHAGE,
        _bloodVolume,
        0, 6, true
    ]
] call ACEFUNC(medical_feedback,effectBloodVolumeIcon);

[!_unconscious, _pain] call ACEFUNC(medical_feedback,effectPain);
[!_unconscious, _bleedingStrength, _manualUpdate] call ACEFUNC(medical_feedback,effectBleeding);

// - Tourniquets, fractures and splints indication ---------------------------------------
if (ACEGVAR(medical_feedback,enableHUDIndicators)) then {
    [] call ACEFUNC(medical_feedback,handleHUDIndicators);
};

END_COUNTER(handleEffects);