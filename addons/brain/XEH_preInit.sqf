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

//Amount to reduce ICP by when brain is not actively swelling
[
	QGVAR(ICPreduction),
    "SLIDER",
    [LLSTRING(SETTING_ICPreduction)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 2, 0.3, 1],
    true
] call CBA_Settings_fnc_init;

// Minimum CMR to sustain consciousness. Not achieving will prevent awakening
[
	QGVAR(stableCMR),
    "SLIDER",
    [LLSTRING(SETTING_stableCMR)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 20, 16, 1],
    true
] call CBA_Settings_fnc_init;

// Minimum CMR required for unit to pass out randomly
[
	QGVAR(CMRunconsciousThreshold),
    "SLIDER",
    [LLSTRING(SETTING_CMRunconsciousThreshold)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 20, 18, 1],
    true
] call CBA_Settings_fnc_init;

//Chance for a unit to pass out randomly from low CMR
[
	QGVAR(CMRunconsciousChance),
    "SLIDER",
    [LLSTRING(SETTING_concussionChance)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 100, 20, 1],
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
    [0, 2, 0.3, 1],
    true
] call CBA_Settings_fnc_init;

// Minimum impact damage required to cause instant tissue necrosis upon receiving a concussion
[
	QGVAR(necrosisImpactDamage),
    "SLIDER",
    [LLSTRING(SETTING_necrosisImpactDamage)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Concussions)],
    [0, 2, 0.8, 1],
    true
] call CBA_Settings_fnc_init;

// Minimum ICP required for bradycardia to occur as a result
[
	QGVAR(ICPbradycardiaThreshold),
    "SLIDER",
    [LLSTRING(SETTING_ICPbradycardiaThreshold)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Concussions)],
    [20, 70, 50, 1],
    true
] call CBA_Settings_fnc_init;


//Chance of bradycardia occuring
[
	QGVAR(ICPbradycardiaChance),
    "SLIDER",
    [LLSTRING(SETTING_ICPbradycardiaChance)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Concussions)],
    [0, 100, 15, 1],
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