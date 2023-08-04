#include "script_component.hpp"
/*
 * Author: Blue
 * Attach Defibrillator pads to patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Defibrillator Source Type <INT>
 * 3: Defibrillator Classname <STRING>
 * 4: Extra Arguments <ARRAY>
 *   0: Placed AED <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, 1, 'kat_AEDItem'] call kat_circulation_fnc_Defibrillator_AttachPads;
 *
 * Public: No
 */

params ["_medic", "_patient", "_source", "_defibClassname", ["_extraArgs",[]]];
_extraArgs params [["_placedAED",objNull]];

private _provider = objNull;
private _soundSource = _medic;

private _exit = false;

switch (_source) do {
    case 1: { // Placed
        private _placedDefibrillator = objNull;

        if (_placedAED isEqualTo objNull) then {
            private _nearObjects = nearestObjects [position _patient, ["kat_AEDItem"], GVAR(Defibrillator_DistanceLimit)];
            private _index = _nearObjects findIf {typeOf _x isEqualTo "kat_X_AEDItem"};
            if (_index isEqualTo -1) exitWith {_exit = true;};
            _placedDefibrillator = _nearObjects select (_nearObjects findIf {typeOf _x isEqualTo "kat_X_AEDItem"});
        } else {
            _placedDefibrillator = _placedAED;
        };

        if (_exit) exitWith {[LLSTRING(Defibrillator_PatientDisconnected), 1.5, _medic] call ACEFUNC(common,displayTextStructured);};

        _provider = _placedDefibrillator;
        _soundSource = _placedDefibrillator;

        _placedDefibrillator setVariable [QGVAR(Defibrillator_Patient), _patient, true];

        [{ // Remove pads if patient gets too far
            params ["_medic", "_patient", "_provider"];
        
            (_patient distance2D _provider) > GVAR(Defibrillator_DistanceLimit);
        }, {
            params ["_medic", "_patient", "_provider"];
        
            if (_patient getVariable [QGVAR(DefibrillatorPads_Connected), false]) then {
                [_medic, _patient] call FUNC(Defibrillator_RemovePads);
                [LLSTRING(Defibrillator_PatientDisconnected), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
            };
        }, [_medic, _patient, _placedDefibrillator], 3600, {
            params ["_medic", "_patient", "_provider"];
        
            if (_patient getVariable [QGVAR(DefibrillatorPads_Connected), false]) then {
                [_medic, _patient] call FUNC(Defibrillator_RemovePads);
                [LLSTRING(Defibrillator_PatientDisconnected), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
            };
        }] call CBA_fnc_waitUntilAndExecute;
    };
    case 2: { // Vehicle
        _provider = objectParent _patient;
        _soundSource = _patient;

        [{ // Remove pads if patient exits vehicle
            params ["_medic", "_patient", "_provider"];
        
            !((objectParent _patient) isEqualTo _provider);
        }, {
            params ["_medic", "_patient", "_provider"];

            [_medic, _patient] call FUNC(Defibrillator_RemovePads);

            if ((objectParent _medic) isEqualTo (objectParent _patient)) then {
                [LLSTRING(Defibrillator_PatientDisconnected), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
            };
        }, [_medic, _patient, _provider], 3600, {
            params ["_medic", "_patient", "_provider"];
        
            [_medic, _patient] call FUNC(Defibrillator_RemovePads);

            if ((objectParent _medic) isEqualTo (objectParent _patient)) then {
                [LLSTRING(Defibrillator_PatientDisconnected), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
            };
        }] call CBA_fnc_waitUntilAndExecute;
    };
    default { // Medic
        _provider = _medic;
        _medic setVariable [QGVAR(MedicDefibrillatorInUse), true, true];
        _medic setVariable [QGVAR(MedicDefibrillator_Patient), _patient, true];

        [{ // Remove pads if patient gets too far
            params ["_medic", "_patient"];
        
            (_patient distance2D _medic) > GVAR(Defibrillator_DistanceLimit);
        }, {
            params ["_medic", "_patient"];
        
            [_medic, _patient] call FUNC(Defibrillator_RemovePads);
            [LLSTRING(Defibrillator_PatientDisconnected), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        }, [_medic, _patient], 3600, {
            params ["_medic", "_patient"];
        
            [_medic, _patient] call FUNC(Defibrillator_RemovePads);
            [LLSTRING(Defibrillator_PatientDisconnected), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
        }] call CBA_fnc_waitUntilAndExecute;
    };
};

_patient setVariable [QGVAR(DefibrillatorPads_Connected), true, true];
_patient setVariable [QGVAR(Defibrillator_Provider), [_provider, _source, _defibClassname], true];
_patient setVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), (_provider getVariable [QGVAR(AED_X_VitalsMonitor_Volume), false]), true];

[_patient, "activity", LSTRING(Activity_AttachPads), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

if (_defibClassname isEqualTo "kat_X_AED") exitWith {
    [_medic, _patient, _provider] call FUNC(AEDX_VitalsMonitor);
};

[{ // Prompt to analyze after placing pads
    params ["_soundSource"];

    playsound3D [QPATHTOF_SOUND(sounds\pushanalyze.wav), _soundSource, false, getPosASL _soundSource, 6, 1, 15];
}, [_soundSource], 1] call CBA_fnc_waitAndExecute;