#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for fully healing a fracture.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_closedReductionLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _activeFracture = GET_FRACTURES(_patient);
private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0]];
private _lidocaineCount = [_patient, "Lidocaine", false] call ACEFUNC(medical_status,getMedicationCount);
private _lidocaineCount51 = [_patient, "syringe_kat_lidocaine_5ml_1", false] call ACEFUNC(medical_status,getMedicationCount);
private _lidocaineCount52 = [_patient, "syringe_kat_lidocaine_5ml_2", false] call ACEFUNC(medical_status,getMedicationCount);
private _lidocaineCount101 = [_patient, "syringe_kat_lidocaine_10ml_1", false] call ACEFUNC(medical_status,getMedicationCount);
private _lidocaineCount102 = [_patient, "syringe_kat_lidocaine_10ml_2", false] call ACEFUNC(medical_status,getMedicationCount);
private _morphineCount = [_patient, "Morphine", false] call ACEFUNC(medical_status,getMedicationCount);
private _nalbuphineCount = [_patient, "Nalbuphine", false] call ACEFUNC(medical_status,getMedicationCount);
private _fentanylCount = [_patient, "Fentanyl", false] call ACEFUNC(medical_status,getMedicationCount);
private _ketamineCount = [_patient, "Ketamine", false] call ACEFUNC(medical_status,getMedicationCount);
private _nalbuphineCount51 = [_patient, "syringe_kat_nalbuphine_5ml_1", false] call ACEFUNC(medical_status,getMedicationCount);
private _fentanylCount51 = [_patient, "syringe_kat_fentanyl_5ml_1", false] call ACEFUNC(medical_status,getMedicationCount);
private _ketamineCount51 = [_patient, "syringe_kat_ketamine_5ml_1", false] call ACEFUNC(medical_status,getMedicationCount);
private _nalbuphineCount52 = [_patient, "syringe_kat_nalbuphine_5ml_2", false] call ACEFUNC(medical_status,getMedicationCount);
private _fentanylCount52 = [_patient, "syringe_kat_fentanyl_5ml_2", false] call ACEFUNC(medical_status,getMedicationCount);
private _ketamineCount52= [_patient, "syringe_kat_ketamine_5ml_2", false] call ACEFUNC(medical_status,getMedicationCount);
private _nalbuphineCount101 = [_patient, "syringe_kat_nalbuphine_10ml_1", false] call ACEFUNC(medical_status,getMedicationCount);
private _fentanylCount101 = [_patient, "syringe_kat_fentanyl_10ml_1", false] call ACEFUNC(medical_status,getMedicationCount);
private _ketamineCount101 = [_patient, "syringe_kat_ketamine_10ml_1", false] call ACEFUNC(medical_status,getMedicationCount);
private _nalbuphineCount102 = [_patient, "syringe_kat_nalbuphine_10ml_2", false] call ACEFUNC(medical_status,getMedicationCount);
private _fentanylCount102 = [_patient, "syringe_kat_fentanyl_10ml_2", false] call ACEFUNC(medical_status,getMedicationCount);
private _ketamineCount102 = [_patient, "syringe_kat_ketamine_10ml_2", false] call ACEFUNC(medical_status,getMedicationCount);
if (_lidocaineCount <=  0.6 && _morphineCount <=  0.8 && _nalbuphineCount <=  0.8 && _fentanylCount <=  0.8 && _ketamineCount <=  0.8 && _lidocaineCount51 <=  0.6  && _nalbuphineCount51 <=  0.8 && _fentanylCount51 <=  0.8 && _ketamineCount51 <=  0.8 &&_lidocaineCount52 <=  0.6  && _nalbuphineCount52 <=  0.8 && _fentanylCount52 <=  0.8 && _ketamineCount52 <=  0.8 && _lidocaineCount101 <=  0.6  && _nalbuphineCount101 <=  0.8 && _fentanylCount101 <=  0.8 && _ketamineCount101 <=  0.8 && _lidocaineCount102 <=  0.6  && _nalbuphineCount102 <=  0.8 && _fentanylCount102 <=  0.8 && _ketamineCount102 <=  0.8) then {
    private _pain = random [0.7, 0.8, 0.9];
    [_patient, _pain] call ACEFUNC(medical_status,adjustPainLevel);
};

playSound3D [QPATHTOF_SOUND(sounds\reduction.wav), _patient, false, getPosASL _patient, 8, 1, 15];

if (random 100 < GVAR(closedReductionFailChance)) exitWith {
    private _output = LLSTRING(fracture_fail);
    [_output, 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

_activeFracture set [_part, 0];
_fractureArray set [_part, 0];

_patient setVariable [QGVAR(fractures), _fractureArray, true];
_patient setVariable [VAR_FRACTURES, _activeFracture, true];
_patient setVariable [QACEGVAR(medical,isLimping), false, true];
[_patient, "blockSprint", QACEGVAR(medical,fracture), false] call ACEFUNC(common,statusEffect_set);
[_patient] call ACEFUNC(medical_engine,updateDamageEffects);
