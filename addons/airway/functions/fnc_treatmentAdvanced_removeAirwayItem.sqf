#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Removing airway item from patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_removeAirwayItem;
 *
 * Public: No
 */

params ["_medic", "_patient"];

[_patient, "activity", LSTRING(RemoveAirwayItem_Log), [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

[QGVAR(removeAirwayItemLocal), [_medic, _patient], _patient] call CBA_fnc_targetEvent;

