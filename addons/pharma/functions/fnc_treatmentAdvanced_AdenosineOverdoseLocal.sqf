#include "..\script_component.hpp"
/*
 * Author:Cplhardcore
 * Handles the overdose effect of Adenosine
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_pharma_fnc_treatmentAdvanced_AdenosineOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
systemChat str "AdenosineODLocal";
[{
    params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_adenosineOverdoseTarget"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _adenosineOverdoseTarget = _adenosineOverdoseTarget + 1;
                _args set [1, _adenosineOverdoseTarget];
                if (_adenosineOverdoseTarget > 12) exitWith {
                    if (random(100) < 15) then {
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
                private _surfaceArea = (_patient getVariable [QEGVAR(breathing,lungSurfaceArea), 400]) - 10;
                _patient setVariable [QEGVAR(breathing,lungSurfaceArea), _surfaceArea];
        }, 15, [_patient, 0]] call CBA_fnc_addPerFrameHandler;
}, _patient, 15] call CBA_fnc_waitAndExecute;
[{
    params ["_args", "_idPFH"];
    _args params ["_patient"];
    if (!(alive _patient)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        private _medStack = [_patient, false] call ACEFUNC(medical_treatment,getAllMedicationCount);
        private _medIndex = _medStack find "adenosine";
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
    [{
        params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_AdenosineTarget"];
            _AdenosineTarget = _AdenosineTarget + 1;
            _args set [1, _AdenosineTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _AdenosineTarget = _AdenosineTarget + 1;
                if (_AdenosineTarget > 18) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _surfaceArea = (_patient getVariable [QEGVAR(breathing,lungSurfaceArea), 400]) + 10;
                _patient setVariable [QEGVAR(breathing,lungSurfaceArea), _surfaceArea];
        }, 10, [_patient,0]] call CBA_fnc_addPerFrameHandler;
    }, [_patient], 10] call CBA_fnc_waitAndExecute;
}, [_patient]] call CBA_fnc_waitUntilAndExecute;
