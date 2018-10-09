/*
 * Author: Katalam
 * CBA Settings function
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceAirway_fnc_registerSettings;
 *
 * Public: No
 */

#define CBA_SETTINGS_CATEGORY "KAT - Airway"

//Enable aceAirway injuries
[
	"kat_aceAirway_enable",
	"CHECKBOX",
	localize "STR_kat_aceAirway_SETTING_ENABLE",
	CBA_SETTINGS_KAT,
	[false],
	true,
] call CBA_Settings_fnc_init;

//aceAirway Injuries Death Timer
[
	"kat_aceAirway_deathTimer",
	"LIST",
	localize "STR_kat_aceAirway_SETTING_TIMER",
	CBA_SETTINGS_KAT,
	[[150, 300, 450, 600], ["150 s", "300 s", "450 s", "600s"], 1],
	true,
] call CBA_Settings_fnc_init;

nil;
