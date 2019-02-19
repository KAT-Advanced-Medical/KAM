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
 * call kat_aceCirculation_fnc_registerSettings;
 *
 * Public: No
 */

#define CBA_SETTINGS_CAT "KAT - ACE Circulation"

//Enable aceCirculation things
[
	"kat_aceCirculation_enable",
	"CHECKBOX",
	localize "STR_kat_aceCirculation_SETTING_ENABLE",
	CBA_SETTINGS_CAT,
	[true],
	true
] call CBA_Settings_fnc_init;

//Enable aceCirculation things
[
	"kat_aceCirculation_bloodgroup",
	"LIST",
	localize "STR_kat_aceCirculation_SETTING_ENABLE",
	CBA_SETTINGS_CAT,
	[["A", "B", "C", "0"], ["A", "B", "C", "0"], 0],
	2
] call CBA_Settings_fnc_init;

nil;
