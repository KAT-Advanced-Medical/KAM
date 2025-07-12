#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Handles the placement of the eye shield
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, patient] call kat_ophthalmology_fnc_treatmentAdvanced_eyeShield
 *
 * Public: No
 */

params ["_medic", "_patient"];

[QGVAR(eyeShield), [_medic, _patient], _patient] call CBA_fnc_targetEvent;
