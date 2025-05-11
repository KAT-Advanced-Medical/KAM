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
if (_className in ["syringe_lidocaine_5ml_1", "syringe_lidocaine_5ml_3"]) exitWith {};
[{
    params ["_patient", "_bodyPart"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_lidocaineTarget", "_bodyPart"];
            _lidocaineTarget = _lidocaineTarget + 1;
            _args set [1, _lidocaineTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
                _localAnesthesia = GET_LOCAL_ANESTHESIA(_patient,_partIndex);
                _localAnesthesia = _localAnesthesia + 0.2;
                _patient setVariable [VAR_VASOCONSTRICTION, _localAnesthesia, true]
                if (_lidocaineTarget > 5) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
        }, 5, [_patient,0,_bodyPart]] call CBA_fnc_addPerFrameHandler;
}, [_patient,_bodyPart], 5] call CBA_fnc_waitAndExecute;

[{
    params ["_patient", "_bodyPart"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_lidocaineTarget", "_bodyPart"];
            _lidocaineTarget = _lidocaineTarget + 1;
            _args set [1, _lidocaineTarget];
            if (!(alive _patient)) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
                private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
                _localAnesthesia = GET_LOCAL_ANESTHESIA(_patient,_partIndex);
                _localAnesthesia = _localAnesthesia - 0.5;
                _patient setVariable [VAR_VASOCONSTRICTION, _localAnesthesia, true]
                if (_lidocaineTarget > 20) exitWith {
                    [_idPFH] call CBA_fnc_removePerFrameHandler;
                };
        }, 3, [_patient,0,_bodyPart]] call CBA_fnc_addPerFrameHandler;
}, [_patient,_bodyPart], 60] call CBA_fnc_waitAndExecute;
