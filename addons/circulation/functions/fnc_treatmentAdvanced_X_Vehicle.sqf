#include "script_component.hpp"
/*
 * Author: Katalam
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
 * [player, cursorTarget] call kat_circulation_fnc_treatmentAdvanced_X_Vehicle;
 *
 * Public: No
 */

params ["_player", "_target"];

_vehicle = _target getVariable [QGVAR(AEDvehicleName), ""];

if (_target getVariable ["kat_AEDXPatient_PFH", false]) exitWith {};
_target setVariable ["kat_AEDXPatient_PFH", true];

// if there is already a connected x-series exitWith a hint
if (_target getVariable [QGVAR(X), false]) exitWith {
    private _output = localize LSTRING(X_already);
    [_output, 1.5, _player] call ace_common_fnc_displayTextStructured;
};

// connect the x-series
_target setVariable [QGVAR(X), true, true];

private _bloodLoss = _target getVariable ["ace_medical_bloodVolume", 6.0];
private _asystole = _target getVariable [QGVAR(asystole), 1];

if !(GVAR(AdvRhythm)) then {
    _target setVariable [QGVAR(asystole), 1, true];
    _asystole = _target getVariable [QGVAR(asystole), 1];
    } else {
    if (_bloodLoss > 3.6) then {
        _target setVariable [QGVAR(asystole), 1, true];
        _asystole = _target getVariable [QGVAR(asystole), 1];
    } else {
        _target setVariable [QGVAR(asystole), 2, true];
        _asystole = _target getVariable [QGVAR(asystole), 2];
    };
};

// analyse sound feedback
playsound3D [QPATHTOF_SOUND(sounds\analyse.wav), _target, false, getPosASL _target, 5, 1, 15];

// wait for the analyse and give the advise
if ((_target getVariable ["ace_medical_heartRate", 0] isEqualTo 0) && {_target getVariable [QGVAR(asystole), 1] < 2}) then {
    [{
        params ["_target"];
        playsound3D [QPATHTOF_SOUND(sounds\shock.wav), _target, false, getPosASL _target, 6, 1, 15];
    }, [_target], 2] call CBA_fnc_waitAndExecute;
} else {
    [{
        params ["_target"];
        playsound3D [QPATHTOF_SOUND(sounds\noshock.wav), _target, false, getPosASL _target, 6, 1, 15];
    }, [_target], 2] call CBA_fnc_waitAndExecute;
};


// medical menu log
// logs every second the heart rate and the blood pressure.
private _string = "HR: %1 RR: %2/%3 SpO2: %4";
[{
    params ["_args", "_idPFH"];
    _args params ["_string", "_target"];
    if !(_target getVariable [QGVAR(X), false]) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _target setVariable ["kat_AEDXPatient_PFH", nil];
    };

    //No Values for your Monitor atm
    if (GVAR(DeactMon_whileAED_X) && _target getVariable ['kat_AEDinUse', false]) exitWith {};

    [_target, "quick_view", _string] call kat_circulation_fnc_removeLog;
    [_target, "quick_view", _string,
    [round (_target getVariable ["ace_medical_heartRate", 0]),
    (round (_target getVariable ["ace_medical_bloodPressure", [0,0]] select 1)),
    (round (_target getVariable ["ace_medical_bloodPressure", [80,120]] select 0)),
    (_target getVariable ["KAT_medical_airwayStatus", 100])]] call ace_medical_treatment_fnc_addToLog;
}, 1, [_string, _target]] call CBA_fnc_addPerFrameHandler;



// Distance limit for AED-X and time limit for monitoring.
// disconnect the x-series
[{
    params ["_vehicle", "_target"];
    ((_target distance2D _vehicle) > GVAR(distanceLimit_AEDX))
}, {
    params ["_vehicle", "_target"];
    [_vehicle, _target, false] call FUNC(returnAED_X);
}, [_vehicle, _target], GVAR(timeLimit_AEDX), {
    params ["_vehicle", "_target"];
    [_vehicle, _target, false] call FUNC(returnAED_X);
}] call CBA_fnc_waitUntilAndExecute;

// spawns the heart rate beep.
[_target, _player] spawn {
    params ["_target", "_player"];
    while {_target getVariable [QGVAR(X), false]} do {
        if (GVAR(DeactMon_whileAED_X) && _target getVariable ['kat_AEDinUse', false]) then {
        //No Beep for you atm
        } else {
            private _hr = _target getVariable ["ace_medical_heartRate", 80];
            if (_hr <= 0) then {
                private _soundPath1 = _target getVariable [QGVAR(X_sound1), QPATHTOF_SOUND(sounds\noheartrate.wav)];
                playsound3D [_soundPath1, _target, false, getPosASL _target, 2, 1, 15];
                sleep 1.478;
            } else {
                private _sleep = 60 / _hr;
                private _soundPath2 = _target getVariable [QGVAR(X_sound2), QPATHTOF_SOUND(sounds\heartrate.wav)];
                playsound3D [_soundPath2, _target, false, getPosASL _target, 5, 1, 15];
                sleep 0.25;
                sleep _sleep;
            };
        };
    };
};
