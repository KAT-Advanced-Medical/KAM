#include "script_component.hpp"
/*
 * Author: Blue
 * Connect vitals monitoring to patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Source <INT>
 * 3: Extra Arguments <ARRAY>
 *   0: Placed AED <OBJECT>
 * 4: Hide activity log <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject,  0, [], false] call kat_circulation_fnc_AEDX_ConnectVitalsMonitor;
 *
 * Public: No
 */

params ["_medic", "_patient", "_source", ["_extraArgs",[]], ["_noLog", false]];
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

        _placedDefibrillator setVariable [QGVAR(AED_X_VitalsMonitor_Patient), _patient, true];

        [{ // Disconnect monitoring if patient gets too far
            params ["_medic", "_patient", "_provider"];
        
            (_patient distance2D _provider) > GVAR(Defibrillator_DistanceLimit) || !((objectParent _medic) isEqualTo (objectParent _patient));
        }, {
            params ["_medic", "_patient", "_provider"];
        
            if (_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) then {
                [_medic, _patient] call FUNC(AEDX_DisconnectVitalsMonitor);
            };
        }, [_medic, _patient, _placedDefibrillator], 3600, {
            params ["_medic", "_patient", "_provider"];
        
            if (_patient getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) then {
                [_medic, _patient] call FUNC(AEDX_DisconnectVitalsMonitor);
            };
        }] call CBA_fnc_waitUntilAndExecute;
    };
    case 2: { // Vehicle
        _provider = objectParent _patient;
        _soundSource = _patient;

        [{ // Disconnect monitoring if patient exits vehicle
            params ["_medic", "_patient", "_provider"];
        
            !((objectParent _patient) isEqualTo _provider);
        }, {
            params ["_medic", "_patient", "_provider"];

            [_medic, _patient] call FUNC(AEDX_DisconnectVitalsMonitor);
        }, [_medic, _patient, _provider], 3600, {
            params ["_medic", "_patient", "_provider"];
        
            [_medic, _patient] call FUNC(AEDX_DisconnectVitalsMonitor);
        }] call CBA_fnc_waitUntilAndExecute;
    };
    default { // Medic
        _provider = _medic;
        _medic setVariable [QGVAR(AED_X_MedicVitalsMonitor_Connected), true, true];
        _medic setVariable [QGVAR(AED_X_MedicVitalsMonitor_Patient), _patient, true];

        [{ // Disconnect monitoring if patient gets too far
            params ["_medic", "_patient"];
        
            (_patient distance2D _medic) > GVAR(Defibrillator_DistanceLimit) || !((objectParent _medic) isEqualTo (objectParent _patient));
        }, {
            params ["_medic", "_patient"];
        
            [_medic, _patient] call FUNC(AEDX_DisconnectVitalsMonitor);
        }, [_medic, _patient], 3600, {
            params ["_medic", "_patient"];
        
            [_medic, _patient] call FUNC(AEDX_DisconnectVitalsMonitor);
        }] call CBA_fnc_waitUntilAndExecute;
    };
};

_patient setVariable [QGVAR(AED_X_VitalsMonitor_Connected), true, true];
_patient setVariable [QGVAR(AED_X_VitalsMonitor_Provider), [_provider, _source], true];

if !((_patient getVariable ["kat_AEDXPatient_PFH", -1]) isEqualTo -1) then {
    [(_patient getVariable "kat_AEDXPatient_PFH") select 0] call CBA_fnc_removePerFrameHandler;
    [(_patient getVariable "kat_AEDXPatient_PFH") select 1] call CBA_fnc_removePerFrameHandler;
    [{
        params ["_medic", "_patient", "_provider"];
        [_medic, _patient, _provider] call FUNC(AEDX_VitalsMonitor);
    }, [_medic, _patient, _provider], 0.5] call CBA_fnc_waitAndExecute;
} else {
    _patient setVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), (_provider getVariable [QGVAR(AED_X_VitalsMonitor_Volume), false]), true];
};

if !(_noLog) then {
    [_patient, "activity", LSTRING(Activity_ConnectVitalsMonitor), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
};