#include "..\script_component.hpp"
/*
 * Author: Blue
 * Charge up Defibrillator in manual mode
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_circulation_fnc_Defibrillator_ManualCharge;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _soundSource = _medic;

private _defibProvider = _patient getVariable QGVAR(Defibrillator_Provider);

switch (_defibProvider select 1) do {
    case 1: {_soundSource = _defibProvider select 0;};
    case 2: {_soundSource = _patient;};
    default {};
};

_patient setVariable [QGVAR(DefibrillatorInUse), true, true];

playsound3D [QPATHTOF_SOUND(sounds\charging.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
[{ // Charged
    params ["_medic", "_patient", "_soundSource"];

    _patient setVariable [QGVAR(Defibrillator_Charged), true, true];

    [{
        params ["_medic", "_patient", "_soundSource"];

        !(_patient getVariable [QGVAR(Defibrillator_Charged), false])
    },
    {
        params ["_medic", "_patient", "_soundSource"];

        if (_patient getVariable [QGVAR(DefibrillatorInUse), false]) then { // Shock administered
            [_medic, _patient, "AEDX"] call FUNC(AED_Shock);
            playsound3D [QPATHTOF_SOUND(sounds\bump.wav), _patient, false, getPosASL _patient, 6, 1, 15];
        } else { // Defibrillator disarmed
            playsound3D [QPATHTOF_SOUND(sounds\3beep.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
        };
    },
    [_medic, _patient, _soundSource],
    20, // Defibrillator auto disarm time
    {
        params ["_medic", "_patient", "_soundSource"];

        _patient setVariable [QGVAR(Defibrillator_Charged), false, true];
        [{ // Defibrillator disarmed
            params ["_soundSource", "_patient"];

            playsound3D [QPATHTOF_SOUND(sounds\3beep.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
            _patient setVariable [QGVAR(DefibrillatorInUse), false, true];
        }, [_soundSource, _patient], 0.5] call CBA_fnc_waitAndExecute;
    }] call CBA_fnc_waitUntilAndExecute;

    [{ // Ready to shock, play alarm
        params ["_args", "_idPFH"];
        _args params ["_medic", "_patient", "_soundSource"];

        if (!(_patient getVariable [QGVAR(Defibrillator_Charged), false])) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        playsound3D [QPATHTOF_SOUND(sounds\alarm.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];

    }, 0.528, [_medic, _patient, _soundSource]] call CBA_fnc_addPerFrameHandler;
}, [_medic, _patient, _soundSource], 4.1] call CBA_fnc_waitAndExecute;
