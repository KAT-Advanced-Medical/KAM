#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Feedback"

//low SPO2 Warning Level
[
    QGVAR(effectLowSpO2),
    "SLIDER",
    [LLSTRING(SETTING_lowSpO2_display), LLSTRING(SETTING_lowSpO2_DESC)],
    CBA_SETTINGS_CAT,
    [5, 100, 90, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableOpioidEffect),
    "CHECKBOX",
    [LLSTRING(SETTING_OpioidEffect_display), LLSTRING(SETTING_OpioidEffect_DESC)],
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
