#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT_M "KAT Medical - Surgery"

[
	QGVAR(kidneyAction),
	"CHECKBOX",
	[LLSTRING(KIDNEY_ACTION), LLSTRING(KIDNEY_ACTION_DESC)],
	CBA_SETTINGS_CAT_M,
	[false],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(blockChance),
	"SLIDER",
	[LLSTRING(BLOCK_CHANCE), LLSTRING(BLOCK_CHANCE_DESC)],
	CBA_SETTINGS_CAT_M,
	[0, 100, 20, 0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(enable_fracture),
	"CHECKBOX",
	LLSTRING(ADVANCED_FRACTURE),
	CBA_SETTINGS_CAT_M,
	[true],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(simpleChance),
	"SLIDER",
	LLSTRING(SIMPLE_FRACTURE),
	CBA_SETTINGS_CAT_M,
	[0,100,60,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(compoundChance),
	"SLIDER",
	[LLSTRING(COMPOUND_FRACTURE) ,LLSTRING(COMPOUND_FRACTURE_DESC)],
	CBA_SETTINGS_CAT_M,
	[0,100,30,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(etomidateTime),
	"SLIDER",
	LLSTRING(ETOMIDATE_TIME),
	CBA_SETTINGS_CAT_M,
	[0,100,45,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(closedTime),
	"SLIDER",
	LLSTRING(CLOSED_TIMER),
	CBA_SETTINGS_CAT_M,
	[0,100,10,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(openTime),
	"SLIDER",
	LLSTRING(OPEN_TIMER),
	CBA_SETTINGS_CAT_M,
	[0,100,15,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(surgicalTime),
	"SLIDER",
	LLSTRING(SURGICAL_TIMER),
	CBA_SETTINGS_CAT_M,
	[0,100,8,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(incisionTime),
	"SLIDER",
	LLSTRING(INCISION_TIMER),
	CBA_SETTINGS_CAT_M,
	[0,100,10,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(fractureCheck_Level),
	"LIST",
	LLSTRING(FRACTURE_CHECK),
	CBA_SETTINGS_CAT_M,
	[[0, 1, 2], ["Anyone", "Medics", "Doctors"], 0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(closedReduction),
	"LIST",
	LLSTRING(CLOSED_REDUCTION),
	CBA_SETTINGS_CAT_M,
	[[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(surgicalAction),
	"LIST",
	LLSTRING(SURGICAL_ACTION),
	CBA_SETTINGS_CAT_M,
	[[0, 1, 2], ["Anyone", "Medics", "Doctors"], 2],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(closedLocation),
	"LIST",
	LLSTRING(CLOSED_LOCATION),
	CBA_SETTINGS_CAT_M,
	[[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(surgicalLocation),
	"LIST",
	LLSTRING(SURGICAL_LOCATION),
	CBA_SETTINGS_CAT_M,
	[[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],3],
	true
] call CBA_Settings_fnc_init;

ADDON = true;
