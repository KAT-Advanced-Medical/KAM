#include "script_component.hpp"
/*
 * Author: Belbo, edited by Katalam (new syntax and different sound) and YetheSamartaka(PowerUp sound on/off setting), Blue
 * Handles the progress of the CPR treatment.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Sound source <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, player] call kat_circulation_fnc_AED_Sound
 *
 * Public: No
*/

params ["_medic", "_patient", "_soundSource"];

playsound3D [QPATHTOF_SOUND(sounds\standclear.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15]; // 1.2 seconds
[{
    params ["_soundSource", "_patient"];

    if !(_patient getVariable [QGVAR(AEDinUse), false] ) exitWith {_patient setVariable [QGVAR(AEDSoundPlaying), false, true];};
    playsound3D [QPATHTOF_SOUND(sounds\powerup.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15]; // 5.229 seconds
    [{
        params ["_soundSource", "_patient"];

        if !(_patient getVariable [QGVAR(AEDinUse), false]) exitWith {_patient setVariable [QGVAR(AEDSoundPlaying), false, true];};
        playsound3D [QPATHTOF_SOUND(sounds\powerupdone.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15]; // 2.242 seconds
        [{
            params ["_soundSource", "_patient"];

            if !(_patient getVariable [QGVAR(AEDinUse), false]) exitWith {_patient setVariable [QGVAR(AEDSoundPlaying), false, true];};
            playsound3D [QPATHTOF_SOUND(sounds\bump.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15]; // 0.8 seconds
            [{
                params ["_soundSource", "_patient"];

                playsound3D [QPATHTOF_SOUND(sounds\checkpulse.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15]; // 1.1 seconds
                [{
                    params ["_soundSource", "_patient"];

                    _patient setVariable [QGVAR(AEDSoundPlaying), false, true];
                }, [_soundSource, _patient], 0.5] call CBA_fnc_waitAndExecute;
            }, [_soundSource, _patient], 1] call CBA_fnc_waitAndExecute;
        }, [_soundSource, _patient], 2.2] call CBA_fnc_waitAndExecute;
    }, [_soundSource, _patient], 5.35] call CBA_fnc_waitAndExecute;
}, [_soundSource, _patient], 1.5] call CBA_fnc_waitAndExecute;