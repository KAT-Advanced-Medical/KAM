#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Brain Injuries"

//Enable head injuries
[
	QGVAR(enable),
	"CHECKBOX",
	LLSTRING(SETTING_enable),
	[CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
	[true],
	true
] call CBA_Settings_fnc_init;

//Set concussion deterioration chance
[
    QGVAR(deterioratingConcussion_chance),
    "SLIDER",
    [LLSTRING(SETTING_deterioratingConcussion_chance), LLSTRING(DESCRIPTION_deterioratingConcussion_chance)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Concussions)],
    [0, 100, 8, 0],
    true
] call CBA_Settings_fnc_init;

//Set concussion deterioration interval 
[
    QGVAR(deterioratingConcussion_interval),
    "SLIDER",
    [LLSTRING(SETTING_deterioratingConcussion_interval), LLSTRING(DESCRIPTION_deterioratingConcussion_interval)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Concussions)],
    [1, 3600, 180, 0],
    true
] call CBA_Settings_fnc_init;

ADDON = true;