#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Vitals"

[
    QGVAR(enableSimpleMedical),
    "CHECKBOX",
    [LLSTRING(SIMPLEMED_ENABLE), LLSTRING(SIMPLEMED_ENABLE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableFluidShift),
    "CHECKBOX",
    LLSTRING(FLUID_SHIFT),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
