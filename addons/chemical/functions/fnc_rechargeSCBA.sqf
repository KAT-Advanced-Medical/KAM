#include "..\script_component.hpp"
/*
 * Author: kolmipilot
 * Handles recharging of SCBA units.
 * Arguments:
 * 0: player <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_rechargeSCBA;
 *
 * Public: No
 *
 *
*/

params ["_player"];

private _SCBA_maxOxygenTime = missionNamespace getVariable [QGVAR(SCBA_maxOxygenTime), 1800];
private _backpack = backpackContainer _player;
_backpack setVariable [QGVAR(SCBA_oxygen), _SCBA_maxOxygenTime];
