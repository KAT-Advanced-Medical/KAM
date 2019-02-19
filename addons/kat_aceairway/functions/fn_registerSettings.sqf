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

/*
When a patient enters the unconscious state, there are two things that can happen.
First of all the airway can collapse. In medical sense this mean, the airway can be blocked from your tongue muscle, 'cause of the missing muscle tone.
For example in real life, this will happen to nearly every unconscious person lying on the back.

The second thing that can happen is the the airway occluded state. When a patient is lying on the back and the body puke, it will not leave the mouth space.
It will stay in there and can block the airway too. The right treatment here, is to remove this vomit.
In real life, this will happen sometimes, not quiet often.
*/

// Enable aceAirway injuries
[
	"kat_aceAirway_enable",
	"CHECKBOX",
	localize "STR_kat_aceAirway_SETTING_ENABLE",
	CBA_SETTINGS_CAT,
	[true],
	true
] call CBA_Settings_fnc_init;


// aceAirway Injuries Death Timer
[
	"kat_aceAirway_deathTimer",
	"SLIDER",
	localize "STR_kat_aceAirway_SETTING_TIMER",
	CBA_SETTINGS_CAT,
	[0, 1800, 300, 0],
	true
] call CBA_Settings_fnc_init;

// aceAirway Injuries probability obstruction
[
	"kat_aceAirway_probability_obstruction",
	"SLIDER",
	localize "STR_kat_aceAirway_SETTING_obstruction",
	CBA_SETTINGS_CAT,
	[0, 100, 20, 0],
	true
] call CBA_Settings_fnc_init;

// aceAirway Injuries probability occluded
[
	"kat_aceAirway_probability_occluded",
	"SLIDER",
	localize "STR_kat_aceAirway_SETTING_occluded",
	CBA_SETTINGS_CAT,
	[0, 100, 30, 0],
	true
] call CBA_Settings_fnc_init;

// aceAirway puking sound yes or no?
// somebody told me that the sound which is played then someone is puking is super annoying and now you can remove it easily
[
	"kat_aceAirway_checkbox_puking_sound",
	"CHECKBOX",
	localize "STR_kat_aceAirway_SETTING_puking_sound",
	CBA_SETTINGS_CAT,
	[true],
	true
] call CBA_Settings_fnc_init;

[
	"kat_aceAirway_string_exit",
	"LIST",
	localize "STR_kat_aceAirway_SETTING_exit",
	CBA_SETTINGS_CAT,
	[["", "keko_wasPunched"], ["", "keko_wasPunched"], 0],
	true
] call CBA_Settings_fnc_init;

nil;
