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
 * [player, "TXA"] call kat_pharma_fnc_treatmentAdvanced_TXALocal;
 *
 * Public: No
 */

params ["_target", "_item", "_medic"];

private _IVsite = _target getVariable [QGVAR(IVsite), 0];

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
    private _target = _this select 0;
    _target setVariable [QGVAR(TXA), 1, true];
}, [_target], 180] call CBA_fnc_waitAndExecute;

[{
    params ["_args", "_idPFH"];
    _args params ["_target"];

    private _openWounds = _target getVariable [VAR_OPEN_WOUNDS, []];
    private _alive = alive _target;

    if ((!_alive) || (_openWounds isEqualTo [])) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

    private _random = random 1000;
    private _ph = (_target getVariable [QGVAR(ph), 1500]) - 500;

    if (_random <= _ph) then {
        {
            _x params ["_id", "_bodyPart", "_amount"];

            if ((_id != 20) && (_amount > 0)) exitWith {
                private _part = ALL_BODY_PARTS select _bodyPart;
                ["ace_medical_treatment_bandageLocal", [_target, _part, "PackingBandage"], _target] call CBA_fnc_targetEvent;
            };

        } forEach _openWounds;
    };

}, 6, [_target]] call CBA_fnc_addPerFrameHandler;

true