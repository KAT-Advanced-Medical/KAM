#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of EACA
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_patient] call kat_pharma_fnc_treatmentAdvanced_EACAOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];

[_patient, "EACAOverdose", 1, 900, 0, 0, -0.5] call EFUNC(vitals,addMedicationAdjustment);
[{
    params ["_patient"];
    [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_EACAOverdoseTarget"];
            _EACAOverdoseTarget = _EACAOverdoseTarget + 1;
            _args set [1, _EACAOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

                _EACAOverdoseTarget = _EACAOverdoseTarget + 1;
                if (_EACAOverdoseTarget > 12) exitWith {
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
                if (_surface > 150) then {
                    private _surfaceArea = _surface - 10;
                    _patient setVariable [QEGVAR(breathing,lungSurfaceArea), _surfaceArea];
                    };
                private _coagulationFactor = (_patient getVariable [QGVAR(coagulationFactor), 30]);
                private _factorstoremove = 1;
                _patient setVariable [QGVAR(coagulationFactor), (_coagulationFactor - _factorstoremove), true];
                if ((random 10000) < 1) then {_patient setDamage 1;};
        }, 15, [_patient, 0]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 15] call CBA_fnc_waitAndExecute;