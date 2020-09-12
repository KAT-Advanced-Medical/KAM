#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Burning"

// chance for burning wound xxx treatment success
[
    QGVAR(xxx),
    "SLIDER",
    LLSTRING(xxx),
    CBA_SETTINGS_CAT,
    [0, 1, 0.5, 0],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
