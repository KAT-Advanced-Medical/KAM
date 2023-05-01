#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Ophthalmology"

// Enable Dust Injury
[
    QGVAR(enable),
    "CHECKBOX",
    LLSTRING(setting_enable),
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_injury)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Probability to get dust in the eyes
[
    QGVAR(probability_dust),
    "SLIDER",
    [LLSTRING(setting_probability_dust)],
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_injury)],
    [1, 100, 5, 0],
    true
] call CBA_Settings_fnc_init;

// Probability to get dust in the eyes which is not treated by blink
[
    QGVAR(probability_dust_heavy),
    "SLIDER",
    [LLSTRING(setting_probability_dust_heavy)],
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_injury)],
    [1, 100, 1, 0],
    true
] call CBA_Settings_fnc_init;

// Probability to treat the dust in the eyes with blinking
[
    QGVAR(probability_treatment_dust),
    "SLIDER",
    [LLSTRING(setting_probability_treatment_dust)],
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_injury)],
    [1, 100, 20, 0],
    true
] call CBA_Settings_fnc_init;

// Dust in the eye post process effect intensity
[
    QGVAR(dust_effect_intensity),
    "SLIDER",
    [LLSTRING(setting_dust_effect_intensity)],
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_injury)],
    [1, 10, 3, 0],
    true
] call CBA_Settings_fnc_init;

// Blinking treatment time
[
    QGVAR(blink_treatment_time),
    "SLIDER",
    [LLSTRING(setting_blink_treatment_time)],
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_manual_blink)],
    [1, 10, 2, 0],
    true
] call CBA_Settings_fnc_init;

// Eye Wash treatment time
[
    QGVAR(eyewash_treatment_time),
    "SLIDER",
    [LLSTRING(setting_eyewash_treatment_time)],
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_manual_blink)],
    [1, 10, 2, 0],
    true
] call CBA_Settings_fnc_init;

// Eye Wash medic required
    QGVAR(eyewash_medic_required),
    "SLIDER",
    [LLSTRING(setting_eyewash_medic_required)],
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_manual_blink)],
    [0, 2, 0, 0],
    true
] call CBA_Settings_fnc_init;

// Enable manual blinking
[
    QGVAR(enableManualBlinking),
    "CHECKBOX",
    LLSTRING(setting_enable_manual_blinking),
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_manual_blink)],
    [false],
    true
] call CBA_Settings_fnc_init;

// Time span blinking is needed
[
    QGVAR(blink_duration),
    "SLIDER",
    [LLSTRING(setting_blink_renew_duration)],
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_manual_blink)],
    [1, 600, 60, 0],
    true
] call CBA_Settings_fnc_init;

// Blinking post process effect intensity
[
    QGVAR(blink_effect_intensity),
    "SLIDER",
    [LLSTRING(SETTING_BLINK_EFFECT_INTENSITY)],
    [CBA_SETTINGS_CAT, LSTRING(setting_subcategory_manual_blink)],
    [1, 10, 5, 0],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
