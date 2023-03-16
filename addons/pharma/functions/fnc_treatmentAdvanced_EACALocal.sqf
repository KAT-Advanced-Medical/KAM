#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Local function for EACA treatment
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_patient, "LeftArm"] call kat_pharma_fnc_treatmentAdvanced_EACALocal;
 *
 * Public: No
 */

params ["_patient","_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;
private _block = false;

if (_IVactual > 1) then {
    private _randomNumber = random 100;

    if (_IVactual != 4) exitWith {
        if (_randomNumber < GVAR(blockChance)) then {
            _IVarray set [_partIndex, 3];
            _patient setVariable [QGVAR(IV), _IVarray, true];
            _block = true;
        };
    };

    _IVarray set [_partIndex, 2];
    _patient setVariable [QGVAR(IV), _IVarray, true];
};

[{
    params ["_args", "_idPFH"];
    _args params ["_patient"];

    private _stitchableWounds = _patient call ACEFUNC(medical_treatment,getStitchableWounds);
    private _alive = alive _patient;

    if ((!_alive) || (_stitchableWounds isEqualTo [])) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _random = random 750;
    private _ph = (_patient getVariable [QGVAR(pH), 1500]) - 750;

    if (_random <= _ph) then {
        private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
        private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);

        private _treatedWound = _bandagedWounds deleteAt (_bandagedWounds find (_stitchableWounds select 0));
        _treatedWound params ["_treatedID", "_treatedBodyPartN", "_treatedAmountOf"];

        private _woundIndex = _stitchedWounds findIf {
            _x params ["_classID", "_bodyPartN"];

            _classID == _treatedID && {_bodyPartN == _treatedBodyPartN}
        };

        if (_woundIndex == -1) then {
            _stitchedWounds pushBack _treatedWound;
        } else {
            private _wound = _stitchedWounds select _woundIndex;
            _wound set [2, (_wound select 2) + _treatedAmountOf];
        };

        _patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
        _patient setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];
    };

}, 6, [_patient]] call CBA_fnc_addPerFrameHandler;
