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
[_patient, "CWMPOverdose", 30, 600, "", "", "", 0.3, "", ""] call EFUNC(vitals,addMedicationAdjustment);
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
                private _ph = _patient getVariable [QGVAR(externalPh), _ph, true] + 100;
                _patient setVariable [QGVAR(externalPh), _ph, true];
                }, 10, [_patient,0]] call CBA_fnc_addPerFrameHandler;
    }, _patient, 15] call CBA_fnc_waitAndExecute;
};
[{
    params ["_patient", "_idPFH"];
    if (!(alive _patient)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        private _medStack = [_patient, false] call ACEFUNC(medical_treatment,getAllMedicationCount);
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
[_hasmed, {}, {
    params ["_patient"];
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
                [_patient, -2, -2, "CWMPOverdose"] call EFUNC(circulation,updateBloodPressureChange);
                private _coagulationFactor = (_patient getVariable [QGVAR(coagulationFactor), 30]);
                private _factorstoremove = 1;
                _patient setVariable [QGVAR(coagulationFactor), (_coagulationFactor - _factorstoremove), true];
        }, 15, [_patient,0]] call CBA_fnc_addPerFrameHandler;
    }, [_patient], 15] call CBA_fnc_waitAndExecute;
}, [_patient]] call CBA_fnc_waitUntilAndExecute;