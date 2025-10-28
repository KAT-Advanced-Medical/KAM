#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Overstretch the head of the patient for airway management without items
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_ManualBagPressure;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _manualPressure = GET_APPLIEDPRESSURE(_patient);
if ((_manualPressure select _partIndex) > 0) exitWith {
    [LLSTRING(Pressure_already), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};
_manualPressure set [_partIndex, ((_manualPressure select _partIndex) + random [0.6, 0.7, 0.8])];

_patient setVariable [VAR_APPLIEDPRESSURE, _manualPressure, true];

_medic setVariable [QGVAR(pressureApplied), true, true];

[LLSTRING(Pressure_Ready), 1.5, _medic, 11] call ACEFUNC(common,displayTextStructured);

[{
    params ["_medic", "_patient"];
    private _hasPressure = _medic getVariable [QGVAR(pressureApplied), false];
    (((_patient distance2D _medic) > 5) || !(_hasPressure));
}, {
    params ["_medic", "_patient", "_partIndex"];
    private _manualPressure = GET_APPLIEDPRESSURE(_patient);
    if ((_manualPressure select _partIndex) != 1) then {
        _manualPressure set [_partIndex, 0];
    };
    _patient setVariable [VAR_APPLIEDPRESSURE, _manualPressure, true];
    _medic setVariable [QGVAR(pressureApplied), false, true];
    [LLSTRING(Pressure_Cancel), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
}, [_medic, _patient, _partIndex], 3600, {
    params ["_medic", "_patient", "_partIndex"];
    private _manualPressure = GET_APPLIEDPRESSURE(_patient);
    if ((_manualPressure select _partIndex) != 1) then {
        _manualPressure set [_partIndex, 0];
    };
    _patient setVariable [VAR_APPLIEDPRESSURE, _manualPressure, true];
    _medic setVariable [QGVAR(pressureApplied), false, true];
    [LLSTRING(Pressure_Cancel), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
}] call CBA_fnc_waitUntilAndExecute;
