#include "..\script_component.hpp"
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

private _occludedMedications = _patient getVariable [QACEGVAR(medical,occludedMedications), []];

private _occludedFlushed = false;

[_patient, "activity", LLSTRING(flush_log), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

if !(HAS_TOURNIQUET_APPLIED_ON(_patient,_partIndex)) then {
    {
        _x params ["_partIndexN", "_medication"];

        if(_partIndex isEqualTo _partIndexN) then {
            [QGVAR(medicationLocal), [_patient, _bodyPart, _medication], _patient] call CBA_fnc_targetEvent;

            _occludedMedications set [_forEachIndex, []];
            _occludedFlushed = true;
        };
    } forEach _occludedMedications;

    if (_occludedFlushed) then {
        _occludedMedications = _occludedMedications - [[]];
        _patient setVariable [QACEGVAR(medical,occludedMedications), _occludedMedications, true];
    };
};
