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

private _groupID = groupId (group _unit);

if (_unit getVariable ["kat_aceCirculation_loadout", nil] isEqualType "") exitWith {
private _loadout = _unit getVariable "kat_aceCirculation_loadout";
  format ["%1: %2", _groupID, _loadout];
};
private _loadout = getText (configFile >> "cfgVehicles" >> typeOf _unit >> "displayName");
format ["%1: %2", _groupID, _loadout];
