#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Handles the treatment of dust or heavy dust in eyes.
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, patient] call kat_ophthalmology_fnc_treatmentAdvanced_eyewash
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(dustInjuryLight), 0, true];
_patient setVariable [QGVAR(dustInjuryHeavy), 0, true];

private _eyeInjuries = _patient getVariable [QGVAR(eyeInjuries), [1, 1]];
private _eyeInjurySevere = _patient getVariable [QGVAR(eyeInjurySevere), false];

if (_eyeInjurySevere && (({_x == 0} count _eyeInjuries) > 1)) then {
    private _random = floor random 2;
    _eyeInjuries set [_random, 1];

    _patient setVariable [QGVAR(eyeInjuries), _eyeInjuries, true];
};

if !(_eyeInjurySevere) then {
    _patient setVariable [QGVAR(eyeInjuries), [1, 1], true];
};

[_patient, LLSTRING(eyewash_item)] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_usedItem), [[_medic] call ACEFUNC(common,getName), LLSTRING(eyewash_item)]] call ACEFUNC(medical_treatment,addToLog);
