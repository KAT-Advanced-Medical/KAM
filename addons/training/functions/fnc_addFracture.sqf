#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Fractures a limb of a patient and sets the fracture grade used by KAM surgery.
 * Has to run where the patient is local.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body part ("leftarm", "rightarm", "leftleg", "rightleg") <STRING>
 * 2: Grade, 1 (simple), 2 (compound) or 3 (comminuted) <NUMBER> (default: 1)
 *
 * Return Value:
 * Fracture added <BOOL>
 *
 * Example:
 * [cursorObject, "leftleg", 3] call kat_training_fnc_addFracture
 *
 * Public: No
 */

#define FIRST_LIMB_INDEX 2
#define FRACTURE_PAIN_PER_GRADE 0.2

params [["_patient", objNull, [objNull]], ["_bodyPart", "", [""]], ["_grade", 1, [0]]];

private _partIndex = ALL_BODY_PARTS find toLowerANSI _bodyPart;

if (_partIndex < FIRST_LIMB_INDEX) exitWith {false};

_grade = (round _grade max 1) min 3;

private _fractures = +GET_FRACTURES(_patient);
_fractures set [_partIndex, 1];
_patient setVariable [VAR_FRACTURES, _fractures, true];

private _fractureGrades = +(_patient getVariable [QEGVAR(surgery,fractures), [0,0,0,0,0,0]]);
_fractureGrades set [_partIndex, _grade];
_patient setVariable [QEGVAR(surgery,fractures), _fractureGrades, true];

[_patient, FRACTURE_PAIN_PER_GRADE * _grade] call ACEFUNC(medical_status,adjustPainLevel);

[QACEGVAR(medical,fracture), [_patient, _partIndex]] call CBA_fnc_localEvent;
[_patient] call ACEFUNC(medical_engine,updateDamageEffects);

true
