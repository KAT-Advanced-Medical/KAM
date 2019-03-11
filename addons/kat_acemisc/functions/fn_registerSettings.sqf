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
 * call kat_aceMisc_fnc_registerSettings;
 *
 * Public: No
 */

#define CBA_SETTINGS_CAT "KAT - ACE Misc"

//Enable aceExposure things
[
	"kat_aceMisc_enable",
	"CHECKBOX",
	localize "STR_kat_aceMisc_SETTING_ENABLE",
	CBA_SETTINGS_CAT,
	[true],
	true
] call CBA_Settings_fnc_init;

//Enable limit wounds
[
	"kat_aceMisc_limitWounds_enable",
	"CHECKBOX",
	localize "STR_kat_aceMisc_SETTING_LIMITWOUNDS_ENABLE",
	CBA_SETTINGS_CAT,
	[true],
	true
] call CBA_Settings_fnc_init;

//Enable limit wounds
[
	"kat_aceMisc_limitWounds_condition",
	"LIST",
	localize "STR_kat_aceMisc_Condition_limitWounds_Display",
	CBA_SETTINGS_CAT,
	[[0, 1, 2, 3], ["STR_ACE_Medical_AdvancedMedicalSettings_anywhere", "STR_ACE_Medical_AdvancedMedicalSettings_vehicle", "STR_ACE_Medical_AdvancedMedicalSettings_facility", "STR_ACE_Medical_AdvancedMedicalSettings_vehicleAndFacility"], 0],
	true,
	{
		missionNamespace setVariable ['kat_aceMisc_limitWounds_condition', _this];
	}
] call CBA_Settings_fnc_init;

nil;
