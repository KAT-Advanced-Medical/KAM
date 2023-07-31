#include "script_component.hpp"
/*
 * Author: Katalam, modified by YetheSamartaka, Blue
 * Handle the AED-X vitals for the patient.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 * 2: AED-X origin <INT>
 *    0: Medic
 *    1: Placed
 *    2: Vehicle
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, 0] call kat_circulation_fnc_attachAEDX;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_AEDOrigin",0]];

private _soundSource = _medic;
private _AEDProvider = _medic;

if (_patient getVariable ["kat_AEDXPatient_PFH", false]) exitWith {};
_patient setVariable ["kat_AEDXPatient_PFH", true];

// if there is already a connected x-series exitWith a hint
if (_patient getVariable [QGVAR(X), false]) exitWith {
    private _output = LLSTRING(X_already);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

// connect the x-series
_patient setVariable [QGVAR(X), true, true];

switch (_AEDOrigin) do {
    case 1: {
        private _nearObjects = nearestObjects [position _patient, ["kat_AEDItem"], GVAR(distanceLimit_AEDX)];

        private _placedAED = _nearObjects select (_nearObjects findIf {typeOf _x isEqualTo "kat_X_AEDItem"});

        _patient setVariable [QGVAR(AED_X_VolumePatient), _placedAED getVariable QGVAR(AED_X_Volume), true];
        _patient setVariable [QGVAR(AED_X_Provider), _placedAED, true];
        _placedAED setVariable [QGVAR(AED_X_Connected), true, true];
        _placedAED setVariable [QGVAR(AED_X_Patient), _patient, true];
        _soundSource = _placedAED;
        _AEDProvider = _placedAED;
    };
    case 2: {
        _patient setVariable [QGVAR(AED_X_VolumePatient), _medic getVariable QGVAR(AED_X_Volume), true];
        _patient setVariable [QGVAR(AED_X_Provider), vehicle _patient, true];
        _soundSource = _patient;
        _AEDProvider = vehicle _patient;
    };
    default {
        _patient setVariable [QGVAR(AED_X_VolumePatient), _medic getVariable QGVAR(AED_X_Volume), true];
        _medic setVariable [QGVAR(AED_X_Connected), true, true];
    };
};

private _bloodLoss = _patient getVariable [QACEGVAR(medical,bloodVolume), 6.0];
private _asystole = _patient getVariable [QGVAR(asystole), 1];

if !(GVAR(AdvRhythm)) then {
    _patient setVariable [QGVAR(asystole), 1, true];
    _asystole = _patient getVariable [QGVAR(asystole), 1];
    } else {
    if (_bloodLoss > 3.6) then {
        _patient setVariable [QGVAR(asystole), 1, true];
        _asystole = _patient getVariable [QGVAR(asystole), 1];
    } else {
        _patient setVariable [QGVAR(asystole), 2, true];
        _asystole = _patient getVariable [QGVAR(asystole), 2];
    };
};

// analyse sound feedback
playsound3D [QPATHTOF_SOUND(sounds\analyse.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];

// wait for the analyse and give the advice
if ((_patient getVariable [QACEGVAR(medical,heartRate), 0] isEqualTo 0) && {_patient getVariable [QGVAR(asystole), 1] < 2}) then {
    [{
        params ["_soundSource"];
        playsound3D [QPATHTOF_SOUND(sounds\shock.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
    }, [_soundSource], 2] call CBA_fnc_waitAndExecute;
} else {
    [{
        params ["_soundSource"];
        playsound3D [QPATHTOF_SOUND(sounds\noshock.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
    }, [_soundSource], 2] call CBA_fnc_waitAndExecute;
};


// medical menu log
// logs the heart rate and the blood pressure every second.
[{
    params ["_args", "_idPFH"];
    _args params ["_patient"];
    if !(_patient getVariable [QGVAR(X), false]) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _patient setVariable ["kat_AEDXPatient_PFH", nil];
        [_patient, "quick_view", LSTRING(AEDX_StatusLog)] call FUNC(removeLog);
    };

    //No Values for your Monitor atm
    if (GVAR(DeactMon_whileAED_X) && _patient getVariable [QGVAR(AEDinUse), false]) exitWith {};

    [_patient, "quick_view", LSTRING(AEDX_StatusLog)] call FUNC(removeLog);
    [_patient, "quick_view", LSTRING(AEDX_StatusLog),
    [round (_patient getVariable [QACEGVAR(medical,heartRate), 0]),
    (round (_patient getVariable [QACEGVAR(medical,bloodPressure), [0,0]] select 1)),
    (round (_patient getVariable [QACEGVAR(medical,bloodPressure), [80,120]] select 0)),
    (_patient getVariable [QEGVAR(breathing,airwayStatus), 100])]] call ACEFUNC(medical_treatment,addToLog);
}, 1, [_patient]] call CBA_fnc_addPerFrameHandler;


// Distance limit for AED-X and time limit for monitoring.
// disconnect the x-series

[{
    params ["_medic", "_patient", "_AEDOrigin", "_AEDProvider"];
    ((_patient distance2D _AEDProvider) > GVAR(distanceLimit_AEDX)) || !(_patient getVariable [QGVAR(X), false]) || (_AEDOrigin == 1 && !(_AEDProvider getVariable [QGVAR(AED_X_Connected), false])) || (_AEDOrigin == 2 && (vehicle _patient == _patient));
}, {
    params ["_medic", "_patient", "_AEDOrigin"];
    [_medic, _patient, _AEDOrigin] call FUNC(detachAEDX);
}, [_medic, _patient, _AEDOrigin, _AEDProvider], GVAR(timeLimit_AEDX), {
    params ["_medic", "_patient", "_AEDOrigin"];
    [_medic, _patient, _AEDOrigin] call FUNC(detachAEDX);
}] call CBA_fnc_waitUntilAndExecute;

// attach heart rate beep PFH if enabled in CBA settings
if !(GVAR(AED_BeepsAndCharge)) exitWith {};
[{
    params ["_patient", "_soundSource"];
    AEDBeepPlaying = false;

    if(GVAR(AED_X_Monitor_NoHeartRate) == 0) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_patient", "_soundSource"];

        if (!(_patient getVariable [QGVAR(X), false])) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (!(_patient getVariable [QGVAR(AED_X_VolumePatient), false]) || GVAR(DeactMon_whileAED_X) && _patient getVariable [QGVAR(AEDinUse), false]) exitWith {};
        
        if (AEDBeepPlaying) exitWith {};

        private _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
        AEDBeepPlaying = true;
        private _delay = 1.46; // standard on no heartrate delay

        if (_hr <= 0) then {
            playsound3D [QPATHTOF_SOUND(sounds\noheartrate.wav), _soundSource, false, getPosASL _soundSource, 2, 1, 15];
        } else {
            _delay = 60 / _hr;
            playsound3D [QPATHTOF_SOUND(sounds\heartrate.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
        };

        [{
            params ["_patient"];
            AEDBeepPlaying = false;
        }, [_patient, AEDBeepPlaying], _delay] call CBA_fnc_waitAndExecute;
    }, 0, [_patient, _soundSource]] call CBA_fnc_addPerFrameHandler;

    } else {
        playedAudio = false;
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_soundSource"];

            if(!(_patient getVariable [QGVAR(X), false])) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            if ( !(_patient getVariable [QGVAR(AED_X_VolumePatient), false]) || GVAR(DeactMon_whileAED_X) && _patient getVariable [QGVAR(AEDinUse), false]) exitWith {};

            if (AEDBeepPlaying) exitWith {};

            private _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
            AEDBeepPlaying = true;

            if (_hr <= 0) then {
                private _delayAEDBeepPlaying = 1.835;

                if (!(playedAudio)) then {
                    playsound3D [QPATHTOF_SOUND(sounds\checkpatient.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                    playedAudio = true;
                } else {
                    playsound3D [QPATHTOF_SOUND(sounds\alarm.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                    _delayAEDBeepPlaying = 0.526;
                };

                [{
                    params ["_patient"];
                    AEDBeepPlaying = false;
                }, [_patient], _delayAEDBeepPlaying] call CBA_fnc_waitAndExecute;

            } else {
                private _delay = 60 / _hr;
                playsound3D [QPATHTOF_SOUND(sounds\heartrate.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                [{
                    params ["_patient"];
                    AEDBeepPlaying = false;
                }, [_patient], _delay] call CBA_fnc_waitAndExecute;
                playedAudio = false;
            };
        }, 0, [_patient, _soundSource]] call CBA_fnc_addPerFrameHandler;
    };

    [{
        params ["_args", "_idPFH"];
        _args params ["_patient", "_soundSource"];

        if(!(_patient getVariable [QGVAR(X), false])) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (GVAR(DeactMon_whileAED_X) && _patient getVariable [QGVAR(AEDinUse), false] || !(_patient getVariable [QGVAR(AED_X_VolumePatient), false])) then {
        } else {
            private _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
            private _spO2 = _patient getVariable [QEGVAR(breathing,airwayStatus), 100];
            if (_spO2 < GVAR(AED_X_Monitor_SpO2Warning) && _hr != 0) then {
                playSound3D [QPATHTOF_SOUND(sounds\spo2warning.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
            };
        };
        
    }, 2, [_patient, _soundSource]] call CBA_fnc_addPerFrameHandler;
}, [_patient, _soundSource], 3.5] call CBA_fnc_waitAndExecute; // wait to analyze