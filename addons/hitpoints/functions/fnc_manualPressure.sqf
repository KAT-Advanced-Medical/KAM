#include "..\script_component.hpp"
/*
 * Author: Katalam (Adjusted by ChatGPT)
 * Apply manual pressure for airway management.
 * If medic already has pressure active (on self or another), it is removed first.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Successful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget, "head"] call kat_airway_fnc_treatmentAdvanced_ManualBagPressure;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _manualPressure = GET_APPLIEDPRESSURE(_patient);

private _oldPartArray = _medic getVariable [QGVAR(pressureApplied), [-1, objNull]];
private _oldPartIndex = _oldPartArray select 0;
private _oldPatient = _oldPartArray select 1;

if (_oldPartIndex != -1 && {!isNull _oldPatient}) then {
    private _pressureArray = GET_APPLIEDPRESSURE(_oldPatient);
    if ((_pressureArray select _oldPartIndex) != 0) then {
        _pressureArray set [_oldPartIndex, 0];
        _oldPatient setVariable [VAR_APPLIEDPRESSURE, _pressureArray, true];
    };
    _medic setVariable [QGVAR(pressureApplied), [-1, objNull], true];
    [LLSTRING(Pressure_Cancel), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

// --- Prevent applying to a part that already has pressure
if ((_manualPressure select _partIndex) > 0) exitWith {
    [LLSTRING(Pressure_already), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

// --- Apply new pressure
_manualPressure set [_partIndex, ((_manualPressure select _partIndex) + selectRandom [0.6, 0.7, 0.8])];
_patient setVariable [VAR_APPLIEDPRESSURE, _manualPressure, true];
_medic setVariable [QGVAR(pressureApplied), [_partIndex, _patient], true];

[LLSTRING(Pressure_Ready), 1.5, _medic, 11] call ACEFUNC(common,displayTextStructured);

// --- Wait until pressure is broken (distance > 5m, timeout, or cancel)
[{
    params ["_medic", "_patient"];
    private _pressureData = _medic getVariable [QGVAR(pressureApplied), [-1, objNull]];
    private _hasPressure = ((_pressureData select 0) != -1);
    ((_patient distance2D _medic) > 5) || {!_hasPressure};
}, {
    params ["_medic", "_patient", "_partIndex"];
    private _manualPressure = GET_APPLIEDPRESSURE(_patient);
    if ((_manualPressure select _partIndex) != 0) then {
        _manualPressure set [_partIndex, 0];
    };
    _patient setVariable [VAR_APPLIEDPRESSURE, _manualPressure, true];
    _medic setVariable [QGVAR(pressureApplied), [-1, objNull], true];
    [LLSTRING(Pressure_Cancel), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
}, [_medic, _patient, _partIndex], 3600, {
    params ["_medic", "_patient", "_partIndex"];
    private _manualPressure = GET_APPLIEDPRESSURE(_patient);
    if ((_manualPressure select _partIndex) != 0) then {
        _manualPressure set [_partIndex, 0];
    };
    _patient setVariable [VAR_APPLIEDPRESSURE, _manualPressure, true];
    _medic setVariable [QGVAR(pressureApplied), [-1, objNull], true];
    [LLSTRING(Pressure_Cancel), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
}] call CBA_fnc_waitUntilAndExecute;

