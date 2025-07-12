#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Removes the eye shield from a patient
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, patient] call kat_ophthalmology_fnc_treatmentAdvanced_eyeShieldRemoveLocal
 *
 * Public: No
 */
 
params ["_medic", "_patient"];

_patient unassignItem (hmd _patient);
