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

private _partIndex = ALL_BODY_PARTS find _bodyPart;
private _jointArray = GET_JOINTS(_patient);
private _jointGroupIndex = switch (true) do {
case (_partIndex in [4, 5]): { 0 };
case (_partIndex in [6, 7]): { 1 };
case (_partIndex in [8, 9]): { 2 };
case (_partIndex in [10, 11]): { 3 };
default { -1 };
};

private _limbJointStatus = _jointArray select _jointGroupIndex;
private _selectedJointIndexes = if (["upper", _bodyPart] call BIS_fnc_inString) then {
    [0, 1]
} else {
    [1, 2]
};
private _medStack = _patient call ACEFUNC(medical_treatment,getAllMedicationCount);
private _medsToCheck = ["fentanyl", "ketamine", "nalbuphine", "morphine"];
private _fentanylEffectiveness = 0;
private _ketamineEffectiveness = 0;
private _nalbuphineEffectiveness = 0;
private _morphineEffectiveness = 0;
private _localAnesthesia = (_patient getVariable [QEGVAR(pharma,localAnesthesia), [0,0,0,0,0,0,0,0,0,0,0,0]]) select _partIndex;
{
    private _medName = toLower (_x select 0);
    private _effectiveness = _x select 2;
    if ("fentanyl" in _medName) then {
        _fentanylEffectiveness = _fentanylEffectiveness max _effectiveness;
    };
    if ("ketamine" in _medName) then {
        _ketamineEffectiveness = _ketamineEffectiveness max _effectiveness;
    };
    if ("nalbuphine" in _medName) then {
        _nalbuphineEffectiveness = _nalbuphineEffectiveness max _effectiveness;
    };
    if ("morphine" in _medName) then {
        _morphineEffectiveness = _morphineEffectiveness max _effectiveness;
    };
} forEach _medStack;
if (
    _fentanylEffectiveness <= 0.8 &&
    _ketamineEffectiveness <= 0.8 &&
    _nalbuphineEffectiveness <= 0.8 &&
    _morphineEffectiveness <= 0.8 &&
    _localAnesthesia <= 0.8
) then {
    [_patient, [0.6, 0.7, 0.8] select (floor random 3)] call ACEFUNC(medical_status,adjustPainLevel);
};

playSound3D [QPATHTOF_SOUND(sounds\reduction.wav), _patient, false, getPosASL _patient, 8, 1, 15];

{
    private _jointInjury = _limbJointStatus select _x;
    if (_jointInjury == 3) exitWith {
        _limbJointStatus set [_x, _jointInjury + 6];
        [_patient] call EFUNC(misc,updateDamageEffects);
        _patient setVariable [QACEGVAR(medical,isLimping), false, true];
        [_patient, "blockSprint", QACEGVAR(medical,fracture), false] call ACEFUNC(common,statusEffect_set);
    };
    if (_jointInjury == 6) exitWith {
        _limbJointStatus set [_x, _jointInjury + 3];
        [_patient] call EFUNC(misc,updateDamageEffects);
        _patient setVariable [QACEGVAR(medical,isLimping), false, true];
        [_patient, "blockSprint", QACEGVAR(medical,fracture), false] call ACEFUNC(common,statusEffect_set);
    };
} forEach _selectedJointIndexes;



