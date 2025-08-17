#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT LSTRING(cba_name)
#include "initSettings.inc.sqf"

[
    QGVAR(enableBrainEffect),
    "CHECKBOX",
    [LLSTRING(SETTING_BrainEffect_display), LLSTRING(SETTING_BrainEffect_DESC)],
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
