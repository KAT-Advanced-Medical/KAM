#include "script_component.hpp"
/*
 * Author: Kygan
 * Treatment for hemopneumothorax
 * Main function
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_treatmentAdvanced_hemopneumothoraxLocal;
 *
 * Public: No
 */

params ["_player", "_target"];
systemChat "Executing Hemopneumothorax Treatment local";
_target setVariable ["KAT_medical_hemopneumothorax", false, true];

[_target, "activity", LSTRING(hemopneumothorax), [[_player] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;
