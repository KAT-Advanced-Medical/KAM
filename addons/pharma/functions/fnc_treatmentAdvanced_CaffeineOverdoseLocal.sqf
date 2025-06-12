#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_CaffeineOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
[{
    params ["_patient"];
    private _CaffineOverdoseTarget = 0;
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_CaffineOverdoseTarget"];
            _CaffineOverdoseTarget = _CaffineOverdoseTarget + 1;
            _args set [1, _CaffineOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_CaffineOverdoseTarget > 12) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _hr = _patient getVariable [VAR_HEART_RATE, 80];
                private _hrAdd = (_hr + 3);
                _patient setVariable [VAR_HEART_RATE, _hrAdd, true];
        }, 10, [_patient,0]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 10] call CBA_fnc_waitAndExecute;
[{
    params ["_args", "_idPFH"];
    _args params ["_patient"];
    if (!(alive _patient)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        private _medStack = [_patient, false] call ACEFUNC(medical_treatment,getAllMedicationCount);
        private _medIndex = _medStack find "Caffine";
        private _hasMed = false;

        if (_medIndex > -1) then {
        private _medCount = _medStack select (_medIndex + 1);
        _hasMed = (_medCount > 0);
        if (_hasMed) then {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
    };
}, 5, [_patient]] call CBA_fnc_addPerFrameHandler;
[{_hasmed}, {
    params ["_patient"];
    [{
    params ["_patient"];
    private _CaffineOverdoseTarget = 0;
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_CaffineOverdoseTarget"];
            _CaffineOverdoseTarget = _CaffineOverdoseTarget + 1;
            _args set [1, _CaffineOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_CaffineOverdoseTarget > 12) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _hr = _patient getVariable [VAR_HEART_RATE, 80];
                private _hrAdd = (_hr - 3);
                _patient setVariable [VAR_HEART_RATE, _hrAdd, true];
        }, 10, [_patient,0]] call CBA_fnc_addPerFrameHandler;
    }, [_patient], 150] call CBA_fnc_waitAndExecute;
}, [_patient]] call CBA_fnc_waitUntilAndExecute;