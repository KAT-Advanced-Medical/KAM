#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Flushing IV access with saline
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "LeftArm"] call kat_pharma_fnc_treatmentAdvanced_FlushLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;

_IVarray set [_partIndex, 4];
_patient setVariable [QGVAR(IV), _IVarray, true];

[_patient, "activity", LLSTRING(flush_log), [[_medic] call ACEFUNC(common,getName), [_patient] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);