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

    private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
    private _alive = alive _patient;

    if ((!_alive) || (_bandagedWounds isEqualTo [])) exitWith {
        systemChat "Removing PFH";
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _random = random 750;
    private _ph = (_patient getVariable [QGVAR(pH), 1500]) - 750;

    if (_random <= _ph) then {
        {
            private _part = _x;
            {
                _x params ["_classID", "_amountOf", "", "_damageOf"];
                private _bandagedWoundsOnPart = _bandagedWounds get _part;
                private _treatedWound = _bandagedWoundsOnPart deleteAt (count _bandagedWoundsOnPart - 1);
                _treatedWound params ["_treatedID", "_treatedAmountOf", "", "_treatedDamageOf"];

                private _stitchedWounds = GET_STITCHED_WOUNDS(_patient);
                private _stitchedWoundsOnPart = _stitchedWounds getOrDefault [_part, [], true];

                private _woundIndex = _stitchedWoundsOnPart findIf {
                    _x params ["_classID"];
                    _classID == _treatedID
                };

                if (_woundIndex == -1) then {
                    _stitchedWoundsOnPart pushBack _treatedWound;
                } else {
                    private _wound = _stitchedWoundsOnPart select _woundIndex;
                    _wound set [1, (_wound select 1) + _treatedAmountOf];
                };

                _patient setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
                _patient setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];
            } forEach _y;
        } forEach _bandagedWounds;
    };

}, 6, [_patient]] call CBA_fnc_addPerFrameHandler;
