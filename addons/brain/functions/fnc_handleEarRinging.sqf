#include "..\script_component.hpp"
/*
 * Author: apo_tle, MiszczuZPolski
 * 
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_feedback_fnc_handleEarRinging;
 *
 * Public: No
 */

if (isGamePaused) exitWith {};

if (!alive ACE_player) exitWith {
    TRACE_1("dead - removing hearing effects",ACE_player);
};
private _concussion = ACE_player getVariable [QEGVAR(brain,concussion), 0];
if (_concussion > 0) then {
    if (CBA_missionTime - ACEGVAR(hearing,time3) < 3) exitWith {};
    if (!isGameFocused) exitWith {}; // prevent audio from stacking when tabbed out
    private _effectsVolume = getAudioOptionVolumes#0 * _concussion;
    _concussion = ACE_player getVariable [QEGVAR(brain,concussion), 0];
    switch (true) do {
        case (_concussion > 0.5): {
            playSoundUI [["ACE_Combat_Deafness_Heavy", "ACE_Combat_Deafness_Heavy_NoRing"] select ACEGVAR(hearing,disableEarRinging), _effectsVolume];
        };
        default {
            playSoundUI [["ACE_Combat_Deafness_Medium", "ACE_Combat_Deafness_Medium_NoRing"] select ACEGVAR(hearing,disableEarRinging), _effectsVolume];
        };
    };
};

