/*
 * Author: Katalam
 * Called when a unit is initialized
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_aceBreathing_fnc_handleInit;
 *
 * Public: No
 */

params ["_unit"];

if !(kat_aceBreathing_enable) exitWith {};

[{(_this select 0) getVariable ["ace_medical_airwayStatus", 100] < 70}] call ace_medical_fnc_addUnconsciousCondition;
_unit call kat_aceBreathing_fnc_init;
/*
if (kat_aceBreathing_pneumothorax == 0) exitWith {};
_unit addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "", "_projectile"];
	[_unit, _selection, _damage, _projectile] call kat_aceBreathing_fnc_handlePulmoHit;
}];
*/
