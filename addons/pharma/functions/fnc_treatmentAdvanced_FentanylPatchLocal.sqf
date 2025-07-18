#include "..\script_component.hpp"
/*
 * Author: Miss Heda
 * Modified: Mazinski
 * Triggers the fentanyl visual effect and applies the opioid factor from Fentanyl.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "LeftLeg", 1] call kat_pharma_fnc_treatmentAdvanced_FentanylLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];
private _partIndex = ALL_BODY_PARTS find _bodyPart;
private _fentPatch = _patient getVariable [VAR_FENT_PATCH, [0,0,0,0,0,0,0,0,0,0,0,0]];
[_patient, "FentanylPatch", 0, 15, 0, 0.5] call EFUNC(vitals,addMedicationAdjustment);
_fentPatch set [_partIndex, 1];
_patient setVariable [VAR_FENT_PATCH, _fentPatch, true];
[{
    params ["_patient", "_partIndex"];
        [{
            params ["_args", "_idPFH"];
            _args params ["_patient", "_partIndex"];
            if (!(alive _patient) || !(HAS_FENT_PATCH(_patient,_partIndex))) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
            [_patient, "FentanylPatch", 0, 15, 0, 0.5] call EFUNC(vitals,addMedicationAdjustment);
            private _fentPatch = _patient getVariable [VAR_FENT_PATCH, [0,0,0,0,0,0,0,0,0,0,0,0]];
            private _fentPatchIndex = _fentPatch select _partIndex;
            _fentPatch set [_partIndex, ((_fentPatchIndex - (0.01 * random [0.8, 1, 1.2])) max 0)];
            _patient setVariable [VAR_FENT_PATCH, _fentPatch, true];
            private _painAdjust = 0.9 * linearConversion [0.6, 0.1, _fentPatchIndex, 1, 0.1, true];
            [_patient, "Fentanyl", 1, 20, 0, _painAdjust, 0, 0.5] call EFUNC(vitals,addMedicationAdjustment);
        }, 10, [_patient,_partIndex]] call CBA_fnc_addPerFrameHandler;
}, [_patient, _partIndex], 20] call CBA_fnc_waitAndExecute;