/*
 * Author: Katalam
 * Returns the groupname for a given unit.
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * 0: Groupname <STRING>
 *
 * Example:
 * [cursorTarget] call kat_aceCirculation_fnc_groupID
 *
 * Public: No
 */

params ["_unit"];

_groupID = groupId (group _unit);

if (_unit getVariable ["kat_aceCirculation_loadout", nil] isEqualType "") exitWith {
_loadout = _unit getVariable "kat_aceCirculation_loadout";
  format ["%1: %2", _groupID, _loadout];
};
_loadout = getText (configFile >> "cfgVehicles" >> typeOf _unit >> "displayName");
format ["%1: %2", _groupID, _loadout];
