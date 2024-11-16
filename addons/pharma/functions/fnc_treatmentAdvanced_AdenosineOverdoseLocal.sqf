#include "..\script_component.hpp"
/*
 * Author:Cplhardcore
 * Does the AV block effect of adenosine
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, "ACE_adenosine"] call kat_pharma_fnc_treatmentAdvanced_AmiodaroneLocal;
 *
 * Public: No
 */
params ["_patient"];
[{
    params ["_patient"];
    private _adenosineOverdoseTarget = 0;
        [{
            params ["_patient", "_idPFH"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _adenosineOverdoseTarget = _adenosineOverdoseTarget + 1;
                if (_adenosineOverdoseTarget > 12) exitWith {
                    if (random(100) < 15) then {
                    [{
                        params ["_args", "_idPFH"];
                        _args params ["_patient"];
                        private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
                        if ((_ht findIf {_x isEqualTo "adenosineOD"}) == -1) then {
                            _ht pushBack "adenosineOD";

                            if (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                                [QACEGVAR(medical,FatalVitals), _patient] call CBA_fnc_localEvent;
                            };

                            _patient setVariable [QEGVAR(circulation,ht), _ht, true];
                            };
                    }, [_patient], 15] call CBA_fnc_waitAndExecute;
                    };
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _surfaceArea = (_patient getVariable [QEGVAR(breathing,lungSurfaceArea), 400]) - 10;
                _patient setVariable [QEGVAR(breathing,lungSurfaceArea), _surfaceArea];
        }, 15, [_patient]] call CBA_fnc_addPerFrameHandler;
}, _patient, 15] call CBA_fnc_waitAndExecute;
[{
    params ["_patient"];
    private _AdenosineTarget = 0;
        [{
            params ["_patient", "_idPFH"];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _AdenosineTarget = _AdenosineTarget + 1;
                if (_AdenosineTarget > 18) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _surfaceArea = (_patient getVariable [QEGVAR(breathing,lungSurfaceArea), 400]) + 10;
                _patient setVariable [QEGVAR(breathing,lungSurfaceArea), _surfaceArea];
        }, 10, [_patient]] call CBA_fnc_addPerFrameHandler;
}, _patient, 300] call CBA_fnc_waitAndExecute;