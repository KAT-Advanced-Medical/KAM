#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Begins CWMP Treatment
 *
 * Arguments:
 * 0: patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_CWMPOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
if GVAR(kidneyAction) then
    {[
        {
        params ["_patient"];
        [{
        params ["_args", "_idPFH"];
        _args params ["_patient", "_kidneyTarget"];
        _kidneyTarget = _kidneyTarget + 1;
        _args set [1, _kidneyTarget];
        if (!(alive _patient)) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _kidneyTarget = _kidneyTarget + 1;
                if (_kidneyTarget > 12) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;};
                private _ph = (_patient getVariable [QGVAR(externalPh), 0]) + 30;
                _patient setVariable [QGVAR(externalPh), _ph, true];
                }, 10, [_patient,0]] call CBA_fnc_addPerFrameHandler;
    }, _patient, 15] call CBA_fnc_waitAndExecute;
};
[{
    params ["_args", "_idPFH"];
    _args params ["_patient"];
    if (!(alive _patient)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        private _medStack = [_patient, false] call ACEFUNC(medical_status,getAllMedicationCount);
        private _medIndex = _medStack find "CWMP";
        private _hasMed = false;

        if (_medIndex > -1) then {
        private _medCount = _medStack select (_medIndex + 1);
        _hasMed = (_medCount > 0);
        if (_hasMed) then {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
    };
}, 5, [_patient]] call CBA_fnc_addPerFrameHandler;
[{_hasmed},{
    params ["_patient"];
    [_patient, "CWMPOverdose", 5, 360, 0, 0, 0, 0.1] call EFUNC(vitals,addMedicationAdjustment);
    [{
    params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_kidneyTarget"];
            _kidneyTarget = _kidneyTarget + 1;
            _args set [1, _kidneyTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _kidneyTarget = _kidneyTarget + 1;
                if (_kidneyTarget > 12) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;};
                private _bloodlevels = GET_BODY_FLUID(_patient);
                _bloodlevels set [5, ((_bloodlevels select 5) - 5) max 0];
                _patient setVariable [QEGVAR(circulation,bodyFluid), _bloodlevels, true];
        }, 15, [_patient,0]] call CBA_fnc_addPerFrameHandler;
    }, [_patient], 15] call CBA_fnc_waitAndExecute;
}, [_patient]] call CBA_fnc_waitUntilAndExecute;