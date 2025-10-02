#include "..\script_component.hpp"
/*
 * Author: Mazinski.H
 * Locates and Removes Bradycardia Effect.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, syringe_atropine_5ml_2] call kat_pharma_fnc_treatmentAdvanced_AtropineOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
[{
    params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_atropineOverdoseTarget"];
            _atropineOverdoseTarget = _atropineOverdoseTarget + 1;
            _args set [1, _atropineOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_atropineOverdoseTarget > 12) exitWith {
                    if (random(100) < 15) then {
                    [{
                        params ["_patient"];
                        if (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                                [QACEGVAR(medical,FatalVitals), _patient] call CBA_fnc_localEvent;
                        };
                    }, [_patient], 15] call CBA_fnc_waitAndExecute;
                    };
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _depression = (_patient getVariable [QEGVAR(pharma,opioidDepression), 0]) + 0.05;
                _patient setVariable [QEGVAR(pharma,opioidDepression), _depression, true];
                private _rr = (_patient getVariable [QEGVAR(breathing,respiratoryRateMultiplier), 1]) - 0.07;
                _patient setVariable [QEGVAR(breathing,respiratoryRateMultiplier), _rr, true];
        }, 15, [_patient,0]] call CBA_fnc_addPerFrameHandler;
}, _patient, 15] call CBA_fnc_waitAndExecute;
[{
    params ["_args", "_idPFH"];
    _args params ["_patient"];
    if (!(alive _patient)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        private _medStack = [_patient, false] call ACEFUNC(medical_status,getAllMedicationCount);
        private _medIndex = _medStack find "Atropine";
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
            _args params ["_patient", "_atropineTarget"];
            _atropineTarget = _atropineTarget + 1;
            _args set [1, _atropineTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _atropineTarget = _atropineTarget + 1;
                if (_atropineTarget > 18) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _depression = (_patient getVariable [QEGVAR(pharma,opioidDepression), 0]) - 0.05;
                _patient setVariable [QEGVAR(pharma,opioidDepression), _depression, true];
                private _rr = (_patient getVariable [QEGVAR(breathing,respiratoryRateMultiplier), 1]) + 0.07;
                _patient setVariable [QEGVAR(breathing,respiratoryRateMultiplier), _rr, true];
        }, 10, [_patient,0]] call CBA_fnc_addPerFrameHandler;
    }, [_patient], 120] call CBA_fnc_waitAndExecute;
}, [_patient]] call CBA_fnc_waitUntilAndExecute;
