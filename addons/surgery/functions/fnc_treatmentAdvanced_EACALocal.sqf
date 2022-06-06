#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Begins TXA bandaging process
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Medication <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "TXA"] call aceP_circulation_fnc_treatmentAdvanced_TXALocal;
 *
 * Public: No
 */

params ["_target", "_item", "_medic"];

private _IVsite = _target getVariable [QGVAR(IVsite), 0, false];

if (_IVsite > 1) then {
    private _randomNumber = random 100;
    private _flush = _target getVariable [QGVAR(IVflush), false];
    private _block = _target getVariable [QGVAR(IVblock), false];

    if !(_flush) then {
        if (_randomNumber < GVAR(blockChance)) then {
            _block = true;
            _target setVariable [QGVAR(IVblock), true, true];
        };
    };

    if (_block) exitWith {};

    _target setVariable [QGVAR(IVflush), false, false];
};

[{
    params ["_args", "_idPFH"];
    _args params ["_target"];

    private _stitchableWounds = _target call ace_medical_treatment_fnc_getStitchableWounds;
    private _alive = alive _target;

    if ((!_alive) || (_stitchableWounds isEqualTo [])) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _random = random 750;
    private _ph = (_target getVariable [QGVAR(ph), 1500]) - 750;

    if (_random <= _ph) then {
        private _bandagedWounds = GET_BANDAGED_WOUNDS(_target);
        private _stitchedWounds = GET_STITCHED_WOUNDS(_target);

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

        _target setVariable [VAR_BANDAGED_WOUNDS, _bandagedWounds, true];
        _target setVariable [VAR_STITCHED_WOUNDS, _stitchedWounds, true];
    };

}, 6, [_target]] call CBA_fnc_addPerFrameHandler;

true
