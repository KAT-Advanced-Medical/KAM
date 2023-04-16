#include "script_component.hpp"
/*
 * Author: Katalam, modified by Blue
 * Handle the X Series Defi for the patient in a vehicle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_circulation_fnc_attachAEDXVehicle;
 *
 * Public: No
 */

params ["_medic", "_patient"];

_vehicle = _patient getVariable [QGVAR(AEDvehicleName), ""];

if (_patient getVariable ["kat_AEDXPatient_PFH", false]) exitWith {};
_patient setVariable ["kat_AEDXPatient_PFH", true];

// if there is already a connected x-series exitWith a hint
if (_patient getVariable [QGVAR(X), false]) exitWith {
    private _output = LLSTRING(X_already);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

// connect the x-series
_patient setVariable [QGVAR(X), true, true];
_patient setVariable [QGVAR(AED_X_VolumePatient), _medic getVariable QGVAR(AED_X_Volume), true];

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
playsound3D [QPATHTOF_SOUND(sounds\analyse.wav), _patient, false, getPosASL _patient, 5, 1, 15];

// wait for the analyse and give the advise
if ((_patient getVariable [QACEGVAR(medical,heartRate), 0] isEqualTo 0) && {_patient getVariable [QGVAR(asystole), 1] < 2}) then {
    [{
        params ["_patient"];
        playsound3D [QPATHTOF_SOUND(sounds\shock.wav), _patient, false, getPosASL _patient, 6, 1, 15];
    }, [_patient], 2] call CBA_fnc_waitAndExecute;
} else {
    [{
        params ["_patient"];
        playsound3D [QPATHTOF_SOUND(sounds\noshock.wav), _patient, false, getPosASL _patient, 6, 1, 15];
    }, [_patient], 2] call CBA_fnc_waitAndExecute;
};


// medical menu log
// logs every second the heart rate and the blood pressure.
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
    params ["_vehicle", "_patient"];
    ((_patient distance2D _vehicle) > GVAR(distanceLimit_AEDX))
}, {
    params ["_vehicle", "_patient"];
    [_vehicle, _patient, false] call FUNC(returnAED_X);
}, [_vehicle, _patient], GVAR(timeLimit_AEDX), {
    params ["_vehicle", "_patient"];
    [_vehicle, _patient, false] call FUNC(returnAED_X);
}] call CBA_fnc_waitUntilAndExecute;

// attach heart rate beep PFH.
[{
    params ["_patient"];
    AEDBeepPlaying = false;
    
    if(GVAR(AED_X_Monitor_NoHeartRate) == 0) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_patient"];

        if (!(_patient getVariable [QGVAR(X), false])) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (!(_patient getVariable [QGVAR(AED_X_VolumePatient), false]) || GVAR(DeactMon_whileAED_X) && _patient getVariable [QGVAR(AEDinUse), false]) exitWith {};
        
        if (AEDBeepPlaying) exitWith {};

        private _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
        AEDBeepPlaying = true;
        private _delay = 1.46; // standard on no heartrate delay

        if (_hr <= 0) then {
            playsound3D [QPATHTOF_SOUND(sounds\noheartrate.wav), _patient, false, getPosASL _patient, 2, 1, 15];
        } else {
            _delay = 60 / _hr;
            playsound3D [QPATHTOF_SOUND(sounds\heartrate.wav), _patient, false, getPosASL _patient, 5, 1, 15];
        };

        [{
            params ["_patient"];
            AEDBeepPlaying = false;
        }, [_patient,AEDBeepPlaying], _delay] call CBA_fnc_waitAndExecute;
    }, 0, [_patient]] call CBA_fnc_addPerFrameHandler;

    } else {
        playedAudio = false;
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient"];

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
                    playsound3D [QPATHTOF_SOUND(sounds\checkpatient.wav), _patient, false, getPosASL _patient, 5, 1, 15];
                    playedAudio = true;
                } else {
                    playsound3D [QPATHTOF_SOUND(sounds\alarm.wav), _patient, false, getPosASL _patient, 5, 1, 15];
                    _delayAEDBeepPlaying = 0.526;
                };

                [{
                    params ["_patient"];
                    AEDBeepPlaying = false;
                }, [_patient], _delayAEDBeepPlaying] call CBA_fnc_waitAndExecute;

            } else {
                private _delay = 60 / _hr;
                playsound3D [QPATHTOF_SOUND(sounds\heartrate.wav), _patient, false, getPosASL _patient, 5, 1, 15];
                [{
                    params ["_patient"];
                    AEDBeepPlaying = false;
                }, [_patient], _delay] call CBA_fnc_waitAndExecute;
                playedAudio = false;
            };
        }, 0, [_patient]] call CBA_fnc_addPerFrameHandler;
    };

    [{
        params ["_args", "_idPFH"];
        _args params ["_patient"];

        if(!(_patient getVariable [QGVAR(X), false])) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (GVAR(DeactMon_whileAED_X) && _patient getVariable [QGVAR(AEDinUse), false] || !(_patient getVariable [QGVAR(AED_X_VolumePatient), false])) then {
        } else {
            private _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
            private _spO2 = _patient getVariable [QEGVAR(breathing,airwayStatus), 100];
            if (_spO2 < GVAR(AED_X_Monitor_SpO2Warning) && _hr != 0) then {
                playSound3D [QPATHTOF_SOUND(sounds\spo2warning.wav), _patient, false, getPosASL _patient, 5, 1, 15];
            };
        };
        
    }, 2, [_patient]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 3.5] call CBA_fnc_waitAndExecute; // wait to analyze