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

ADDON = true;