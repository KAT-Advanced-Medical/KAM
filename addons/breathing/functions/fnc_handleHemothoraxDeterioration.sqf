#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle pneumothorax deterioration
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Deterioration chance increase <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 15] call kat_breathing_fnc_handlePneumothoraxDeterioration;
 *
 * Public: No
 */

params ["_unit", "_chanceIncrease", "_side"];

[{
    params ["_unit", "_side"];
    [{

        params ["_args", "_idPFH"];
        _args params ["_unit", "_side"];
        private _hemoState = _unit getVariable [QGVAR(hemopneumothorax), [0, 0]];
            if (!(alive _unit) ||
                ((INTERNAL_BLEEDING_RATE(_unit,2) == 0))) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
            private _internalBleeding = INTERNAL_BLEEDING_RATE(_unit,2);
            _hemoState set [_side, ((_hemoState select _side) + (_internalBleeding))];
            _unit setVariable [QGVAR(hemopneumothorax), _hemoState, true];
        }, GVAR(deterioratingHemothorax_interval), [_unit, _side]] call CBA_fnc_addPerFrameHandler;
}, [_unit, _side], GVAR(deterioratingHemothorax_interval)] call CBA_fnc_waitAndExecute;