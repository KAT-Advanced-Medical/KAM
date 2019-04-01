#include "script_component.hpp"
/*
 * Author: Katalam
 * Handle the treatment for the patient.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Successful <BOOLEAN>
 *
 * Example:
 * [player, cursorTarget, 'hand_l', 'BloodIV_A', 'BloodIV_A'] call kat_circulation_fnc_handleTreatment;
 *
 * Public: No
 */

params ["_player", "_target", "_selectionName", "_className", "_items"];

false;

[_player, _target, _selectionName, _className, _items] call ace_medical_treatment_fnc_treatmentIV;

if ([_target, _className] call FUNC(compatible)) exitWith {};

[_className, _target] call FUNC(treatmentIV);

true;
