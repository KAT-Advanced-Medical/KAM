#include "..\script_component.hpp"
/*
 * Author: Blue
 * Charge up Defibrillator in AED mode
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Sound source <OBJECT>
 * 3: Defibrillator type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, player] call kat_circulation_fnc_AED_Charge;
 *
 * Public: No
 */

params ["_medic", "_patient", "_soundSource", "_defibType"];

playsound3D [QPATHTOF_SOUND(sounds\charging.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
[{ // Charged
    params ["_medic", "_patient", "_soundSource", "_defibType"];

    playsound3D [QPATHTOF_SOUND(sounds\standclear_pushtoshock.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
    [{ // Ready to shock
        params ["_medic", "_patient", "_soundSource", "_defibType"];

        _patient setVariable [QGVAR(Defibrillator_Charged), true, true];

        [{
            params ["_medic", "_patient", "_soundSource"];

            !(_patient getVariable [QGVAR(Defibrillator_Charged), false])
        },
        {
            params ["_medic", "_patient", "_soundSource", "_defibType"];

            if (_patient getVariable [QGVAR(DefibrillatorInUse), false]) then { // Shock administered
                [_medic, _patient, _defibType] call FUNC(AED_Shock);
                playsound3D [QPATHTOF_SOUND(sounds\bump.wav), _patient, false, getPosASL _patient, 6, 1, 15];

                [{ // Prompt to analyze again
                    params ["_soundSource"];

                    if (_patient getVariable [QGVAR(DefibrillatorInUse), false] || _patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) exitWith {};
                    playsound3D [QPATHTOF_SOUND(sounds\pushanalyze.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
                }, [_soundSource], 2] call CBA_fnc_waitAndExecute;
            } else { // Defibrillator disarmed
                playsound3D [QPATHTOF_SOUND(sounds\3beep.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
            };
        },
        [_medic, _patient, _soundSource, _defibType],
        20, // Defibrillator auto disarm time
        {
            params ["_medic", "_patient", "_soundSource"];

            _patient setVariable [QGVAR(Defibrillator_Charged), false, true];
            [{ // Defibrillator disarmed
                params ["_patient", "_soundSource"];

                playsound3D [QPATHTOF_SOUND(sounds\3beep.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
                _patient setVariable [QGVAR(DefibrillatorInUse), false, true];
            }, [_patient, _soundSource], 0.5] call CBA_fnc_waitAndExecute;
        }] call CBA_fnc_waitUntilAndExecute;

        [{ // Ready to shock, play alarm
            params ["_args", "_idPFH"];
            _args params ["_medic", "_patient", "_soundSource"];

            if (!(_patient getVariable [QGVAR(Defibrillator_Charged), false])) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            playsound3D [QPATHTOF_SOUND(sounds\alarm.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];

        }, 0.528, [_medic, _patient, _soundSource]] call CBA_fnc_addPerFrameHandler;
    }, [_medic, _patient, _soundSource, _defibType], 1.3] call CBA_fnc_waitAndExecute;
}, [_medic, _patient, _soundSource, _defibType], 4.1] call CBA_fnc_waitAndExecute;
