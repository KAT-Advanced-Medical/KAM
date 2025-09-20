#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Morphine
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_MorphineOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
private _hrAdjust = -50 + floor random ((-30 - -50) + 1);
[_patient, "morphineOverdose", 30, 1200, _hrAdjust, 0, 0, 0, 0.3, 0, 0, 0.17, -0.3] call EFUNC(vitals,addMedicationAdjustment);
[{
    params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_morphineOverdoseTarget"];
            _morphineOverdoseTarget = _morphineOverdoseTarget + 1;
            _args set [1, _morphineOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                _morphineOverdoseTarget = _morphineOverdoseTarget + 1;
                if (_morphineOverdoseTarget > 6) exitWith {
                    [{
                        params ["_args", "_idPFH"];
                        _args params ["_patient"];
                        private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
                        if ((_ht findIf {_x isEqualTo "opioidOD"}) == -1) then {
                            _ht pushBack "opioidOD";
                            if (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                                [QACEGVAR(medical,FatalVitals), _patient] call CBA_fnc_localEvent;
                            };
                            _patient setVariable [QEGVAR(circulation,ht), _ht, true];
                            };
                    }, [_patient], 10] call CBA_fnc_waitAndExecute;
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _medications = _patient getVariable [QACEGVAR(medical,medications), []];
                if (_medications findIf {_x isEqualTo "naloxone"} != -1) exitWith {};
                private _depression = _patient getVariable [QEGVAR(pharma,opioidDepression)] + 0.08;
                _patient setVariable [QEGVAR(pharma,opioidDepression), _depression, true];
                
        }, 10, [_patient,0]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 10] call CBA_fnc_waitAndExecute;
