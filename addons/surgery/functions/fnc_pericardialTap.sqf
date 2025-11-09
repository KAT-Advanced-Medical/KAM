#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Runs the Pericardial Tap.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject] call kat_surgery_pericardialTap
 *
 * Public: No
 */

params ["_medic", "_patient"];

[_patient, "quick_view", LSTRING(Pericardial_Tap_Log), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

[QGVAR(pericardialTap), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
