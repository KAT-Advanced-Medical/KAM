#include "..\script_component.hpp"
/*
 * Author: Battlekeeper, modified by YetheSamartaka, Tomcat and Blue
 * Handles listening to lungs.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Side <Number>
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, 1] call kat_breathing_fnc_listenLungs;
 *
 * Public: No
 */

params ["_medic","_patient"];

private _volume = GVAR(stethoscopeSoundVolume);

soundPlaying = false;
variantDelay = 0;
[{
    params ["_args", "_idPFH"];
    _args params ["_medic","_patient","_volume"];

    private _hr = GET_HEART_RATE(_patient);
    if (!(_medic getVariable [QGVAR(usingStethoscope), false]) || !(alive _patient) || _hr isEqualTo 0 || (_patient getVariable [QACEGVAR(medical,inCardiacArrest), false])) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    private _tamponade = (_patient getVariable [QEGVAR(circulation,effusion), 0]);

    _heartDelay = _hr/180;

    if(!(soundPlaying)) then {
        switch (_tamponade) do {
            case 1: {
                playSoundUI [QPATHTOF(audio\slow_2.wav), _volume, 1];
                variantDelay = 1;
                soundPlaying = true;
                [{
                    params ["_medic","_patient"];
                    soundPlaying = false;
                }, [_medic,_patient], variantDelay + _heartDelay] call CBA_fnc_waitAndExecute;
            };
            case 2: {
                playSoundUI [QPATHTOF(audio\slow_2.wav), (_volume * 0.75), 1];
                variantDelay = 1;
                soundPlaying = true;
                [{
                    params ["_medic","_patient"];
                    soundPlaying = false;
                }, [_medic,_patient], variantDelay + _heartDelay] call CBA_fnc_waitAndExecute;
            };
            case 3: {
                playSoundUI [QPATHTOF(audio\slow_2.wav), (_volume * 0.5), 1];
                variantDelay = 1;
                soundPlaying = true;
                [{
                    params ["_medic","_patient"];
                    soundPlaying = false;
                }, [_medic,_patient], variantDelay + _heartDelay] call CBA_fnc_waitAndExecute;
            };
            case 4: {
                playSoundUI [QPATHTOF(audio\slow_2.wav), (_volume * 0.25), 1];
                variantDelay = 1;
                soundPlaying = true;
                [{
                    params ["_medic","_patient"];
                    soundPlaying = false;
                }, [_medic,_patient], variantDelay + _heartDelay] call CBA_fnc_waitAndExecute;
            };
            default {
                playSoundUI [QPATHTOF(audio\norm_2.wav), _volume, 1];
                variantDelay = 1;
                soundPlaying = true;
                [{
                    params ["_medic","_patient"];
                    soundPlaying = false;
                }, [_medic,_patient], variantDelay + _heartDelay] call CBA_fnc_waitAndExecute;
            };
        };
    };
}, 0, [_medic,_patient,_volume]] call CBA_fnc_addPerFrameHandler;
