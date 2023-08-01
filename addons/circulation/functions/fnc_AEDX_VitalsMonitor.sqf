#include "script_component.hpp"
/*
 * Author: Katalam
 * Modified: YetheSamartaka, Blue
 * Handle monitoring vitals
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 * 2: Sound source <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, player] call kat_circulation_fnc_AEDX_VitalsMonitor;
 *
 * Public: No
 */

params ["_medic", "_patient", "_soundSource"];

if (GVAR(AED_X_VitalsMonitor_BloodPressureInterval) isEqualTo 1) then { 
    BPInterval = true;
} else {
    BPInterval = false;
};

// medical menu log
// logs the heart rate and the blood pressure
private _vitalsMonitorPFH = [{
    params ["_args", "_idPFH"];
    _args params ["_patient"];
    if !(_patient getVariable [QGVAR(DefibrillatorPads_Connected), false]) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _patient setVariable ["kat_AEDXPatient_PFH", nil, true];
        [_patient, "quick_view", LSTRING(VitalsMonitor_StatusLog)] call FUNC(removeLog);
        [_patient, "quick_view", LSTRING(VitalsMonitorInactive_StatusLog)] call FUNC(removeLog);
    };

    //No Values for your Monitor atm
    if (_patient getVariable [QGVAR(DefibrillatorInUse), false]) exitWith {};

    // Clear previous log entry before adding new one
    [_patient, "quick_view", LSTRING(VitalsMonitor_StatusLog)] call FUNC(removeLog);
    [_patient, "quick_view", LSTRING(VitalsMonitorInactive_StatusLog)] call FUNC(removeLog);

    private _hr = 0;
    private _bp = [0,0];

    if (_patient getVariable [QGVAR(cardiacArrestType), 0] > 0) then {
        _hr = _patient call FUNC(getCardiacArrestHeartRate);

        if (GVAR(AED_X_VitalsMonitor_BloodPressureInterval) > 0) then {
            _bp = _patient getVariable [QGVAR(StoredBloodPressure), [0,0]];
        };
    } else {
        _hr = _patient getVariable [QACEGVAR(medical,heartRate), 0];
        
        if(GVAR(AED_X_VitalsMonitor_BloodPressureInterval) isEqualTo 0) then {
            _bp = _patient getVariable [QACEGVAR(medical,bloodPressure), [0,0]];
        } else {
            _bp = _patient getVariable [QGVAR(StoredBloodPressure), [0,0]];
        };
    };

    // If vitals are being monitored (pressure cuff + pulse oximeter) list all vitals, otherwise only heart rate
    if (_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) then {
        // heart rate, systolic / diastolic, spO2
        [_patient, "quick_view", LSTRING(VitalsMonitor_StatusLog), [round(_hr), round(_bp select 1), round(_bp select 0), round(_patient getVariable [QEGVAR(breathing,airwayStatus), 100])]] call ACEFUNC(medical_treatment,addToLog);
    } else {
        [_patient, "quick_view", LSTRING(VitalsMonitorInactive_StatusLog), [round(_hr)]] call ACEFUNC(medical_treatment,addToLog);
    };

    if(BPInterval) then { // Store new BP
        _patient setVariable [QGVAR(StoredBloodPressure), (_patient getVariable [QACEGVAR(medical,bloodPressure), [0,0]]), true];
        [{
            BPInterval = true;
        }, [], GVAR(AED_X_VitalsMonitor_BloodPressureInterval_Time)] call CBA_fnc_waitAndExecute;

        BPInterval = false;
    };
}, 1, [_patient]] call CBA_fnc_addPerFrameHandler;

private _PFHArray = [_vitalsMonitorPFH,-1,-1];

_patient setVariable ["kat_AEDXPatient_PFH", _PFHArray, true];

// attach heart rate beep PFH
AEDBeepPlaying = false;
if(GVAR(AED_X_VitalsMonitor_SoundsSelect) == 0) then {
    private _vitalsMonitorBeepPFH = [{
        params ["_args", "_idPFH"];
        _args params ["_patient", "_soundSource"];

        if (!(_patient getVariable [QGVAR(DefibrillatorPads_Connected), false])) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (!(_patient getVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false]) || _patient getVariable [QGVAR(DefibrillatorInUse), false]) exitWith {};
        if (AEDBeepPlaying) exitWith {};

        private _hr = 80;
        AEDBeepPlaying = true;

        if (GVAR(AdvRhythm) && (_patient getVariable [QGVAR(cardiacArrestType), 0] > 1)) then {
            _hr = _patient call FUNC(getCardiacArrestHeartRate);
        } else {
            _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
        };

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
        }, [_patient], _delay] call CBA_fnc_waitAndExecute;
    }, 0, [_patient, _soundSource]] call CBA_fnc_addPerFrameHandler;

    private _PFHArray = _patient getVariable ["kat_AEDXPatient_PFH", [-1,-1,-1]];
    _PFHArray set [1,_vitalsMonitorBeepPFH];
    _patient setVariable ["kat_AEDXPatient_PFH", _PFHArray, true];
} else {
    playedAudio = false;
    analyzeDelay = false;
    private _vitalsMonitorBeepPFH = [{
        params ["_args", "_idPFH"];
        _args params ["_patient", "_soundSource"];

        if(!(_patient getVariable [QGVAR(DefibrillatorPads_Connected), false])) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if (!(_patient getVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false]) || _patient getVariable [QGVAR(DefibrillatorInUse), false]) exitWith {
            analyzeDelay = false;
            playedAudio = false;
        };

        if (AEDBeepPlaying) exitWith {};
        private _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];

        if (GVAR(AdvRhythm)) then {
            private _cardiacState = _patient getVariable [QGVAR(cardiacArrestType), 0]; 

            if (_patient getVariable [QGVAR(cardiacArrestType), 0] in [2,4]) then {
                _hr = _patient call FUNC(getCardiacArrestHeartRate);
            } else {
                _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
            };

            if (!(_patient getVariable [QGVAR(cardiacArrestType), 0] in [0,2]) && !analyzeDelay) then {
                [{
                    params ["_patient"];
                    analyzeDelay = true;
                }, [_patient], 2] call CBA_fnc_waitAndExecute;
            };

            if (alive _patient && (_cardiacState in [0,2] || (_cardiacState isEqualTo 4 && !analyzeDelay))) then {
                AEDBeepPlaying = true;
                private _delay = 60 / _hr;
                playsound3D [QPATHTOF_SOUND(sounds\heartrate_AED.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                [{
                    params ["_patient"];
                    AEDBeepPlaying = false;
                }, [_patient], _delay] call CBA_fnc_waitAndExecute;
                playedAudio = false;
                analyzeDelay = false;
            } else {
                if (analyzeDelay) then {
                    AEDBeepPlaying = true;
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
                };
            };
        } else {
            AEDBeepPlaying = true;
            _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];

            if (_hr > 0) then {
                private _delay = 60 / _hr;
                playsound3D [QPATHTOF_SOUND(sounds\heartrate_AED.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                [{
                    params ["_patient"];
                    AEDBeepPlaying = false;
                }, [_patient], _delay] call CBA_fnc_waitAndExecute;
                playedAudio = false;
            } else {
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
            };
        };
    }, 0, [_patient, _soundSource]] call CBA_fnc_addPerFrameHandler;

    private _PFHArray = _patient getVariable ["kat_AEDXPatient_PFH", [-1,-1,-1]];
    _PFHArray set [1,_vitalsMonitorBeepPFH];
    _patient setVariable ["kat_AEDXPatient_PFH", _PFHArray, true];
};

if (_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) then {
    private _pulseOximeterPFH = [{
        params ["_args", "_idPFH"];
        _args params ["_patient", "_soundSource"];
    
        if !(_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        if (_patient getVariable [QGVAR(DefibrillatorInUse), false] || !(_patient getVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false])) then {
        } else {
            private _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
            private _spO2 = _patient getVariable [QEGVAR(breathing,airwayStatus), 100];
            if (_spO2 < GVAR(AED_X_Monitor_SpO2Warning) && _hr != 0) then {
                playSound3D [QPATHTOF_SOUND(sounds\spo2warning.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
            };
        };
    }, 2, [_patient, _soundSource]] call CBA_fnc_addPerFrameHandler;
    
    private _PFHArray = _patient getVariable ["kat_AEDXPatient_PFH", [-1,-1,-1]];
    _PFHArray set [2, _pulseOximeterPFH];
    _patient setVariable ["kat_AEDXPatient_PFH", _PFHArray, true];
};