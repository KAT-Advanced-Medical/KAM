#include "..\script_component.hpp"
/*
 * Author: kolmipilot
 * Disable the SCBA to give free air to the player.
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_chemical_disableSCBA
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(SCBAEnabled), false, true];
