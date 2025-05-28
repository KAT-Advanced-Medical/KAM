#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Treatment for hemopneumothorax/tensionPnumo
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Side <Number>
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, 1] call kat_breathing_fnc_treatmentAdvanced_fingerThoracostomy;
 *
 * Public: No
 */

params ["_medic", "_patient", "_side"];

[_patient, "activity", LSTRING(FingerThoracostomy_Log), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

[QGVAR(fingerThoracostomyLocal), [_medic, _patient, _side], _patient] call CBA_fnc_targetEvent;
