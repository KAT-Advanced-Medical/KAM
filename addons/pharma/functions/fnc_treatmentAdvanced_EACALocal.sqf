#include "..\script_component.hpp"
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

params ["_patient", "_bodyPart"];

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

    private _alive = alive _patient;
    private _exit = true;

    private _random = random 750;
    private _ph = (_patient getVariable [QGVAR(pH), 1500]) - 750;

    if (_random <= _ph) then {
        {
            _x params ["_targetBodyPart"];

            private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
            private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_targetBodyPart, []];

            if (_bandagedWoundsOnPart isEqualTo [] || [_patient,_x] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo)) then {
                continue;
            };

            private _index = _bandagedWoundsOnPart findIf {!((_x select 0) in [20,21,22])};

            if (_index != -1) exitWith {
                (_bandagedWoundsOnPart select _index) params ["_classID", "_amountOf", "", "_damageOf"];

                private _treatedWound = [_classID, _amountOf, 0, _damageOf];

                private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);
                private _stitchedWoundsOnPart = _stitchedWounds getOrDefault [_targetBodyPart, []];

                private _woundIndex = _stitchedWoundsOnPart findIf {(_x select 0) isEqualTo _classID};

                if (_woundIndex == -1) then {
                    _stitchedWoundsOnPart pushBack _treatedWound;
                } else {
                    private _wound = _stitchedWoundsOnPart select _woundIndex;
                    _stitchedWoundsOnPart set [_woundIndex,[(_wound select 1) + _amountOf, _wound select 2, _wound select 3]];
                };
                _stitchedWounds set [_targetBodyPart, _stitchedWoundsOnPart];
                _patient setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];

                _bandagedWoundsOnPart deleteAt _index;
                _bandagedWounds set [_targetBodyPart, _bandagedWoundsOnPart];

                _patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
                
                private _partIndex = ALL_BODY_PARTS find _targetBodyPart;
                private _bodyPartDamage = _patient getVariable [QACEGVAR(medical,bodyPartDamage), []];
                private _damage = (_bodyPartDamage select _partIndex) - (_damageOf * _amountOf);
                if (_damage < 0.05) then {
                    _bodyPartDamage set [_partIndex, 0];
                } else {
                    _bodyPartDamage set [_partIndex, _damage];
                };
                _patient setVariable [QACEGVAR(medical,bodyPartDamage), _bodyPartDamage, true];

                _exit = false;
            };
        } forEach ALL_BODY_PARTS_PRIORITY;
    };

    if (!(_alive) || (_exit)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

}, 5, [_patient]] call CBA_fnc_addPerFrameHandler;
