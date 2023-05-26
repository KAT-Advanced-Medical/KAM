#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Local call for clearing all stitched and bandaged wounds on a patient
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_npwtTreatmentLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _debridement = _patient getVariable [QGVAR(debridement), [0,0,0,0,0,0]];

if ((_debridement select _part) != 1) exitWith {
    private _output = LLSTRING(debridement_fail);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

private _lidocaine = [_patient, "Lidocaine"] call ACEFUNC(medical_status,getMedicationCount);
private _morphine = [_patient, "Morphine"] call ACEFUNC(medical_status,getMedicationCount);
private _damage = _patient getVariable [QACEGVAR(medical,bodyPartDamage), [0,0,0,0,0,0]];

private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);
private _openWounds = GET_OPEN_WOUNDS(_patient);
private _bandaged = [];
private _stitched = [];
private _open = [];

private _remainder = false;

if (_lidocaine == 0 && _morphine == 0) then {
    private _pain = random [0.7, 0.8, 0.9];
    [_patient, _pain] call ACEFUNC(medical_status,adjustPainLevel);
};

{
    _x params ["_id", "_bodyPart", "_amount"];

    if (_bodyPart != _part) then {
        _bandaged pushBack _x;
    };

} forEach _bandagedWounds;

{
    _x params ["_id", "_bodyPart", "_amount"];

    if (_bodyPart != _part) then {
        _stitched pushBack _x;
    };

} forEach _stitchedWounds;

_patient setVariable [VAR_BANDAGED_WOUNDS, _bandaged, true];
_patient setVariable [VAR_STITCHED_WOUNDS, _stitched, true];

_debridement set [_part, 0];
_patient setVariable [QGVAR(debridement), _debridement, true];

{
    _x params ["_id", "_bodyPart", "_amount"];

    if (_bodyPart == _part && _amount > 0) exitWith {
        _remainder = true;
    };

} forEach _openWounds;

if !(_remainder) then {
    _damage set [_part, 0];
    _patient setVariable [QACEGVAR(medical,bodyPartDamage), _damage, true];

    {
        _x params ["_id", "_bodyPart", "_amount"];

        if (_bodyPart != _part && _amount > 0) then {
            _open pushBack _x;
        };

    } forEach _openWounds;

    _patient setVariable [VAR_OPEN_WOUNDS, _open, true];
};

switch (_part) do {
    case 0: {
        [_patient, true, false, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals);
    };
    case 1: {
        [_patient, false, true, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals);
    };
    case 2;
    case 3: {
        [_patient, false, false, true, false] call ACEFUNC(medical_engine,updateBodyPartVisuals);
    };
    default {
        [_patient, false, false, false, true] call ACEFUNC(medical_engine,updateBodyPartVisuals);
    };
};

[_patient] call ACEFUNC(medical_engine,updateDamageEffects);
[_patient] call ACEFUNC(medical_engine,updateWoundBleedLoss);