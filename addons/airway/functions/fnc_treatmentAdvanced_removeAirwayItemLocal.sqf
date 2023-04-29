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
 * [player] call kat_airway_fnc_treatmentAdvanced_removeAirwayItemLocal;
 *
 * Public: No
 */

params ["_patient"];

_patient setVariable [QGVAR(airway), false, true];
_patient setVariable [QGVAR(airway_item), "", true];
