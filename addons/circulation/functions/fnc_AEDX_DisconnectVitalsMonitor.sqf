#include "..\script_component.hpp"
/*
 * Author: Blue
 * Disconnect vitals monitoring from patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Hide activity log <BOOL>
 * 3: Source if not patient <INT>
 * 4: AED origin if no patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, false, 0, objNull] call kat_circulation_fnc_AEDX_DisconnectVitalsMonitor;
 *
 * Public: No
 */

params ["_medic", ["_patient", objNull], ["_noLog", false], ["_noPatientSource", 0], ["_noPatientOrigin", objNull]];

private _provider = _patient getVariable QGVAR(AED_X_VitalsMonitor_Provider);

if (_patient isEqualTo objNull) then {
    _provider = [_noPatientOrigin, _noPatientSource];
};

switch (_provider select 1) do {
    case 1: { // Placed
        (_provider select 0) setVariable [QGVAR(AED_X_VitalsMonitor_Volume), (_patient getVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false]), true];
        (_provider select 0) setVariable [QGVAR(AED_X_VitalsMonitor_Patient), nil, true];
    };
    case 2: { // Vehicle

    };
    default { // Medic
        _medic setVariable [QGVAR(AED_X_MedicVitalsMonitor_Connected), false, true];
        _medic setVariable [QGVAR(AED_X_MedicVitalsMonitor_Patient), nil, true];
        _medic setVariable [QGVAR(AED_X_VitalsMonitor_Volume), (_patient getVariable [QGVAR(AED_X_VitalsMonitor_VolumePatient), false]), true];
    };
};

if (_patient isEqualTo objNull) exitWith {};

_patient setVariable [QGVAR(AED_X_VitalsMonitor_Provider), nil, true];
_patient setVariable [QGVAR(AED_X_VitalsMonitor_Connected), false, true];

if !(_noLog) then {
    [_patient, "activity", LSTRING(Activity_DisconnectVitalsMonitor), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
};
