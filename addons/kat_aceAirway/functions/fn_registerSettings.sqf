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

#define CBA_SETTINGS_CAT "KAT - ACE Airway"

//Enable aceAirway injuries
[
	"kat_aceAirway_enable",
	"CHECKBOX",
	localize "STR_kat_aceAirway_SETTING_ENABLE",
	CBA_SETTINGS_CAT,
	[true],
	true
] call CBA_Settings_fnc_init;


//aceAirway Injuries Death Timer
[
	"kat_aceAirway_deathTimer",
	"LIST",
	localize "STR_kat_aceAirway_SETTING_TIMER",
	CBA_SETTINGS_CAT,
	[[150, 300, 450, 600], ["150 s", "300 s", "450 s", "600s"], 1],
	true
] call CBA_Settings_fnc_init;


nil;
