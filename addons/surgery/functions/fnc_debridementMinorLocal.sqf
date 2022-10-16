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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_debridementMinorLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _debridement = _patient getVariable [QGVAR(debridement), [0,0,0,0,0,0]];

if ((_debridement select _part) != 1) exitWith {
    private _output = localize LSTRING(debridement_fail);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

private _count1 = [_patient, "Lidocaine"] call ace_medical_status_fnc_getMedicationCount;
private _count2 = [_patient, "Morphine"] call ace_medical_status_fnc_getMedicationCount;
private _damage = _patient getVariable ["ace_medical_bodyPartDamage", [0,0,0,0,0,0]];

private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);
private _openWounds = GET_OPEN_WOUNDS(_patient);
private _bandaged = [];
private _stitched = [];

private _remainder = false;

if (_count1 == 0 && _count2 == 0) then {
    private _pain = random [0.7, 0.8, 0.9];
    [_patient, _pain] remoteExec ["ace_medical_fnc_adjustPainLevel", _patient];
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

    if (_bodyPart == _part) exitWith {
        _remainder = true;
    };

} forEach _openWounds;

if !(_remainder) then {
    _damage set [_part, 0];
    _patient setVariable ["ace_medical_bodyPartDamage", _damage, true];

    {
        _x params ["_id", "_bodyPart", "_amount"];

        if (_bodyPart != _part) then {
            _open pushBack _x;
        };

    } forEach _openWounds;

    _patient setVariable [VAR_OPEN_WOUNDS, _open, true];
};

[_patient] call ace_medical_engine_fnc_updateDamageEffects;
[_patient] call ace_medical_engine_fnc_updateWoundBleedLoss;
