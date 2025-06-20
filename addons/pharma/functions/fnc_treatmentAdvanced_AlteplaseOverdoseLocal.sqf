#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Alteplase
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_pharma_fnc_treatmentAdvanced_AlteplaseOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
private _hrAdjust = 10 + floor random ((25 - 10) + 1);
[_patient, "AlteplaseOverdose", 30, 600, _hrAdjust, 0, 0, 0.2] call EFUNC(vitals,addMedicationAdjustment);
[{
    params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_AlteplaseTarget"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _AlteplaseTarget = _AlteplaseTarget + 1;
                _args set [1, _AlteplaseTarget];
                if (_AlteplaseTarget > 12) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;};
                private _bloodlevels = GET_BODY_FLUID(_patient);
                _bloodlevels set [0, (_bloodlevels select 0) - 50];
                _patient setVariable [QEGVAR(circulation,bodyFluid), _bloodlevels, true];
                private _coagulationFactor = (_patient getVariable [QGVAR(coagulationFactor), 30]);
                private _factorstoremove = 1;
                _patient setVariable [QGVAR(coagulationFactor), (_coagulationFactor - _factorstoremove), true];
        }, 15, [_patient, 0]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 15] call CBA_fnc_waitAndExecute;
