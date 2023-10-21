#include "..\script_component.hpp"
/*
 * Author: Blue
 * Analyzes the patient's heart rhythm
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Defibrillator type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_circulation_fnc_AED_Analyze;
 *
 * Public: No
 */

params ["_medic", "_patient", ["_defibrillatorType", "AED"]];

private _soundSource = _medic;

private _defibProvider = _patient getVariable QGVAR(Defibrillator_Provider);

switch (_defibProvider select 1) do {
    case 1: {_soundSource = _defibProvider select 0;};
    case 2: {_soundSource = _patient;};
    default {};
};

_patient setVariable [QGVAR(DefibrillatorInUse), true, true];
_patient setVariable [QGVAR(RhythmAnalyzed), false, true];

// Analyze rhythm

playsound3D [QPATHTOF_SOUND(sounds\analyzingnow.wav), _soundSource, false, getPosASL _soundSource, 5, 1, 15];

[{ // Don't touch patient while analyzing
    params ["_medic", "_patient"];

    !(isNull (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull])) || _patient getVariable [QGVAR(BVMInUse), false] || _patient call ACEFUNC(common,isAwake);
},
{ // Motion detected
    params ["_medic", "_patient", "_defibrillatorType", "_soundSource"];

    playsound3D [QPATHTOF_SOUND(sounds\stopmotion.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
    [{
        params ["_medic", "_patient", "_defibrillatorType", "_soundSource"];
        if (!(isNull (_patient getVariable [QACEGVAR(medical,CPR_provider), objNull])) || _patient getVariable [QGVAR(BVMInUse), false] || _patient call ACEFUNC(common,isAwake)) exitWith { // Motion persists, analyzing cancelled
            playsound3D [QPATHTOF_SOUND(sounds\3beep.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
            _patient setVariable [QGVAR(DefibrillatorInUse), false, true];
        };
        [_medic, _patient, _defibrillatorType] call FUNC(AED_Analyze);
    }, [_medic, _patient, _defibrillatorType, _soundSource], 5] call CBA_fnc_waitAndExecute;
},
[_medic, _patient, _defibrillatorType, _soundSource],
5 max (random 8), // Time to analyze
{
    params ["_medic", "_patient", "_defibrillatorType", "_soundSource"];

    _patient setVariable [QGVAR(RhythmAnalyzed), true, true];

    if (GVAR(AdvRhythm)) then {
        if (_patient getVariable [QGVAR(cardiacArrestType), 0] > 2) then { // shock advised
            playsound3D [QPATHTOF_SOUND(sounds\shockadvised.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
            [{ // If shock advised begin to charge
                params ["_medic", "_patient", "_defibrillatorType", "_soundSource"];

                [_medic, _patient, _soundSource, _defibrillatorType] call FUNC(AED_Charge);
            }, [_medic, _patient, _defibrillatorType, _soundSource], 1.7] call CBA_fnc_waitAndExecute;
        } else { // no shock advised
            playsound3D [QPATHTOF_SOUND(sounds\noshockadvised.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
            _patient setVariable [QGVAR(DefibrillatorInUse), false, true];
        };
    } else { // If advanced rhythms are disabled just check if patient is in cardiac arrest
        if (_patient getVariable [QACEGVAR(medical,heartRate), 0] isEqualTo 0) then {
            playsound3D [QPATHTOF_SOUND(sounds\shockadvised.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
            [{ // If shock advised begin to charge
                params ["_medic", "_patient", "_defibrillatorType", "_soundSource"];

                [_medic, _patient, _soundSource, _defibrillatorType] call FUNC(AED_Charge);
            }, [_medic, _patient, _defibrillatorType, _soundSource], 1.7] call CBA_fnc_waitAndExecute;
        } else {
            playsound3D [QPATHTOF_SOUND(sounds\noshockadvised.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
            _patient setVariable [QGVAR(DefibrillatorInUse), false, true];
        };
    };
}] call CBA_fnc_waitUntilAndExecute;
