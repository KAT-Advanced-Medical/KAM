#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Conversion"

// Overwrite ace statemachine
ACEGVAR(medical,STATE_MACHINE) = (configFile >> "KAT_StateMachine") call CBA_statemachine_fnc_createFromConfig;

[
    QGVAR(enableConversion),
    "CHECKBOX",
    [LLSTRING(CONVERSION_ENABLE), LLSTRING(CONVERSION_ENABLE_DISC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

/*[
    QGVAR(enableConversionArrest),
    "CHECKBOX",
    [LLSTRING(CONVERSION_ARREST_ENABLE), LLSTRING(CCONVERSION_ARREST_ENABLE_DISC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;*/

ADDON = true;