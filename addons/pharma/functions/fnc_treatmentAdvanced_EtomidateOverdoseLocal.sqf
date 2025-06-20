#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Etomidate
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_EtomidateOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];

private _randomNumber = floor (random 3) + 1;
switch (_randomNumber) do {
    case 1: {
        [{
            private _bpAdjust = -20 + floor random ((-5 - -20) + 1);
            [_patient, _bpAdjust, _bpAdjust, "EtomidateOverdose"] call EFUNC(circulation,updateBloodPressureChange);        
        }, [_patient], 120] call CBA_fnc_waitAndExecute;
        private _hrAdjust = -40 + floor random ((-20 - -40) + 1);
        [_patient, "BRADYCARDIA", 120, 1200, _hrAdjust] call EFUNC(vitals,addMedicationAdjustment);
        [{
        params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_etomidateOverdoseTarget"];
            _etomidateOverdoseTarget = _etomidateOverdoseTarget + 1;
            _args set [1, _etomidateOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_etomidateOverdoseTarget > 12) exitWith {
                    if (random(100) < 25) then {
                    [{
                        params ["_args", "_idPFH"];
                        _args params ["_patient"];
                        private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
                        if ((_ht findIf {_x isEqualTo "EtomidateOD"}) == -1) then {
                            _ht pushBack "EtomidateOD";

                            if (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                                [QACEGVAR(medical,FatalVitals), _patient] call CBA_fnc_localEvent;
                            };

                            _patient setVariable [QEGVAR(circulation,ht), _ht, true];
                            };
                    }, [_patient], 15] call CBA_fnc_waitAndExecute;
                    };
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _depression = _unit getVariable [QEGVAR(pharma,opioidDepressionFactor)] + 0.08;
                _patient setVariable [QEGVAR(pharma,opioidDepressionFactor), _depression];
                }, 30, [_patient,0]] call CBA_fnc_addPerFrameHandler;
        }, [_patient], 30] call CBA_fnc_waitAndExecute;
    };
    case 2: {
        [{
            private _bpAdjust = -20 + floor random ((-5 - -20) + 1);
            [_patient, _bpAdjust, _bpAdjust, "EtomidateOverdose"] call EFUNC(circulation,updateBloodPressureChange);        
        }, [_patient], 120] call CBA_fnc_waitAndExecute;
        private _hrAdjust = 20 + floor random ((40 - 20) + 1);
        [_patient, "TACHYCARDIA", 120, 1200, _hrAdjust] call EFUNC(vitals,addMedicationAdjustment);
        [{
        params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_etomidateOverdoseTarget"];
            _etomidateOverdoseTarget = _etomidateOverdoseTarget + 1;
            _args set [1, _etomidateOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_etomidateOverdoseTarget > 12) exitWith {
                    if (random(100) < 25) then {
                    [{
                        params ["_args", "_idPFH"];
                        _args params ["_patient"];
                        private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
                        if ((_ht findIf {_x isEqualTo "EtomidateOD"}) == -1) then {
                            _ht pushBack "EtomidateOD";

                            if (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] == 0) then {
                                [QACEGVAR(medical,FatalVitals), _patient] call CBA_fnc_localEvent;
                            };

                            _patient setVariable [QEGVAR(circulation,ht), _ht, true];
                            };
                    }, [_patient], 15] call CBA_fnc_waitAndExecute;
                    };
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _depression = _unit getVariable [QEGVAR(pharma,opioidDepressionFactor)] + 0.08;
                _patient setVariable [QEGVAR(pharma,opioidDepressionFactor), _depression];
                }, 30, [_patient,0]] call CBA_fnc_addPerFrameHandler;
        }, [_patient], 30] call CBA_fnc_waitAndExecute;
    };
    case 3: {
        [{
            private _bpAdjust = -20 + floor random ((-5 - -20) + 1);
            [_patient, _bpAdjust, _bpAdjust, "EtomidateOverdose"] call EFUNC(circulation,updateBloodPressureChange);        
        }, [_patient], 120] call CBA_fnc_waitAndExecute;
        private _hrAdjust = 20 + floor random ((40 - 20) + 1);
        [_patient, "TACHYCARDIA", 120, 1200, _hrAdjust] call EFUNC(vitals,addMedicationAdjustment);
        [{
        params ["_patient"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_etomidateOverdoseTarget"];
            _etomidateOverdoseTarget = _etomidateOverdoseTarget + 1;
            _args set [1, _etomidateOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_etomidateOverdoseTarget > 12) exitWith {
                    if (random(100) < 15) then {
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
                private _rr = _patient getVariable [QEGVAR(breathing,respiratoryRateMultiplier), 1] - 0.06;
                _patient setVariable [QEGVAR(breathing,respiratoryRateMultiplier), _rr];
                }, 30, [_patient,0]] call CBA_fnc_addPerFrameHandler;
        }, [_patient], 30] call CBA_fnc_waitAndExecute;
    };
    case 4: {
        [{
            private _bpAdjust = -20 + floor random ((-5 - -20) + 1);
            [_patient, _bpAdjust, _bpAdjust, "EtomidateOverdose"] call EFUNC(circulation,updateBloodPressureChange);        
        }, [_patient], 120] call CBA_fnc_waitAndExecute;
        private _hrAdjust = -40 + floor random ((-20 - -40) + 1);
        [_patient, "BRADYCARDIA", 120, 1200, _hrAdjust] call EFUNC(vitals,addMedicationAdjustment);
        [{
        params ["_patient"];

        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_etomidateOverdoseTarget"];
            _etomidateOverdoseTarget = _etomidateOverdoseTarget + 1;
            _args set [1, _etomidateOverdoseTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_etomidateOverdoseTarget > 12) exitWith {
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
                private _depression = _unit getVariable [QEGVAR(pharma,opioidDepressionFactor)] + 0.08;
                _patient setVariable [QEGVAR(pharma,opioidDepressionFactor), _depression];
                private _rr = _patient getVariable [QEGVAR(breathing,respiratoryRateMultiplier), 1] - 0.06;
                _patient setVariable [QEGVAR(breathing,respiratoryRateMultiplier), _rr];
                }, 30, [_patient,0]] call CBA_fnc_addPerFrameHandler;
        }, [_patient], 30] call CBA_fnc_waitAndExecute;
    };
};
if QEGVAR(feedback,effectOverdose) then
    {
    PP_wetD = ppEffectCreate ["WetDistortion",300];
    PP_wetD ppEffectEnable true;
    PP_wetD ppEffectAdjust [9.7,0.2,-0.1,1.84,1.46,0.33,0.86,0.05,0.05,0.05,0.05,0.1,0.1,0.2,0.2];
    PP_wetD ppEffectCommit 0;
    // Date YYYY-MM-DD-HH-MM: [2035,6,24,8,0]. Overcast: 0.3. Fog: 0.0823474. Fog params: [0.0800016,0.013,0] 
    // GF PostProcess Editor parameters: Copy the following line to clipboard and click Import in the editor.
    //[[false,100,[0.2,0.2,0.26,0.3]],[false,200,[0.05,0.05,true]],[true,300,[9.7,0.2,-0.1,1.84,1.46,0.33,0.86,0.05,0.05,0.05,0.05,0.1,0.1,0.2,0.2]],[false,1500,[1,1,0,[2,2,2,-0.1],[5,5,5,1],[4,0.33,0.33,0],[0.66,0,0.96,0,0,0,4]]],[false,500,[2.06]],[false,2000,[0.44,1,1,0.5,0.5,true]],[false,2500,[1,1,1]]]
    [{PP_wetD ppEffectEnable false; PP_wetD ppEffectCommit 0;}, [], 600] call CBA_fnc_waitAndExecute;};