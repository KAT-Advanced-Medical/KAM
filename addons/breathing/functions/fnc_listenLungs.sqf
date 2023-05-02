#include "script_component.hpp"
/*
 * Author: Battlekeeper, modified by YetheSamartaka, Tomcat and Blue
 * Handles listening to lungs.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_listenLungs;
 *
 * Public: No
 */

params ["_medic","_patient"];

if (GET_HEART_RATE(_patient) isEqualTo 0) exitWith {};

private _volume = GVAR(stethoscopeSoundVolume);

soundPlaying = false;
variantDelay = 0;
[{
    params ["_args", "_idPFH"];
    _args params ["_medic","_patient","_volume"];

    private _HR = GET_HEART_RATE(_patient);

    if !(_medic getVariable [QGVAR(usingStethoscope), false] || !(alive _patient) || _HR isEqualTo 0) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    
    //private _pneumo = _patient getVariable [QGVAR(pneumothorax), false];
    private _tension = (_patient getVariable [QGVAR(tensionpneumothorax), false] || _patient getVariable [QGVAR(pneumothorax), false]);
    private _hemo = _patient getVariable [QGVAR(hemopneumothorax), false];

    _breathDelay = 20/_HR;

    _random = round random 1;
    
    private _type = 3;

    if(_hemo && _random >= 0.5) then {_type = 1};
    if(_tension && _random >= 0.5) then {_type = 2};

    if(!(soundPlaying)) then {
        switch (_type) do {
            case 1: { // hemopneumothorax
                if (round random 1 >= 0.5) then {
                    playSoundUI [QPATHTOF(audio\hemo_inhale1.ogg), _volume, 1];
                    variantDelay = 1.65;
                } else {
                    playSoundUI [QPATHTOF(audio\hemo_inhale2.ogg), _volume, 1];
                    variantDelay = 1.7;
                };
                soundPlaying = true;
                [{
                    params ["_medic","_patient","_volume","_breathDelay"];

                    if (_medic getVariable [QGVAR(usingStethoscope), false] && (alive _patient)) then {
                        if (round random 1 >= 0.5) then {
                            playSoundUI [QPATHTOF(audio\hemo_exhale1.ogg), _volume, 1];
                            variantDelay = 0.85;
                        } else {
                            playSoundUI [QPATHTOF(audio\hemo_exhale2.ogg), _volume, 1];
                            variantDelay = 0.8;
                        }; 
                        [{
                            soundPlaying = false;
                        }, [], variantDelay + _breathDelay] call CBA_fnc_waitAndExecute;
                    } else {
                        soundPlaying = false;
                    };
                }, [_medic,_patient,_volume,_breathDelay], variantDelay + _breathDelay] call CBA_fnc_waitAndExecute;
            };
            case 2: { // tension/pneumothorax
                playSoundUI [QPATHTOF(audio\tension_inhale1.ogg), _volume, 1];
                variantDelay = 0.67;
                soundPlaying = true;
                [{
                    params ["_medic","_patient","_volume","_breathDelay"];

                    if (_medic getVariable [QGVAR(usingStethoscope), false] && (alive _patient)) then {
                        playSoundUI [QPATHTOF(audio\tension_exhale1.ogg), _volume, 1];
                        variantDelay = 0.3;
                        [{
                            soundPlaying = false;
                        }, [], variantDelay + _breathDelay] call CBA_fnc_waitAndExecute;
                    } else {
                        soundPlaying = false;
                    };
                }, [_medic,_patient,_volume,_breathDelay], variantDelay + _breathDelay] call CBA_fnc_waitAndExecute;
            };
            case 3;
            default { // clear
                if (round random 1 >= 0.5) then {
                    playSoundUI [QPATHTOF(audio\clear_inhale1.ogg), _volume, 1];
                    variantDelay = 1.46;
                } else {
                    playSoundUI [QPATHTOF(audio\clear_inhale2.ogg), _volume, 1];
                    variantDelay = 1;
                };
                soundPlaying = true;
                [{
                    params ["_medic","_patient","_volume","_breathDelay"];

                    if (_medic getVariable [QGVAR(usingStethoscope), false] && (alive _patient)) then {
                        if (round random 1 >= 0.5) then {
                            playSoundUI [QPATHTOF(audio\clear_exhale1.ogg), _volume, 1];
                            variantDelay = 1.25;
                        } else {
                            playSoundUI [QPATHTOF(audio\clear_exhale2.ogg), _volume, 1];
                            variantDelay = 1.26;
                        };
                        [{
                            soundPlaying = false;
                        }, [], variantDelay + _breathDelay] call CBA_fnc_waitAndExecute;
                    } else {
                        soundPlaying = false;
                    };
                }, [_medic,_patient,_volume,_breathDelay], variantDelay + _breathDelay] call CBA_fnc_waitAndExecute;
            };
        };
    };
}, 0, [_medic,_patient,_volume]] call CBA_fnc_addPerFrameHandler;