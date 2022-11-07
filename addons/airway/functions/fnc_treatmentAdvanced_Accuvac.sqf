#include "script_component.hpp"
/*
 * Author: Katalam
 * Airway Management for occluding
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Example:
 * [player, cursorTarget] call kat_airway_fnc_treatmentAdvanced_accuvac;
 *
 * Public: Yes
 */

params ["_medic", "_patient", "_usedItem"];

if !(_patient getVariable [QGVAR(occluded), false]) exitWith {
    private _output = localize LSTRING(Accuvac_NA);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
};

[_patient, _usedItem] call ace_medical_treatment_fnc_addToTriageCard;

[QGVAR(accuvacLocal), [_patient, "Accuvac"], _patient] call CBA_fnc_targetEvent;
