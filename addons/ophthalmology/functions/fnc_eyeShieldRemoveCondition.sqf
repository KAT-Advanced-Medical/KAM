#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Sets condition for the Eye Shield
 *
 * Return Value:
 * Boolean
 *
 * Example:
 * [bob, patient] call kat_ophthalmology_fnc_eyeShieldCondition
 *
 * Public: No
 */

params ["_medic", "_patient"];

if ((hmd _patient == "kat_eyecovers_left") || (hmd _patient == "kat_eyecovers_right")) exitWith {
    true
};

false
