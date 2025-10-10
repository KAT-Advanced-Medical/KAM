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
private _pressureBag = _patient getVariable [QGVAR(pressureBag), [0,0,0,0,0,0,0,0,0,0,0,0]];
if ((_pressureBag select _partIndex) > 0) exitWith {
    [LLSTRING(Pressure_already), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};
_pressureBag set [_partIndex, ((_pressureBag select _partIndex) + random [0.4, 0.6, 0.8])];

_patient setVariable [QGVAR(pressureBag), _pressureBag, true];

_medic setVariable [QGVAR(pressureIVApplied), true, true];

[LLSTRING(Pressure_Ready), 1.5, _medic, 11] call ACEFUNC(common,displayTextStructured);

[{
    params ["_medic", "_patient", "_partIndex"];
    private _pressureBag = _patient getVariable [QGVAR(pressureBag), [0,0,0,0,0,0,0,0,0,0,0,0]];
    private _bodyPart = ALL_BODY_PARTS select _partIndex;
    (((_patient distance2D _medic) > 5) || ((_pressureBag select _partIndex) == 1) || !([_medic, _patient, _bodyPart] call FUNC(hasIVBag)));
}, {
    params ["_medic", "_patient", "_partIndex"];
    private _pressureBag = _patient getVariable [QGVAR(pressureBag), [0,0,0,0,0,0,0,0,0,0,0,0]];
    if ((_pressureBag select _partIndex) != 1) then {
        _pressureBag set [_partIndex, 0];
    };
    _patient setVariable [QGVAR(pressureBag), _pressureBag, true];
    _medic setVariable [QGVAR(pressureIVApplied), false, true];
    [LLSTRING(Pressure_Cancel), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
}, [_medic, _patient, _partIndex], 3600, {
    params ["_medic", "_patient", "_partIndex"];
    private _pressureBag = _patient getVariable [QGVAR(pressureBag), [0,0,0,0,0,0,0,0,0,0,0,0]];
    if ((_pressureBag select _partIndex) != 1) then {
        _pressureBag set [_partIndex, 0];
    };
    _patient setVariable [QGVAR(pressureBag), _pressureBag, true];
    _medic setVariable [QGVAR(pressureIVApplied), false, true];
    [LLSTRING(Pressure_Cancel), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
}] call CBA_fnc_waitUntilAndExecute;
