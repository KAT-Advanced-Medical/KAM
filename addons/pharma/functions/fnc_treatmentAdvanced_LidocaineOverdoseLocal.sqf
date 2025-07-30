#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Lidocaine
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_LidocaineOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
private _hrAdjust = -40 + floor random ((-40 - -40) + 1);
[_patient, "LidocaineOD", 30, 1200, _hrAdjust, 0, 0, 0, 0.2] call EFUNC(vitals,addMedicationAdjustment);
[{
    params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_lidocaineOverdoseTarget"];
            _lidocaineOverdoseTarget = _lidocaineOverdoseTarget + 1;
            _args set [1, _lidocaineOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_lidocaineOverdoseTarget > 12) exitWith {
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
                private _medications = _patient getVariable [QACEGVAR(medical,medications), []];
                private _depression = _unit getVariable [QEGVAR(pharma,opioidDepression)] + 0.08;
                _patient setVariable [QEGVAR(pharma,opioidDepression), _depression];
        }, 30, [_patient,0]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 30] call CBA_fnc_waitAndExecute;
