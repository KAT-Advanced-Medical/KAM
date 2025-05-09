#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Lorazepam
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_LorazepamOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
systemChat str "LorazepamOverdose";
private _bpAdjust = -30 + floor random ((-15 - -30) + 1);
[_patient, _bpAdjust, _bpAdjust, "LorazepamOverdose"] call kat_circulation_fnc_updateBloodPressureChange;
private _hrAdjust = -50 + floor random ((-30 - -50) + 1);
[_patient, "LorazepamOverdose", 120, 1200, _hrAdjust] call EFUNC(vitals,addMedicationAdjustment);
[{
    params ["_patient"];
    private _LorazepamOverdoseTarget = 0;
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_LorazepamOverdoseTarget"];
            _LorazepamOverdoseTarget = _LorazepamOverdoseTarget + 1;
            _args set [1, _LorazepamOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_LorazepamOverdoseTarget > 12) exitWith {
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
                private _depression = _unit getVariable [QEGVAR(pharma,opioidDepressionFactor)] + 0.08;
                _patient setVariable [QEGVAR(pharma,opioidDepressionFactor), _depression];
        }, 15, [_patient,0]] call CBA_fnc_addPerFrameHandler;
}, [_patient], 15] call CBA_fnc_waitAndExecute;


if QEGVAR(feedback,effectOverdose) then
    {
    PP_wetD = ppEffectCreate ["WetDistortion",300];
    PP_wetD ppEffectEnable true;
    PP_wetD ppEffectAdjust [10,0.2,0.2,1.84,1.46,0.33,0.86,0.05,0.05,0.05,0.05,0.1,0.1,0.2,0.2];
    PP_wetD ppEffectCommit 0;
    [{PP_wetD ppEffectEnable false; PP_wetD ppEffectCommit 0;}, [], 600] call CBA_fnc_waitAndExecute;};
