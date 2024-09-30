#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_hypothermia_fnc_init;
 *
 * Public: No
 */

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};

[_unit] call FUNC(fullHealLocal);

if (GVAR(hypothermiaActive)) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_unit"];

        private _alive = alive _unit;

        if (!_alive) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        private _handWarmers = _unit getVariable [QGVAR(handWarmers), [0,0,0,0,0,0]];

        {
            _x params ["_timeRemaining"];

            if (_x > 0) exitWith {
                _handWarmers set [_forEachIndex, _timeRemaining - 1];
            };

            _handWarmers set [_forEachIndex, 0];
        } forEach (_handWarmers);

        _unit setVariable [QGVAR(handWarmers), _handWarmers, true];

        if (GET_BLOOD_VOLUME_LITERS(_unit) > 4) then {
            private _impact = (_unit getVariable [QGVAR(warmingImpact), 0]);
            [(_impact - 100) max 0, (_impact + 200) min 0] select (_impact < 0);
            _unit setVariable [QGVAR(warmingImpact), _impact, true];
        };

    }, 60, [_unit]] call CBA_fnc_addPerFrameHandler;
};