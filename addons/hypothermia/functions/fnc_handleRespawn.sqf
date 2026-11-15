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
        private _activeWarmers = 0;

        {
            if (_x > 0) then {
                _handWarmers set [_forEachIndex, _x - 1];
                _activeWarmers = _activeWarmers + 1;
            } else {
                _handWarmers set [_forEachIndex, 0];
            };
        } forEach _handWarmers;

        _patient setVariable [QGVAR(handWarmers), _handWarmers, true];

        private _impact = _patient getVariable [QGVAR(warmingImpact), 0];

        if (GET_BLOOD_VOLUME_LITERS(_patient) > 4) then {
            _impact = [(_impact - 100) max 0, (_impact + 200) min 0] select (_impact < 0);
        };

        // Active hand warmers raise body temperature, but not above normal
        if (_activeWarmers > 0) then {
            private _deficit = ((DEFAULT_TEMPERATURE - (_patient getVariable [QGVAR(unitTemperature), DEFAULT_TEMPERATURE])) * ML_TO_LITERS) max 0;
            _impact = _impact + ((_activeWarmers * HAND_WARMER_HEAT) min _deficit);
        };

        _patient setVariable [QGVAR(warmingImpact), _impact, true];

    }, 60, [_patient]] call CBA_fnc_addPerFrameHandler;
};
