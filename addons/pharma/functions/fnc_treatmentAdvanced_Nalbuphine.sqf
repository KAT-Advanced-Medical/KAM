#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Nalbuphine Treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_pharma_fnc_treatmentAdvanced_Nalbuphine;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname", "", "_usedItem"];

[QGVAR(medicationLocal), [_patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;