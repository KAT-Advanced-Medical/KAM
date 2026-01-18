#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Handles the overdose effect of Lidocaine
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_LidocaineOverdoseLocal;
 *
 * Public: No
 */
params ["_patient", "_bodyPart", "_classname"];
private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
if (_classname in ["syringe_Lidocaine_10ml_10", "syringe_Lidocaine_5ml_10"]) then {
    [{
    params ["_patient", "_partIndex"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_lidocaineTarget", "_partIndex"];
            _lidocaineTarget = _lidocaineTarget + 1;
            _args set [1, _lidocaineTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_lidocaineTarget > 20) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _anesthesiaArray = _patient getVariable [QEGVAR(pharma,localAnesthesia), [0,0,0,0,0,0,0,0,0,0,0,0]];
                private _localAnesthesia = _anesthesiaArray select _partIndex;
                private _localAnesthesia = (_localAnesthesia + 0.05) min 1;
                _anesthesiaArray set [_partIndex, _localAnesthesia];
                _patient setVariable [VAR_LOCAL_ANESTHESIA, _anesthesiaArray, true];
        }, 0.5, [_patient,0,_partIndex]] call CBA_fnc_addPerFrameHandler;
}, [_patient,_partIndex], 5] call CBA_fnc_waitAndExecute;

[{
    params ["_patient", "_partIndex"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_lidocaineTarget", "_partIndex"];
            _lidocaineTarget = _lidocaineTarget + 1;
            _args set [1, _lidocaineTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                if (_lidocaineTarget > 20) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
                private _anesthesiaArray = _patient getVariable [QEGVAR(pharma,localAnesthesia), [0,0,0,0,0,0,0,0,0,0,0,0]];
                private _localAnesthesia = _anesthesiaArray select _partIndex;
                private _localAnesthesia = (_localAnesthesia - 0.05) max 0;
                _anesthesiaArray set [_partIndex, _localAnesthesia];
                _patient setVariable [VAR_LOCAL_ANESTHESIA, _anesthesiaArray, true];
        }, 3, [_patient,0,_partIndex]] call CBA_fnc_addPerFrameHandler;
}, [_patient,_partIndex], 30] call CBA_fnc_waitAndExecute;

}
