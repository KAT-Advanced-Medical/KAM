#include "script_component.hpp"
/*
 * Author: Katalam
 * Handling the respawn for any reason for airway damage
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_airwayairway_fnc_handleDie;
 *
 * Public: No
 */

params ["_unit"];
if (!local _unit) exitWith {};
_unit call FUNC(init);
