#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Ophthalmology"

// Enable Blinking
[
    QGVAR(enable),
    "CHECKBOX",
    LLSTRING(SETTING_ENABLE),
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
