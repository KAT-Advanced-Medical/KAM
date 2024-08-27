#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Handles the player respawn for Hypothermia.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_hypothermia_fnc_handleRespawn
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

[_patient] call FUNC(fullHealLocal);

if (GVAR(hypothermiaActive)) then {
    [{
        params ["_args", "_idPFH"];
        _args params ["_patient"];

        private _alive = alive _patient;

        if (!_alive) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        private _handWarmers = _patient getVariable [QGVAR(handWarmers), [0,0,0,0,0,0]];

        {
            _x params ["_timeRemaining"];

            if (_x > 0) then {
                _handWarmers set [_forEachIndex, _timeRemaining - 1];
            };
        } forEach (_handWarmers);

        _patient setVariable [QGVAR(handWarmers), _handWarmers, true];

        if (GET_BLOOD_VOLUME_LITERS(_patient) > 4) then {
            private _impact = (_patient getVariable [QGVAR(warmingImpact), 0]);
            [(_impact - 100) max 0, (_impact + 200) min 0] select (_impact < 0);
            _patient setVariable [QGVAR(warmingImpact), _impact, true];
        };

    }, 60, [_patient]] call CBA_fnc_addPerFrameHandler;
};