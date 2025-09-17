#include "..\script_component.hpp"
/*
 * Author: kolmipilot
 *
 * Arguments:
 * 0: Player <Player>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player, cursorTarget] call kat_chemical_fnc_giveUnitSCBA;
 *
 * Public: No
*/

params ["_medic", "_patient"];

[QGVAR(enableSCBA), [_patient], _patient] call CBA_fnc_targetEvent;
