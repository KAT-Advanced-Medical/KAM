#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Initializes unit variables.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_vitals_fnc_init
 *
 * Public: No
 */

params ["_patient"];

[_patient] call FUNC(fullHealLocal);
