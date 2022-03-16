#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Breathing"

//Enable breathing
[
    QGVAR(enable),
    "CHECKBOX",
    LLSTRING(SETTING_ENABLE),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

// Lethal SpO2 value
[
    QGVAR(SpO2_dieValue),
    "SLIDER",
    LLSTRING(SETTING_SpO2_dieValue),
    CBA_SETTINGS_CAT,
    [5, 95, 80, 0],
    true
] call CBA_Settings_fnc_init;

// Enables death in cause of SpO2 lethal value
[
    QGVAR(SpO2_dieActive),
    "CHECKBOX",
	LLSTRING(SETTING_SpO2_dieActive),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 add value
[
    QGVAR(SpO2_MultiplyPositive),
    "SLIDER",
    LLSTRING(SETTING_MultiplyPositive),
    CBA_SETTINGS_CAT,
    [0, 10, 1, 1],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 remove value
[
    QGVAR(SpO2_MultiplyNegative),
    "SLIDER",
    LLSTRING(SETTING_MultiplyNegative),
    CBA_SETTINGS_CAT,
    [0, 10, 1, 1],
    true
] call CBA_Settings_fnc_init;

// SpO2 value for stability determination
[
    QGVAR(Stable_spo2),
    "SLIDER",
    [LLSTRING(SETTING_STABLE_SPO2), LLSTRING(DESCRIPTION_STABLE_SPO2)],
    CBA_SETTINGS_CAT,
    [0, 95, 65, 0],
    true
] call CBA_Settings_fnc_init;

// changes whether SpO2 falls during cardiac arrest
[
    QGVAR(SpO2_perfusion),
    "CHECKBOX",
    LLSTRING(SETTING_SpO2_Perfusion),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

// breathing probability for a pneumothorax
// a pneumothorax is the presence of air or gas in the cavity between the lungs and the chest wall
[
    QGVAR(pneumothorax),
    "SLIDER",
    LLSTRING(SETTING_pneumothorax),
    CBA_SETTINGS_CAT,
    [0, 100, 5, 0],
    true
] call CBA_Settings_fnc_init;

//Settable list for using Pulseoximeter per medical class
[
    QGVAR(medLvl_Pulseoximeter),
    "LIST",
    [LLSTRING(ALLOW_PULSEOXIMETER), LLSTRING(TRAININGLEVEL_PULSEOXIMETER)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 0],
    true
] call CBA_settings_fnc_init;

//Settable list for using Chestseal per medical class
[
    QGVAR(medLvl_Chestseal),
    "LIST",
    [LLSTRING(ALLOW_CHESTSEAL), LLSTRING(TRAININGLEVEL_CHESTSEAL)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
    true
] call CBA_settings_fnc_init;

//Allow ChestSeal SelfTreatment
[
    QGVAR(enable_selfChestseal),
    "LIST",
    LLSTRING(SETTING_SELF_CHESTSEAL),
    CBA_SETTINGS_CAT,
    [[0, 1], ["STR_ACE_common_No", "STR_ACE_common_Yes"], 1],
    true
] call CBA_Settings_fnc_init;

// % Chance of Hemopneumothorax
[
    QGVAR(hemopneumothoraxChance),
    "SLIDER",
    [LLSTRING(HEMOPNEUMOTHORAX_CHANCE_OPTION), LLSTRING(DESCRIPTION_HEMOPNEUMOTHORAX_CHANCE_OPTION)],
    CBA_SETTINGS_CAT,
    [0, 95, 5, 0, false],
    true
] call CBA_Settings_fnc_init;

//Settable list for using Pulseoximeter per medical class
[
    QGVAR(medLvl_hemopneumothoraxTreatment),
    "LIST",
    [LLSTRING(HEMOPNEUMOTHORAX_TREATMENT_LEVEL), LLSTRING(HEMOPNEUMOTHORAX_TREATMENT_LEVEL_DESCRIPTION)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
    true
] call CBA_settings_fnc_init;

//Damage Threshold for Pneumothorax
[
    QGVAR(pneumothoraxDamageThreshold),
    "SLIDER",
    [LLSTRING(PNEUMOTHORAX_DAMAGE_THRESHOLD), LLSTRING(PNEUMOTHORAX_DAMAGE_THRESHOLD_DESCRIPTION)],
    CBA_SETTINGS_CAT,
    [0, 1, 0.4, 1],
    true
] call CBA_Settings_fnc_init;

// Enables hardcore mod for pneumothorax by not making it appear in medical menu - Stethoscope might help
[
    QGVAR(pneumothorax_hardcore),
    "CHECKBOX",
    [LLSTRING(SETTING_pneumothorax_hardcore), LLSTRING(SETTING_pneumothorax_hardcore_DESC)],
    CBA_SETTINGS_CAT,
    [false],
    true
] call CBA_Settings_fnc_init;

// Enables hardcore mod for tension and hemopneumothorax by not making it appear in medical menu - Stethoscope might help
[
    QGVAR(tensionhemothorax_hardcore),
    "CHECKBOX",
    [LLSTRING(SETTING_tensionhemothorax_hardcore), LLSTRING(SETTING_tensionhemothorax_hardcore_DESC)],
    CBA_SETTINGS_CAT,
    [false],
    true
] call CBA_Settings_fnc_init;

// sound volume for Stethoscope
/*
[
    QGVAR(StethoscopeSoundVolume),
    "SLIDER",
    [LLSTRING(SETTING_StethoscopeSoundVolume), LLSTRING(DESCRIPTION_StethoscopeSoundVolume)],
    CBA_SETTINGS_CAT,
    [1, 4, 1, 0],
    true
] call CBA_Settings_fnc_init;
*/

ADDON = true;
