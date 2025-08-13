#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of TXA
 *
 * Arguments:
 * 0: Medic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_TXAOverdoseLocal;
 *
 * Public: No
 */

params ["_patient"];
[_patient, "TXAOverdose", 1, 900, 0, 0, -0.5] call EFUNC(vitals,addMedicationAdjustment);
[{
    params ["_patient"];
    private _TXAOverdoseTarget = 0;
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_TXAOverdoseTarget"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _TXAOverdoseTarget = _TXAOverdoseTarget + 1;
                if (_TXAOverdoseTarget > 12) exitWith {
                    if (random(100) < 25) then {
                    [{
                        params ["_args", "_idPFH"];
                        _args params ["_patient"];

                        if (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                            [QACEGVAR(medical,FatalVitals), _patient] call CBA_fnc_localEvent;
                        };
                    }, [_patient], 15] call CBA_fnc_waitAndExecute;
                    };
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _surface = (_patient getVariable [QEGVAR(breathing,lungSurfaceArea), 400]);
                if (_surface < 150) then {
                    } else {
                        private _surfaceArea = _surface - 10;
                        _patient setVariable [QEGVAR(breathing,lungSurfaceArea), _surfaceArea];
                    };
                private _bloodlevels = GET_BODY_FLUID(_patient);
                _bloodlevels set [5, (_bloodlevels select 5) - 20];
                _patient setVariable [QEGVAR(circulation,bodyFluid), _bloodlevels, true];
                if ((random 10000) < 1) then {_patient setDamage 1};
        }, 15, [_patient,_TXAOverdoseTarget]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 15] call CBA_fnc_waitAndExecute;
