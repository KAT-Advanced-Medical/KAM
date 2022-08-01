#include "script_component.hpp"
/*
 * Author: Mazinski.H
 * Checks for Carbonate Wakeup values to restore consciousness
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Item Classname <STRING>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *`
 * Example:
 * [player, "Accuvac"] call kat_pharma_fnc_treatmentAdvanced_CarbonateLocal;
 *
 * Public: No
 */

params ["_medic", "_target", "_item"];

private _bloodPressure = [_target] call ace_medical_status_fnc_getBloodPressure;
_bloodPressureH = _bloodPressure select 1;

if (_bloodPressureH >= 110 && _bloodPressureH <= 130) then {
    [_target, false] call ace_medical_status_fnc_setUnconsciousState;
};

[_target, "Carbonate"] call ace_medical_treatment_fnc_addToTriageCard;
[_target, "activity", LSTRING(use_log), [[_medic] call ace_common_fnc_getName, "Carbonate"]] call ace_medical_treatment_fnc_addToLog;

true

