#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Modified: YetheSamartaka, Blue, apo_tle
 * Handle monitoring vitals
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Patient <OBJECT>
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
    GVAR(BPInterval) = true;
} else {
    GVAR(BPInterval) = false;
};

if (_patient getVariable ["kat_AEDXPatient_PFH", -1] isEqualTo -1) then {
    // medical menu log
    // logs the heart rate and the blood pressure
    private _vitalsMonitorPFH = [{
        params ["_args", "_idPFH"];
        _args params ["_patient"];
        if ((!(_patient getVariable [QGVAR(DefibrillatorPads_Connected), false]) && !(_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false])) || _patient isEqualTo objNull) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            _patient setVariable ["kat_AEDXPatient_PFH", nil, true];
            [_patient, "quick_view", LSTRING(VitalsMonitor_StatusLog)] call FUNC(removeLog);
            [_patient, "quick_view", LSTRING(VitalsMonitor_VMInactive_StatusLog)] call FUNC(removeLog);
            [_patient, "quick_view", LSTRING(VitalsMonitor_VMActive_StatusLog)] call FUNC(removeLog);

            [_patient, "quick_view", LSTRING(VitalsMonitor_StatusLog_HasEtco2Monitor)] call FUNC(removeLog);
            [_patient, "quick_view", LSTRING(VitalsMonitor_VMInactive_StatusLog_HasEtco2Monitor)] call FUNC(removeLog);
            [_patient, "quick_view", LSTRING(VitalsMonitor_VMActive_StatusLog_HasEtco2Monitor)] call FUNC(removeLog);
        };

        //No Values for your Monitor atm
        if (_patient getVariable [QGVAR(DefibrillatorInUse), false]) exitWith {};

        // Clear previous log entry before adding new one
        [_patient, "quick_view", LSTRING(VitalsMonitor_StatusLog)] call FUNC(removeLog);
        [_patient, "quick_view", LSTRING(VitalsMonitor_VMInactive_StatusLog)] call FUNC(removeLog);
        [_patient, "quick_view", LSTRING(VitalsMonitor_VMActive_StatusLog)] call FUNC(removeLog);

        [_patient, "quick_view", LSTRING(VitalsMonitor_StatusLog_HasEtco2Monitor)] call FUNC(removeLog);
        [_patient, "quick_view", LSTRING(VitalsMonitor_VMInactive_StatusLog_HasEtco2Monitor)] call FUNC(removeLog);
        [_patient, "quick_view", LSTRING(VitalsMonitor_VMActive_StatusLog_HasEtco2Monitor)] call FUNC(removeLog);

        private _partIndex = ((_patient getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [objNull, -1, 3]]) select 2);
        private _tourniquetApplied = HAS_TOURNIQUET_APPLIED_ON(_patient,_partIndex);

        private _hr = 0;
        private _pr = 0;
        private _bp = [0,0];
        private _spO2 = 0;
        private _etco2 = 0;
        private _breathrate = 0;

        private _hasEtco2Monitor = ["_HasEtco2Monitor",""] select (_patient getVariable [QEGVAR(breathing,etco2Monitor),[]] isEqualTo []); //check for etco2 monitoring apparatus
        _hasEtco2Monitor = ["",_hasEtco2Monitor] select (EGVAR(breathing,Etco2_Enabled)); //check etco2 monitoring is enabled

        if !(_patient getVariable [QGVAR(heartRestart), false]) then {
            _pr = _patient getVariable [QACEGVAR(medical,heartRate), 0];
            if (_patient getVariable [QGVAR(cardiacArrestType), 0] > 0 && (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull)) then {
                _hr = _patient call FUNC(getCardiacArrestHeartRate);

                if (GVAR(AED_X_VitalsMonitor_BloodPressureInterval) > 0) then {
                    _bp = _patient getVariable [QGVAR(StoredBloodPressure), [0,0]];
                };
            } else {
                _hr = _pr;

                if (GVAR(AED_X_VitalsMonitor_BloodPressureInterval) isEqualTo 0) then {
                    _bp = _patient getVariable [QACEGVAR(medical,bloodPressure), [0,0]];
                } else {
                    _bp = _patient getVariable [QGVAR(StoredBloodPressure), [0,0]];
                };
            };
        };

        if (_tourniquetApplied) then {
            _bp = [0,0];
            _pr = 0;
        } else {
            _spO2 = _patient getVariable [QEGVAR(breathing,airwayStatus), 100];

            _etco2 = _patient call EFUNC(breathing,getETCo2);
            _breathrate = _patient call EFUNC(breathing,getRespiratoryRate);
        };

        // List vitals depending on if AED pads and vitals monitoring (pressure cuff + pulse oximeter) is connected
        if (_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false] && _patient getVariable [QGVAR(DefibrillatorPads_Connected), false]) then {
            // heart rate, systolic / diastolic, spO2, etco2, respiratory rate
            [_patient, "quick_view", LSTRING(VitalsMonitor_StatusLog)+_hasEtco2Monitor, [round(_hr), round(_bp select 1), round(_bp select 0), round(_spO2), _etco2, round(_breathrate)]] call ACEFUNC(medical_treatment,addToLog);
        } else {
            if (_patient getVariable [QGVAR(DefibrillatorPads_Connected), false]) then {
                [_patient, "quick_view", LSTRING(VitalsMonitor_VMInactive_StatusLog)+_hasEtco2Monitor, [round(_hr), round(_etco2), round(_breathrate)]] call ACEFUNC(medical_treatment,addToLog);
            } else {
                [_patient, "quick_view", LSTRING(VitalsMonitor_VMActive_StatusLog)+_hasEtco2Monitor, [round(_pr), round(_bp select 1), round(_bp select 0), round(_spO2), _etco2, round(_breathrate)]] call ACEFUNC(medical_treatment,addToLog);
            };
        };

        if (_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false] && GVAR(BPInterval)) then { // Store new BP
            if !(_tourniquetApplied) then {
                _patient setVariable [QGVAR(StoredBloodPressure), (_patient getVariable [QACEGVAR(medical,bloodPressure), [0,0]]), true];
            } else {
                _patient setVariable [QGVAR(StoredBloodPressure), [0,0], true];
            };
            [{
                GVAR(BPInterval) = true;
            }, [], GVAR(AED_X_VitalsMonitor_BloodPressureInterval_Time)] call CBA_fnc_waitAndExecute;

            GVAR(BPInterval) = false;
        };
    }, 1, [_patient]] call CBA_fnc_addPerFrameHandler;

    _patient setVariable ["kat_AEDXPatient_PFH", _vitalsMonitorPFH, true];
};

if (_patient getVariable [QGVAR(DefibrillatorPads_Connected), false] && {((_patient getVariable ["kat_AEDXPatient_HR_PFH", -1]) isEqualTo -1)}) then {
    // attach heart rate beep PFH
    GVAR(AEDBeepPlaying) = false;
    if (GVAR(AED_X_VitalsMonitor_SoundsSelect) == 0) then {
        private _vitalsMonitorBeepPFH = [{
            params ["_args", "_idPFH"];
            _args params ["_patient"];

            private _soundSource = (_patient getVariable [QGVAR(Defibrillator_Provider), [objNull, -1, -1]]) select 0;

            if (!(_patient getVariable [QGVAR(DefibrillatorPads_Connected), false])) exitWith {
                _patient setVariable ["kat_AEDXPatient_HR_PFH", nil, true];
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            if (!(_patient getVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false]) || _patient getVariable [QGVAR(DefibrillatorInUse), false]) exitWith {};
            if (GVAR(AEDBeepPlaying)) exitWith {};

            private _hr = 80;
            GVAR(AEDBeepPlaying) = true;

            if (GVAR(AdvRhythm) && (_patient getVariable [QGVAR(cardiacArrestType), 0] > 1) && _patient getVariable [QACEGVAR(medical,CPR_provider), objNull] isEqualTo objNull) then {
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

                GVAR(AEDBeepPlaying) = false;
            }, [_patient], _delay] call CBA_fnc_waitAndExecute;
        }, 0, [_patient]] call CBA_fnc_addPerFrameHandler;

        _patient setVariable ["kat_AEDXPatient_HR_PFH", _vitalsMonitorBeepPFH, true];
    } else {
        GVAR(playedAudio) = false;
        GVAR(analyzeDelay) = false;
        private _vitalsMonitorBeepPFH = [{
            params ["_args", "_idPFH"];
            _args params ["_patient"];

            private _soundSource = (_patient getVariable [QGVAR(Defibrillator_Provider), [objNull, -1, -1]]) select 0;

            if (!(_patient getVariable [QGVAR(DefibrillatorPads_Connected), false])) exitWith {
                _patient setVariable ["kat_AEDXPatient_HR_PFH", nil, true];
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            if (!(_patient getVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false]) || _patient getVariable [QGVAR(DefibrillatorInUse), false] || _patient getVariable [QGVAR(heartRestart), false]) exitWith {
                GVAR(analyzeDelay) = false;
                GVAR(playedAudio) = false;
            };

            if (GVAR(AEDBeepPlaying)) exitWith {};
            private _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];

            if (GVAR(AdvRhythm)) then {
                private _cardiacState = _patient getVariable [QGVAR(cardiacArrestType), 0];

                if (_cardiacState in [2,4]) then {
                    _hr = _patient call FUNC(getCardiacArrestHeartRate);
                } else {
                    _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
                };

                if (!(_cardiacState in [0,2]) && !(GVAR(analyzeDelay))) then {
                    [{
                        params ["_patient"];

                        GVAR(analyzeDelay) = true;
                    }, [_patient], 2] call CBA_fnc_waitAndExecute;
                };

                if (alive _patient && (_cardiacState in [0,2] || (_cardiacState isEqualTo 4 && !(GVAR(analyzeDelay))))) then {
                    GVAR(AEDBeepPlaying) = true;
                    private _delay = 60 / _hr;
                    playsound3D [QPATHTOF_SOUND(sounds\heartrate_AED.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                    [{
                        params ["_patient"];

                        GVAR(AEDBeepPlaying) = false;
                    }, [_patient], _delay] call CBA_fnc_waitAndExecute;
                    GVAR(playedAudio) = false;
                    GVAR(analyzeDelay) = false;
                } else {
                    if (GVAR(analyzeDelay)) then {
                        GVAR(AEDBeepPlaying) = true;
                        private _delayAEDBeepPlaying = 1.835;
                        if (!(GVAR(playedAudio))) then {
                            playsound3D [QPATHTOF_SOUND(sounds\checkpatient.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                            GVAR(playedAudio) = true;
                        } else {
                            playsound3D [QPATHTOF_SOUND(sounds\alarm.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                            _delayAEDBeepPlaying = 0.526;
                        };
                        [{
                            params ["_patient"];
                            GVAR(AEDBeepPlaying) = false;
                        }, [_patient], _delayAEDBeepPlaying] call CBA_fnc_waitAndExecute;
                    };
                };
            } else {
                GVAR(AEDBeepPlaying) = true;
                _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];

                if (_hr > 0) then {
                    private _delay = 60 / _hr;
                    playsound3D [QPATHTOF_SOUND(sounds\heartrate_AED.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                    [{
                        params ["_patient"];

                        GVAR(AEDBeepPlaying) = false;
                    }, [_patient], _delay] call CBA_fnc_waitAndExecute;
                    GVAR(playedAudio) = false;
                } else {
                    private _delayAEDBeepPlaying = 1.835;

                    if (!(GVAR(playedAudio))) then {
                        playsound3D [QPATHTOF_SOUND(sounds\checkpatient.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                        GVAR(playedAudio) = true;
                    } else {
                        playsound3D [QPATHTOF_SOUND(sounds\alarm.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
                        _delayAEDBeepPlaying = 0.526;
                    };
                    [{
                        params ["_patient"];

                        GVAR(AEDBeepPlaying) = false;
                    }, [_patient], _delayAEDBeepPlaying] call CBA_fnc_waitAndExecute;
                };
            };
        }, 0, [_patient]] call CBA_fnc_addPerFrameHandler;

        _patient setVariable ["kat_AEDXPatient_HR_PFH", _vitalsMonitorBeepPFH, true];
    };
};

if (_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false] && {(_patient getVariable ["kat_AEDXPatient_PulseOx_PFH", -1]) isEqualTo -1}) then {
    private _pulseOximeterPFH = [{
        params ["_args", "_idPFH"];
        _args params ["_patient"];

        private _soundSource = (_patient getVariable [QGVAR(Defibrillator_Provider), [objNull, -1, -1]]) select 0;

        if !(_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) exitWith {
            _patient setVariable ["kat_AEDXPatient_PulseOx_PFH", nil, true];
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        private _partIndex = ((_patient getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [-1, -1, -1]]) select 2);
        private _tourniquetApplied = HAS_TOURNIQUET_APPLIED_ON(_patient,_partIndex);

        if (_patient getVariable [QGVAR(DefibrillatorInUse), false] || !(_patient getVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false])) then {
        } else {
            private _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
            private _spO2 = _patient getVariable [QEGVAR(breathing,airwayStatus), 100];
            if (_spO2 < GVAR(AED_X_Monitor_SpO2Warning) || _tourniquetApplied) then {
                playSound3D [QPATHTOF_SOUND(sounds\spo2warning.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];
            };
        };
    }, 2, [_patient]] call CBA_fnc_addPerFrameHandler;

    _patient setVariable ["kat_AEDXPatient_PulseOx_PFH", _pulseOximeterPFH, true];
};
