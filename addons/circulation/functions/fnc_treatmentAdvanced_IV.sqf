#include "script_component.hpp"
/*
 * Author: Katalam
 * Handle the IV for the patient with blood types. Have to be local to avoid effect on all clients.
 *
 * Arguments:
 * 0: Classname <STRING>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * ['Blood_IV_A', cursorTarget] call kat_circulation_fnc_treatmentAdvanced_IV
 *
 * Public: No
 */

params ["_className", "_target"];

//unit, adjustment, time
private _volume = getNumber (configFile >> "ACE_Medical_Treatment" >> "IV" >> _className >> "volume");

private _hradjust = -(_volume / 4);

[_target, "BloodPoisoning", 150, 300, _hradjust, 0, -10] call ACEFUNC(medical_status,addMedicationAdjustment);
