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
 * call kat_aceExposure_fnc_registerSettings;
 *
 * Public: No
 */

#define CBA_SETTINGS_CAT "KAT - ACE Exposure"

//Enable aceExposure things
[
    "kat_aceExposure_enable",
    "CHECKBOX",
    localize "STR_kat_aceExposure_SETTING_ENABLE",
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

nil;
