#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Brain Injuries"

//Enable traumatic brain injuries
[
	QGVAR(enable),
	"CHECKBOX",
	LLSTRING(SETTING_enable),
	[CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
	[true],
	true
] call CBA_Settings_fnc_init;

//Chance of a concussion occuring
[
	QGVAR(concussionChance),
    "SLIDER",
    [LLSTRING(SETTING_concussionChance)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Concussions)],
    [0, 100, 5, 1],
    true
] call CBA_Settings_fnc_init;

// Minimum impact damage required to cause healable tissue damage upon receiving a concussion
[
	QGVAR(tissueImpactDamage),
    "SLIDER",
    [LLSTRING(SETTING_tissueImpactDamage)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Concussions)],
    [1, 3, 0.3, 1],
    true
] call CBA_Settings_fnc_init;

// Minimum impact damage required to cause instant tissue necrosis upon receiving a concussion
[
	QGVAR(necrosisImpactDamage),
    "SLIDER",
    [LLSTRING(SETTING_necrosisImpactDamage)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Concussions)],
    [1, 3, 0.9, 1],
    true
] call CBA_Settings_fnc_init;

// Number of ticks required until tissue necrosis begins to occur
[
	QGVAR(necrosisTicks),
    "SLIDER",
    [LLSTRING(SETTING_necrosisTicks)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_BrainDeath)],
    [1, 60, 10, 0],
    true
] call CBA_Settings_fnc_init;

// rO2 value required before necrosis occurs
[
	QGVAR(necrosisThreshold),
    "SLIDER",
    [LLSTRING(SETTING_necrosisThreshold)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_BrainDeath)],
    [1, 80, 60, 0],
    true
] call CBA_Settings_fnc_init;

//How much necrosis increases each tick
[
	QGVAR(necrosisIncrease),
    "SLIDER",
    [LLSTRING(SETTING_necrosisIncrease)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_BrainDeath)],
    [0, 10, 1.6, 1],
    true
] call CBA_Settings_fnc_init;

ADDON = true;