#include "script_component.hpp"
/*
 * Author: Katalam, modified by YetheSamartaka
 * Handle the X Series Defi for the patient.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_circulation_fnc_treatmentAdvanced_X;
 *
 * Public: No
 */

params ["_medic", "_patient"];

if (_patient getVariable ["kat_AEDXPatient_PFH", false]) exitWith {};
_patient setVariable ["kat_AEDXPatient_PFH", true];

// if there is already a connected x-series exitWith a hint
if (_patient getVariable [QGVAR(X), false]) exitWith {
    private _output = LLSTRING(X_already);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

// connect the x-series
_patient setVariable [QGVAR(X), true, true];
_medic setVariable [QGVAR(use), true, true];
_medic setVariable [QGVAR(returnedAED), false, true];

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
    params ["_medic", "_patient"];
    ((_patient distance2D _medic) > GVAR(distanceLimit_AEDX)) || _medic getVariable [QGVAR(returnedAED), true]
}, {
    params ["_medic", "_patient"];
    if (_medic getVariable [QGVAR(returnedAED), true]) exitWith {};
    [_medic, _patient, true] call FUNC(returnAED_X);
}, [_medic, _patient], GVAR(timeLimit_AEDX), {
    params ["_medic", "_patient"];
    [_medic, _patient, true] call FUNC(returnAED_X);
}] call CBA_fnc_waitUntilAndExecute;

// spawns the heart rate beep if enabled in CBA settings
if !(GVAR(AED_BeepsAndCharge)) exitWith {};
[_patient, _medic] spawn {
    params ["_patient", "_medic"];
    while {_patient getVariable [QGVAR(X), false]} do {
        if (GVAR(DeactMon_whileAED_X) && _patient getVariable [QGVAR(AEDinUse), false]) then {
        //No Beep for you atm
        } else {
            private _hr = _patient getVariable [QACEGVAR(medical,heartRate), 80];
            if (_hr <= 0) then {
                private _soundPath1 = _medic getVariable [QGVAR(X_sound1), QPATHTOF_SOUND(sounds\noheartrate.wav)];
                playsound3D [_soundPath1, _patient, false, getPosASL _patient, 2, 1, 15];
                sleep 1.478;
            } else {
                private _sleep = 60 / _hr;
                private _soundPath2 = _medic getVariable [QGVAR(X_sound2), QPATHTOF_SOUND(sounds\heartrate.wav)];
                playsound3D [_soundPath2, _patient, false, getPosASL _patient, 5, 1, 15];
                sleep 0.25;
                sleep _sleep;
            };
        };
    };
};
