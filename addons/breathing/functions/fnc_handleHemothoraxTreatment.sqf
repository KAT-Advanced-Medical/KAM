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
 * [player, 15] call kat_breathing_fnc_handlePneumothoraxTreatment;
 *
 * Public: No
 */

params ["_unit", "_chanceIncrease", "_side"];

[{
    params ["_unit", "_chanceIncrease", "_side"];

    private _pneumothoraxState = _unit getVariable [QGVAR(pneumothorax), [0, 0]]; // Default: [0, 0] for both sides

    if ((_pneumothoraxState select _side > 0)) then {
        // Try to deteriorate at set interval
        [{

            params ["_args", "_idPFH"];
            _args params ["_unit", "_side"];
            private _hemoState = _unit getVariable [QGVAR(hemopneumothorax), [0, 0]];
            // If patient is dead, treated, or already deteriorated to advanced pneumothorax, kill the PFH
            if (!(alive _unit) || (_hemoState select _side == 0)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
            _hemoState set [_side, ((_hemoState select _side) - (0.1 * GVAR(ChestTubeDrainAmount)))];
            _unit setVariable [QGVAR(hemopneumothorax), _hemoState, true];
        }, GVAR(chestTubeDrainTime), [_unit, _side]] call CBA_fnc_addPerFrameHandler;
    };
}, [_unit, _chanceIncrease, _side], GVAR(chestTubeDrainTime)] call CBA_fnc_waitAndExecute;