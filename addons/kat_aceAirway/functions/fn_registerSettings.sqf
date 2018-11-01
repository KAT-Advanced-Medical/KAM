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
	"SLIDER",
	localize "STR_kat_aceAirway_SETTING_TIMER",
	CBA_SETTINGS_CAT,
	[0, 1800, 300, 0],
	true
] call CBA_Settings_fnc_init;

//aceAirway Injuries probability collapsed
[
	"kat_aceAirway_probability_collapsed",
	"SLIDER",
	localize "STR_kat_aceAirway_SETTING_collapsed",
	CBA_SETTINGS_CAT,
	[0, 100, 20, 0],
	true
] call CBA_Settings_fnc_init;

//aceAirway Injuries probability occluded
[
	"kat_aceAirway_probability_occluded",
	"SLIDER",
	localize "STR_kat_aceAirway_SETTING_occluded",
	CBA_SETTINGS_CAT,
	[0, 100, 30, 0],
	true
] call CBA_Settings_fnc_init;

nil;
