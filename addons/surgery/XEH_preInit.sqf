#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT_M "ACE Pharmacy - Medications"
#define CBA_SETTINGS_CAT_F "ACE Pharmacy - Fractures"
#define CBA_SETTINGS_CAT_A "ACE Pharmacy - AED"

[
	QGVAR(IVreuse),
	"CHECKBOX",
	[LLSTRING(IV_REUSE), LLSTRING(IV_REUSE_DESC)],
	CBA_SETTINGS_CAT_M,
	[false],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(IVmedic),
	"LIST",
	[LLSTRING(IV_MEDIC) ,LLSTRING(IV_MEDIC_DESC)],
	CBA_SETTINGS_CAT_M,
	[[0, 1, 2], ["Anyone", "Medics", "Doctors"], 2],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(IVdropEnable),
	"CHECKBOX",
	[LLSTRING(IV_DROP_ENABLE), LLSTRING(IV_DROP_ENABLE_DESC)],
	CBA_SETTINGS_CAT_M,
	[true],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(IVdrop),
	"SLIDER",
	[LLSTRING(IV_DROP), LLSTRING(IV_DROP_DESC)],
	CBA_SETTINGS_CAT_M,
	[60, 1200, 600, 0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(IVestablish),
	"SLIDER",
	[LLSTRING(IV_TIME)],
	CBA_SETTINGS_CAT_M,
	[0.1, 10, 7, 1],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(IOestablish),
	"SLIDER",
	[LLSTRING(IO_TIME)],
	CBA_SETTINGS_CAT_M,
	[0.1, 10, 7, 1],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(PushTime),
	"SLIDER",
	[LLSTRING(PUSH_TIME)],
	CBA_SETTINGS_CAT_M,
	[0.1, 10, 7, 1],
	true
] call CBA_Settings_fnc_init;

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
	QGVAR(maxStack),
	"SLIDER",
	[LLSTRING(MAX_STACK), LLSTRING(MAX_STACK_DESC)],
	CBA_SETTINGS_CAT_M,
	[1, 10, 5, 0],
	true
] call CBA_Settings_fnc_init;

//location for AED - Defi:
[
	QGVAR(useLocation_AED),
	"LIST",
	[LLSTRING(LOCATION_AED),LLSTRING(LOCATION_AED_DESCRIPTION)],
	CBA_SETTINGS_CAT_A,
	[[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],0],
	true
] call CBA_Settings_fnc_init;

//Succes chance for AED-X
[
	QGVAR(SuccesCh_AED_X),
	"SLIDER",
	LLSTRING(SUCESSCHANCE_AED_X),
	CBA_SETTINGS_CAT_A,
	[1, 100, 85, 0],
	true
] call CBA_Settings_fnc_init;

//Succes chance for AED
[
	QGVAR(SuccesCh_AED),
	"SLIDER",
	LLSTRING(SUCESSCHANCE_AED),
	CBA_SETTINGS_CAT_A,
	[1, 100, 80, 0],
	true
] call CBA_Settings_fnc_init;

//Settable list for using AED-X per medical class
[
	QGVAR(medLvl_AED_X),
	"LIST",
	[LLSTRING(ALLOW_AED_X),LLSTRING(TRAINING_LEVEL_AED_X)],
	CBA_SETTINGS_CAT_A,
	[[0, 1, 2], ["Anyone", "Medics", "Doctors"], 2],
	true
] call CBA_settings_fnc_init;

//Distance limit for AED-X
[
	QGVAR(distanceLimit_AEDX),
	"SLIDER",
	[LLSTRING(DISTANCELIMIT_AED_X) ,LLSTRING(DISTANCELIMIT_AED_X_DESC)],
	CBA_SETTINGS_CAT_A,
	[2, 100, 30, 0],
	true
] call CBA_Settings_fnc_init;

//Time limit for monitor of AED-X
[
	QGVAR(timeLimit_AEDX),
	"SLIDER",
	[LLSTRING(TIMELIMIT_AED_X) ,LLSTRING(TIMELIMIT_AED_X_DESC)],
	CBA_SETTINGS_CAT_A,
	[60, 14400, 1800, 0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(DeactMon_whileAED_X),
	"CHECKBOX",
	LLSTRING(DEACTIVATE_MONITOR_WHILEAED_X),
	CBA_SETTINGS_CAT_A,
	[true],
	true
] call CBA_Settings_fnc_init;


//Enable different CPR chances per medical level
[
	QGVAR(enable_CPR_Chances),
	"CHECKBOX",
	LLSTRING(SETTING_CPR_CHANCES),
	CBA_SETTINGS_CAT_A,
	[true],
	true
] call CBA_Settings_fnc_init;

//CPR Chance for Doctors
[
	QGVAR(CPR_Chance_Doctor),
	"SLIDER",
	LLSTRING(SETTING_CPR_CHANCE_DOCTOR),
	CBA_SETTINGS_CAT_A,
	[0,100,40,0],
	true
] call CBA_Settings_fnc_init;

//CPR Chance for Regular medics
[
	QGVAR(CPR_Chance_RegularMedic),
	"SLIDER",
	LLSTRING(SETTING_CPR_CHANCE_REGULARMEDIC),
	CBA_SETTINGS_CAT_A,
	[0,100,30,0],
	true
] call CBA_Settings_fnc_init;

//CPR Chance for Default
[
	QGVAR(CPR_Chance_Default),
	"SLIDER",
	LLSTRING(SETTING_CPR_CHANCE_DEFAULT),
	CBA_SETTINGS_CAT_A,
	[0,100,20,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(enable_fracture),
	"CHECKBOX",
	LLSTRING(ADVANCED_FRACTURE),
	CBA_SETTINGS_CAT_F,
	[true],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(simpleChance),
	"SLIDER",
	LLSTRING(SIMPLE_FRACTURE),
	CBA_SETTINGS_CAT_F,
	[0,100,60,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(compoundChance),
	"SLIDER",
	[LLSTRING(COMPOUND_FRACTURE) ,LLSTRING(COMPOUND_FRACTURE_DESC)],
	CBA_SETTINGS_CAT_F,
	[0,100,30,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(etomidateTime),
	"SLIDER",
	LLSTRING(ETOMIDATE_TIME),
	CBA_SETTINGS_CAT_F,
	[0,100,45,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(closedTime),
	"SLIDER",
	LLSTRING(CLOSED_TIMER),
	CBA_SETTINGS_CAT_F,
	[0,100,10,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(openTime),
	"SLIDER",
	LLSTRING(OPEN_TIMER),
	CBA_SETTINGS_CAT_F,
	[0,100,15,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(surgicalTime),
	"SLIDER",
	LLSTRING(SURGICAL_TIMER),
	CBA_SETTINGS_CAT_F,
	[0,100,8,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(incisionTime),
	"SLIDER",
	LLSTRING(INCISION_TIMER),
	CBA_SETTINGS_CAT_F,
	[0,100,10,0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(fractureCheck_Level),
	"LIST",
	LLSTRING(FRACTURE_CHECK),
	CBA_SETTINGS_CAT_F,
	[[0, 1, 2], ["Anyone", "Medics", "Doctors"], 0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(closedReduction),
	"LIST",
	LLSTRING(CLOSED_REDUCTION),
	CBA_SETTINGS_CAT_F,
	[[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(surgicalAction),
	"LIST",
	LLSTRING(SURGICAL_ACTION),
	CBA_SETTINGS_CAT_F,
	[[0, 1, 2], ["Anyone", "Medics", "Doctors"], 2],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(closedLocation),
	"LIST",
	LLSTRING(CLOSED_LOCATION),
	CBA_SETTINGS_CAT_F,
	[[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(surgicalLocation),
	"LIST",
	LLSTRING(SURGICAL_LOCATION),
	CBA_SETTINGS_CAT_F,
	[[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],3],
	true
] call CBA_Settings_fnc_init;

ADDON = true;
