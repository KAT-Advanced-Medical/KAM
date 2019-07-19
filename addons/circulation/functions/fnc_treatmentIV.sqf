#include "script_component.hpp"
/*
 * Author: Katalam
 * Handle the IV for the patient with blood types. Have to be local to avoid effect on all clients.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * 0: Successful <BOOLEAN>
 *
 * Example:
 * ['Blood_IV_A', cursorTarget] call KAM_circulation_fnc_treatmentIV
 *
 * Public: No
 */

params ["_className", "_target"];

//unit, adjustment, time
private _volume = getNumber (configFile >> "ACE_Medical_Treatment" >> "IV" >> _className >> "volume");
private _hradjust = _volume / 10;
[_target, _hradjust, 60] call ace_medical_status_fnc_addHeartRateAdjustment;

private _a = (_target getVariable [QGVAR(IV_counts), 0]) + 1;
_target setVariable [QGVAR(IV_counts), _a, true];
