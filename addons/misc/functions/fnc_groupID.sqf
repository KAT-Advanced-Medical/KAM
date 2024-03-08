#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Returns the groupname for a given unit.
 * And unit class.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * 0: Groupname: unit class <STRING>
 *
 * Example:
 * [cursorTarget] call kat_misc_fnc_groupID;
 *
 * Public: No
 */

params ["_unit"];

private _groupID = groupId (group _unit);

if (_unit getVariable [QGVAR(loadout), nil] isEqualType "") exitWith {
private _loadout = _unit getVariable QGVAR(loadout);
  format ["%1: %2", _groupID, _loadout];
};
private _loadout = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
format ["%1: %2", _groupID, _loadout];
