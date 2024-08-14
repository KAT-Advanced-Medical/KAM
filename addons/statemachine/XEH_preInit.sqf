#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(fatalInjuriesPlayer),
    "LIST",
    [LSTRING(FatalInjuriesPlayer_DisplayName), LSTRING(FatalInjuriesPlayer_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory)],
    [
        [FATAL_INJURIES_ALWAYS, FATAL_INJURIES_CRDC_ARRST, FATAL_INJURIES_NEVER],
        [ELSTRING(common,Always), LSTRING(InCardiacArrest), ELSTRING(common,Never)],
        0
    ],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(fatalInjuriesAI),
    "LIST",
    [LSTRING(FatalInjuriesAI_DisplayName), LSTRING(FatalInjuriesAI_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory)],
    [
        [FATAL_INJURIES_ALWAYS, FATAL_INJURIES_CRDC_ARRST, FATAL_INJURIES_NEVER],
        [ELSTRING(common,Always), LSTRING(InCardiacArrest), ELSTRING(common,Never)],
        0
    ],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(AIUnconsciousness),
    "CHECKBOX",
    [LSTRING(AIUnconsciousness_DisplayName), LSTRING(AIUnconsciousness_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory)],
    true,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(cardiacArrestTime),
    "TIME",
    [LSTRING(CardiacArrestTime_DisplayName), LSTRING(CardiacArrestTime_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory)],
    [1, 3600, 300],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(cardiacArrestBleedoutEnabled),
    "CHECKBOX",
    [LSTRING(CardiacArrestBleedout_DisplayName), LSTRING(CardiacArrestBleedout_Description)],
    [ELSTRING(medical,Category), LSTRING(SubCategory)],
    true,
    true
] call CBA_fnc_addSetting;

// Overwrite ace statemachine
ACEGVAR(medical,STATE_MACHINE) = (configFile >> "KAT_StateMachine") call CBA_statemachine_fnc_createFromConfig;

ADDON = true;
