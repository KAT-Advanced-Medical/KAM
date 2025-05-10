#include "..\script_component.hpp"
/*
 * Author: Mazinski.H
 * Locates and Removes Bradycardia Effect.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_chemical_fnc_treatmentAdvanced_AtropineLocal;
 *
 * Public: No
 */

params ["_patient"];

_patient setVariable [QGVAR(airPoisoning), false, true];
