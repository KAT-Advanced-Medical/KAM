#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Local call for fully healing a fracture.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Entry <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "_entry"] call kat_surgery_fnc_closedFractureLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_entry"];

private _part = ALL_BODY_PARTS find toLower _bodyPart;
private _activeFracture = GET_FRACTURES(_patient);
private _fractureArray = _patient getVariable [QGVAR(fractures), [0,0,0,0,0,0]];
private _count1 = [_patient, "Lidocaine"] call ace_medical_status_fnc_getMedicationCount;
private _count2 = [_patient, "Morphine"] call ace_medical_status_fnc_getMedicationCount;
private _number = _entry;

if (_count1 == 0 && _count2 == 0) then {
    private _pain = random [0.7, 0.8, 0.9];
    [_patient, _pain] remoteExec ["ace_medical_fnc_adjustPainLevel", _patient];
};

playsound3D [QPATHTOF_SOUND(sounds\reduction.wav), _patient, false, getPosASL _patient, 8, 1, 15];

if (_number < 3) exitWith {
    private _output = LLSTRING(fracture_fail);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

_activeFracture set [_part, 0];
_fractureArray set [_part, 0];

_patient setVariable [QGVAR(fractures), _fractureArray, true];
_patient setVariable [VAR_FRACTURES, _activeFracture, true];
_patient setVariable ["ace_medical_isLimping", false, true];
[_patient, "blockSprint", "ace_medical_fracture", false] call ace_common_fnc_statusEffect_set;
[_patient] call ace_medical_engine_fnc_updateDamageEffects;
