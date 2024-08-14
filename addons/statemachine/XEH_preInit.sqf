#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: States"

//Enable transitions to seizure state
[
    QGVAR(enableSeizure),
    "CHECKBOX",
    [LSTRING(enableSeizure_DisplayName), LSTRING(enableSeizure_Description)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Seizures)],
    false,
    true
] call CBA_fnc_addSetting;

//Minimum duration of seizure
[
    QGVAR(Seizure_Min_Length),
    "SLIDER",
    [LSTRING(Seizure_Min_Length_DisplayName),LSTRING(Seizure_Min_Length_Description)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Seizures)],
    [5, 180, 10, 0],
    true
] call CBA_Settings_fnc_init;

//Maximum duration of seizure
[
    QGVAR(Seizure_Max_Length),
    "SLIDER",
    [LSTRING(Seizure_Max_Length_DisplayName),LSTRING(Seizure_Max_Length_Description)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Seizures)],
    [5, 180, 120, 0],
    true
] call CBA_Settings_fnc_init;

// Overwrite ace statemachine
ACEGVAR(medical,STATE_MACHINE) = (configFile >> "KAT_StateMachine") call CBA_statemachine_fnc_createFromConfig;

ADDON = true;
