#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks for Carbonate Wakeup values to restore consciousness
 *
 * Arguments:
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *`
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_CarbonateOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
systemChat str "CarbonateODLocal";
[{
    params ["_patient"];
    private _CarbonateOverdoseTarget = 0;
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_CarbonateOverdoseTarget"];
            _CarbonateOverdoseTarget = _CarbonateOverdoseTarget + 1;
            _args set [1, _CarbonateOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_CarbonateOverdoseTarget > 18) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _hr = _patient getVariable [VAR_HEART_RATE, 80];
                private _hrAdd = (_hr + 1);
                _patient setVariable [VAR_HEART_RATE, _hrAdd, true];
        }, 10, [_patient,0]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 10] call CBA_fnc_waitAndExecute;
[{
    params ["_patient"];
    private _CarbonateOverdoseTarget = 0;
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_CarbonateOverdoseTarget"];
            _CarbonateOverdoseTarget = _CarbonateOverdoseTarget + 1;
            _args set [1, _CarbonateOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_CarbonateOverdoseTarget > 18) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _hr = _patient getVariable [VAR_HEART_RATE, 80];
                private _hrAdd = (_hr - 2);
                _patient setVariable [VAR_HEART_RATE, _hrAdd, true];
        }, 10, [_patient,0]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 150] call CBA_fnc_waitAndExecute;
