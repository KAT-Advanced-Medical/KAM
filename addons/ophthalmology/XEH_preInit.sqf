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
    LLSTRING(SETTING_ENABLE),
    [CBA_SETTINGS_CAT, LSTRING(SETTING_SubCategory_Injury)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Probability to get dust in the eyes
[
    QGVAR(probability_dust),
    "SLIDER",
    [LLSTRING(SETTING_BLINK_EFFECT_INTENSITY)],
    [CBA_SETTINGS_CAT, LSTRING(SETTING_SubCategory_Injury)],
    [1, 100, 5, 0],
    true
] call CBA_Settings_fnc_init;

// Probability to get dust in the eyes which is not treated by blink
[
    QGVAR(probability_dust_heavy),
    "SLIDER",
    [LLSTRING(SETTING_BLINK_EFFECT_INTENSITY)],
    [CBA_SETTINGS_CAT, LSTRING(SETTING_SubCategory_Injury)],
    [1, 100, 1, 0],
    true
] call CBA_Settings_fnc_init;

// Probability to treat the dust in the eyes with blinking
[
    QGVAR(probability_treatment_dust),
    "SLIDER",
    [LLSTRING(SETTING_BLINK_EFFECT_INTENSITY)],
    [CBA_SETTINGS_CAT, LSTRING(SETTING_SubCategory_Injury)],
    [1, 100, 20, 0],
    true
] call CBA_Settings_fnc_init;

// Dust in the eye post process effect intensity
[
    QGVAR(dust_effect_intensity),
    "SLIDER",
    [LLSTRING(SETTING_DUST_EFFECT_INTENSITY)],
    [CBA_SETTINGS_CAT, LSTRING(SETTING_SubCategory_Injury)],
    [1, 10, 3, 0],
    true
] call CBA_Settings_fnc_init;

// Enable manual blinking
[
    QGVAR(enableManualBlinking),
    "CHECKBOX",
    LLSTRING(SETTING_ENABLE_MANUAL_BLINKING),
    [CBA_SETTINGS_CAT, LSTRING(SETTING_SubCategory_Manual)],
    [false],
    true
] call CBA_Settings_fnc_init;

// Time span blinking is needed
[
    QGVAR(blink_duration),
    "SLIDER",
    [LLSTRING(SETTING_BLINK_DURATION)],
    [CBA_SETTINGS_CAT, LSTRING(SETTING_SubCategory_Manual)],
    [1, 600, 60, 0],
    true
] call CBA_Settings_fnc_init;

// Blinking post process effect intensity
[
    QGVAR(blink_effect_intensity),
    "SLIDER",
    [LLSTRING(SETTING_BLINK_EFFECT_INTENSITY)],
    [CBA_SETTINGS_CAT, LSTRING(SETTING_SubCategory_Manual)],
    [1, 10, 5, 0],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
