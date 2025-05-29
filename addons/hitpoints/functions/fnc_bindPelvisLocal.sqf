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

private _pelvicFracture = _unit getVariable [QGVAR(pelvicFracture), 0];
if (_pelvicFracture > 0) then {
    _patient setVariable [QGVAR(pelvicFracture), -1, true];
    [_patient] call EFUNC(misc,updateDamageEffects);
    _patient setVariable [QGVAR(activePelvicBinder), true, true];
};


