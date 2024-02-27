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
private _count1 = [_patient, "Lidocaine"] call ACEFUNC(medical_status,getMedicationCount);
private _count2 = [_patient, "Morphine"] call ACEFUNC(medical_status,getMedicationCount);

if (_count1 == 0 && _count2 == 0) then {
    private _pain = random [0.7, 0.8, 0.9];
    [_patient, _pain] call ACEFUNC(medical_status,adjustPainLevel);
};

playsound3D [QPATHTOF_SOUND(sounds\reduction.wav), _patient, false, getPosASL _patient, 8, 1, 15];

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
