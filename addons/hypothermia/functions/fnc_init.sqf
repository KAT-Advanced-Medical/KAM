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
        private _activeWarmers = 0;

        {
            if (_x > 0) then {
                _handWarmers set [_forEachIndex, _x - 1];
                _activeWarmers = _activeWarmers + 1;
            } else {
                _handWarmers set [_forEachIndex, 0];
            };
        } forEach _handWarmers;

        _unit setVariable [QGVAR(handWarmers), _handWarmers, true];

        private _impact = _unit getVariable [QGVAR(warmingImpact), 0];

        if (GET_BLOOD_VOLUME_LITERS(_unit) > 4) then {
            _impact = [(_impact - 100) max 0, (_impact + 200) min 0] select (_impact < 0);
        };

        // Active hand warmers raise body temperature, but not above normal
        if (_activeWarmers > 0) then {
            private _deficit = ((DEFAULT_TEMPERATURE - (_unit getVariable [QGVAR(unitTemperature), DEFAULT_TEMPERATURE])) * ML_TO_LITERS) max 0;
            _impact = _impact + ((_activeWarmers * HAND_WARMER_HEAT) min _deficit);
        };

        _unit setVariable [QGVAR(warmingImpact), _impact, true];

    }, 60, [_unit]] call CBA_fnc_addPerFrameHandler;
};
