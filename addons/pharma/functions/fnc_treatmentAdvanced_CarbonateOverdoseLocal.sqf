#include "..\script_component.hpp"
/*
 * Author: Mazinski.H, Blue
 * Checks for Carbonate Wakeup values to restore consciousness
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *`
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_CarbonateLocal;
 *
 * Public: No
 */
params ["_patient"];
[{
    params ["_patient"];
    private _CarbonateOverdoseTarget = 0;
        [{
            params ["_patient", "_idPFH"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _CarbonateOverdoseTarget = _CarbonateOverdoseTarget + 1;
                if (_CarbonateOverdoseTarget > 18) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _hr = _patient getVariable [VAR_HEART_RATE, 80];
                private _hrAdd = (_hr + 1);
                _patient setVariable [VAR_HEART_RATE, _hrAdd, true];
        }, 10, [_patient]] call CBA_fnc_addPerFrameHandler;
}, _patient, 10] call CBA_fnc_waitAndExecute;
[{
    params ["_patient"];
    private _CarbonateOverdoseTarget = 0;
        [{
            params ["_patient", "_idPFH"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _CarbonateOverdoseTarget = _CarbonateOverdoseTarget + 1;
                if (_CarbonateOverdoseTarget > 18) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _hr = _patient getVariable [VAR_HEART_RATE, 80];
                private _hrAdd = (_hr - 2);
                _patient setVariable [VAR_HEART_RATE, _hrAdd, true];
        }, 10, [_patient]] call CBA_fnc_addPerFrameHandler;
}, _patient, 150] call CBA_fnc_waitAndExecute;

