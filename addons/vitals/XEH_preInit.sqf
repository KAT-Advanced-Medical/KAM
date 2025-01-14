#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Vitals"

[
    QGVAR(simpleMedical),
    "CHECKBOX",
    LLSTRING(SIMPLEMED_ENABLE),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enableBasicDiagnostic),
    "CHECKBOX",
    LLSTRING(BASIC_DIAGNOSTIC_ENABLE),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(basicDiagnosticTime),
    "SLIDER",
    LLSTRING(BASIC_DIAGNOSTIC_TIME),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0.1, 60, 15, 1],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
