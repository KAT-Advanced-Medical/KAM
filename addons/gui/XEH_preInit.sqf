#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: GUI"

// Enable or disable Colored Action Logs
[
    QGVAR(ColoredLogs),
    "CHECKBOX",
    [LLSTRING(SETTING_ColoredLogs),LLSTRING(SETTING_ColoredLogs_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;