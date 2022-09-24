#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Pharmacy"

//Activate Naloxone
[
    QGVAR(naloxoneActive),
    "CHECKBOX",
    [LLSTRING(NALOXONE_ACTIVE)],
    "KAT - ADV Medical: Pharmacy",
    [true],
    true
] call CBA_Settings_fnc_init;

//Activate Carbonate
[
    QGVAR(carbonateActive),
    "CHECKBOX",
    [LLSTRING(CARBONATE_ACTIVE)],
    "KAT - ADV Medical: Pharmacy",
    [true],
    true
] call CBA_Settings_fnc_init;

//Activate TXA
[
    QGVAR(txaActive),
    "CHECKBOX",
    [LLSTRING(TXA_ACTIVE)],
    "KAT - ADV Medical: Pharmacy",
    [true],
    true
] call CBA_Settings_fnc_init;

//Require inserted IV for using saline/blood/plasma?
[
    QGVAR(RequireInsIV),
    "CHECKBOX",
    [LLSTRING(SETTING_REQUIRE_INS_IV),LLSTRING(SETTING_REQUIRE_INS_IV_DESC)],
    "KAT - ADV Medical: Pharmacy",
    [false],
    true
] call CBA_Settings_fnc_init;

//Require inserted IV for using medications?
[
    QGVAR(MedicationsRequireInsIV),
    "CHECKBOX",
    [LLSTRING(SETTING_REQUIRE_INS_IV_Medications),LLSTRING(SETTING_REQUIRE_INS_IV_Medications_DESC)],
    "KAT - ADV Medical: Pharmacy",
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVreuse),
    "CHECKBOX",
    [LLSTRING(IV_REUSE)],
    "KAT - ADV Medical: Pharmacy",
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVmedic),
    "LIST",
    [LLSTRING(IV_MEDIC)],
    "KAT - ADV Medical: Pharmacy",
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVdropEnable),
    "CHECKBOX",
    [LLSTRING(IV_DROP_ENABLE)],
    "KAT - ADV Medical: Pharmacy",
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVdrop),
    "SLIDER",
    [LLSTRING(IV_DROP)],
    "KAT - ADV Medical: Pharmacy",
    [60, 1200, 600, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVestablish),
    "SLIDER",
    [LLSTRING(IV_TIME)],
    "KAT - ADV Medical: Pharmacy",
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IOestablish),
    "SLIDER",
    [LLSTRING(IO_TIME)],
    "KAT - ADV Medical: Pharmacy",
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(PushTime),
    "SLIDER",
    [LLSTRING(PUSH_TIME)],
    "KAT - ADV Medical: Pharmacy",
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(Reorientation_Enable),
    "CHECKBOX",
    [LLSTRING(SETTING_Reorientation_Enable), LLSTRING(SETTING_Reorientation_Enable_DESC)],
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(medLvl_Reorientation),
    "LIST",
    [LLSTRING(SETTING_Allow_Reorientation),LLSTRING(Allow_Reorientation_DESC)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(Reorientation_Slap),
    "CHECKBOX",
    [LLSTRING(SETTING_Reorientation_Slap), LLSTRING(SETTING_Reorientation_Slap_DESC)],
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

[
	QGVAR(kidneyAction),
	"CHECKBOX",
	[LLSTRING(SETTING_Kidney_Action), LLSTRING(SETTING_Kidney_Action_DESC)],
	CBA_SETTINGS_CAT,
	[false],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(aiEnableAdvanced),
	"CHECKBOX",
	[LLSTRING(SETTING_aiEnabled), LLSTRING(SETTING_aiEnabled_DESC)],
	CBA_SETTINGS_CAT,
	[false],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(blockChance),
	"SLIDER",
	[LLSTRING(SETTING_Block_Chance), LLSTRING(SETTING_Block_Chance_DESC)],
	CBA_SETTINGS_CAT,
	[0, 100, 20, 0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(maxStack),
	"SLIDER",
	[LLSTRING(SETTING_Max_Stack), LLSTRING(SETTING_Max_Stack_DESC)],
	CBA_SETTINGS_CAT,
	[1, 10, 5, 0],
	true
] call CBA_Settings_fnc_init;

[
	QGVAR(ivCheckLimbDamage),
	"CHECKBOX",
	[LLSTRING(SETTING_ivCheckLimbDamage), LLSTRING(SETTING_ivCheckLimbDamage_DESC)],
	CBA_SETTINGS_CAT,
	[false],
	true
] call CBA_Settings_fnc_init;

ADDON = true;
