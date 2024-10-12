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
private _medStack = _patient call ACEFUNC(medical_treatment,getAllMedication);
private _medsToCheck = ["fentanyl", "ketamine", "nalbuphine", "morphine", "morphineIV"];
private _fentanylEffectiveness = 0;
private _ketamineEffectiveness = 0;
private _nalbuphineEffectiveness = 0;
private _morphineEffectiveness = 0;
private _morphineIVEffectiveness = 0;
{
    private _medName = toLower (_x select 0);
    private _effectiveness = _x select 2;
    if (_medName find "fentanyl" > -1) then {
        _fentanylEffectiveness = _fentanylEffectiveness max _effectiveness;
    };
    if (_medName find "ketamine" > -1) then {
        _ketamineEffectiveness = _ketamineEffectiveness max _effectiveness;
    };
    if (_medName find "nalbuphine" > -1) then {
        _nalbuphineEffectiveness = _nalbuphineEffectiveness max _effectiveness;
    };
    if (_medName find "morphine" > -1) then {
        _nalbuphineEffectiveness = _nalbuphineEffectiveness max _effectiveness;
    };
    if (_medName find "morphineIV" > -1) then {
        _nalbuphineEffectiveness = _nalbuphineEffectiveness max _effectiveness;
    };
} forEach _medStack;
if (
    _fentanylEffectiveness <= 0.8 &&
    _ketamineEffectiveness <= 0.8 &&
    _nalbuphineEffectiveness <= 0.8 &&
    _morphineEffectiveness <= 0.8 &&
    _morphineIVEffectiveness <= 0.8 &&
) then {
    [_patient, [0.6, 0.7, 0.8] select (floor random 3)] call ACEFUNC(medical_status, adjustPainLevel);
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
