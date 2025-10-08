#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Overstretch the head of the patient for airway management without items
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_ManualBagPressure;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

[QGVAR(applyPressureBagLocal), [_medic, _patient, _bodyPart], _patient] call CBA_fnc_targetEvent;