#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Ketamine
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_KetamineOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
[{
    params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_KetamineOverdoseTarget"];
            _KetamineOverdoseTarget = _KetamineOverdoseTarget + 1;
            _args set [1, _KetamineOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _KetamineOverdoseTarget =  + 1;
                if (_KetamineOverdoseTarget > 12) exitWith {
                    if (random(100) < 25) then {
                    [{
                        params ["_args", "_idPFH"];
                        _args params ["_patient"];
                        private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
                        if (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                                [QACEGVAR(medical,FatalVitals), _patient] call CBA_fnc_localEvent;
                        };
                    }, [_patient], 15] call CBA_fnc_waitAndExecute;
                    };
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _rr = _patient getVariable [QEGVAR(breathing,respiratoryRateMultiplier), 1] - 0.04;
                _patient setVariable [QEGVAR(breathing,respiratoryRateMultiplier), _rr];
                private _depression = _unit getVariable [QEGVAR(pharma,opioidDepressionFactor)] + 0.04;
                _patient setVariable [QEGVAR(pharma,opioidDepressionFactor), _depression];
        }, 15, [_patient,0]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 15] call CBA_fnc_waitAndExecute;