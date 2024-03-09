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
    [LLSTRING(SETTING_ENABLE),LLSTRING(SETTING_ENABLE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Lethal SpO2 value
[
    QGVAR(SpO2_dieValue),
    "SLIDER",
    LLSTRING(SETTING_SpO2_dieValue),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [5, 95, 65, 0],
    true
] call CBA_Settings_fnc_init;

// Enables death in cause of SpO2 lethal value
[
    QGVAR(SpO2_dieActive),
    "CHECKBOX",
    LLSTRING(SETTING_SpO2_dieActive),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Cardiac Arrest SpO2 value
[
    QGVAR(SpO2_cardiacValue),
    "SLIDER",
    LLSTRING(SETTING_SpO2_cardiacValue),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 100, 75, 0],
    true
] call CBA_Settings_fnc_init;

// Enables cardiac arrest in cause of SpO2 cardiac value
[
    QGVAR(SpO2_cardiacActive),
    "CHECKBOX",
    LLSTRING(SETTING_SpO2_cardiacActive),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

// Turn to unconscious in cause of SpO2 unconscious value
[
    QGVAR(SpO2_unconscious),
    "SLIDER",
    [LLSTRING(SETTING_SpO2_unconscious), LLSTRING(SETTING_SpO2_unconscious_Desc)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 100, 75, 0],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 add value
[
    QGVAR(SpO2_MultiplyPositive),
    "SLIDER",
    LLSTRING(SETTING_MultiplyPositive),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 10, 1, 1],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 remove value
[
    QGVAR(SpO2_MultiplyNegative),
    "SLIDER",
    LLSTRING(SETTING_MultiplyNegative),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 10, 1, 1],
    true
] call CBA_Settings_fnc_init;

// SpO2 value for stability determination
[
    QGVAR(Stable_spo2),
    "SLIDER",
    [LLSTRING(SETTING_STABLE_SPO2), LLSTRING(DESCRIPTION_STABLE_SPO2)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 95, 85, 0],
    true
] call CBA_Settings_fnc_init;

// changes whether SpO2 falls during cardiac arrest
[
    QGVAR(SpO2_perfusion),
    "CHECKBOX",
    LLSTRING(SETTING_SpO2_Perfusion),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 perfusion multiplier
[
    QGVAR(SpO2_PerfusionMultiplier),
    "SLIDER",
    LLSTRING(SETTING_PerfusionMultiplier),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 10, 1, 1],
    true
] call CBA_Settings_fnc_init;

//Settable list for using Pulseoximeter per medical class
[
    QGVAR(medLvl_Pulseoximeter),
    "LIST",
    [LLSTRING(ALLOW_PULSEOXIMETER), LLSTRING(TRAININGLEVEL_PULSEOXIMETER)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

//Settable list for using Chestseal per medical class
[
    QGVAR(medLvl_Chestseal),
    "LIST",
    [LLSTRING(ALLOW_CHESTSEAL), LLSTRING(TRAININGLEVEL_CHESTSEAL)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

//Allow ChestSeal SelfTreatment
[
    QGVAR(enable_selfChestseal),
    "LIST",
    LLSTRING(SETTING_SELF_CHESTSEAL),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1], ["STR_ACE_common_No", "STR_ACE_common_Yes"], 1],
    true
] call CBA_Settings_fnc_init;

// Clear Chest Seal from medical menu after treatment
[
    QGVAR(clearChestSealAfterTreatment),
    "CHECKBOX",
    LLSTRING(SETTING_clearChestSealAfterTreatment),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [false],
    true
] call CBA_Settings_fnc_init;

// Sets SpO2 level threshold for audible warning
[
    QGVAR(PulseOximeter_SpO2Warning),
    "SLIDER",
    LLSTRING(SETTING_Threshold_SpO2Warning),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [1, 100, 85, 1],
    true
] call CBA_Settings_fnc_init;

// breathing probability for a pneumothorax
// a pneumothorax is the presence of air or gas in the cavity between the lungs and the chest wall
[
    QGVAR(pneumothoraxChance),
    "SLIDER",
    LLSTRING(SETTING_pneumothorax),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 100, 5, 0],
    true
] call CBA_Settings_fnc_init;

// % Chance of Hemopneumothorax and Tension Pneumothorax happening when a Pneumothorax happens
[
    QGVAR(advPtxChance),
    "SLIDER",
    [LLSTRING(ADVANCED_PTX_CHANCE_OPTION), LLSTRING(DESCRIPTION_ADVANCED_PTX_CHANCE_OPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 100, 5, 0, false],
    true
] call CBA_Settings_fnc_init;

// % Chance of Hemopneumothorax (rest of % is chance for tension)
[
    QGVAR(hptxChance),
    "SLIDER",
    [LLSTRING(HEMOPNEUMOTHORAX_CHANCE_OPTION), LLSTRING(DESCRIPTION_HEMOPNEUMOTHORAX_CHANCE_OPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 100, 5, 0, false],
    true
] call CBA_Settings_fnc_init;

//Enable Advanced Pneumothorax
[
    QGVAR(advPtxEnable),
    "CHECKBOX",
    [LLSTRING(ADVANCED_PTX_OPTION), LLSTRING(DESCRIPTION_ADVANCED_PTX_OPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [false],
    true
] call CBA_Settings_fnc_init;

//Settable list for using Pulseoximeter per medical class
[
    QGVAR(medLvl_hemopneumothoraxTreatment),
    "LIST",
    [LLSTRING(HEMOPNEUMOTHORAX_TREATMENT_LEVEL), LLSTRING(HEMOPNEUMOTHORAX_TREATMENT_LEVEL_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

//Damage Threshold for Pneumothorax
[
    QGVAR(pneumothoraxDamageThreshold),
    "SLIDER",
    [LLSTRING(PNEUMOTHORAX_DAMAGE_THRESHOLD), LLSTRING(PNEUMOTHORAX_DAMAGE_THRESHOLD_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 1, 0.4, 2],
    true
] call CBA_Settings_fnc_init;

// Sets if damage above pneumothorax damage threshold increases chance of inflicting pneumothorax or advanced pneumothorax
[
    QGVAR(pneumothoraxDamageThreshold_TakenDamage),
    "CHECKBOX",
    [LLSTRING(SETTING_PneumothoraxDamageThreshold_DamageTaken), LLSTRING(SETTING_PneumothoraxDamageThreshold_DamageTaken_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Chance for deep penetrating injury to appear when pneumothorax damage threshold is passed but no pneumothorax is inflicted
[
    QGVAR(deepPenetratingInjuryChance),
    "SLIDER",
    [LLSTRING(SETTING_deepPenetratingInjuryChance), LLSTRING(SETTING_deepPenetratingInjuryChance_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 100, 30, 0, false],
    true
] call CBA_Settings_fnc_init;

// Sets how much internal bleeding is applied while suffering from hemopneumothorax
[
    QGVAR(HPTXBleedAmount),
    "SLIDER",
    [LLSTRING(SETTING_HPTX_BleedAmount), LLSTRING(SETTING_HPTX_BleedAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 1, 0.06, 2],
    true
] call CBA_Settings_fnc_init;

//Chance for pneumothorax to deteriorate into tension pneumothorax
[
    QGVAR(deterioratingPneumothorax_chance),
    "SLIDER",
    [LLSTRING(SETTING_deterioratingPneumothorax_chance), LLSTRING(SETTING_deterioratingPneumothorax_chance_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 100, 50, 0],
    true
] call CBA_Settings_fnc_init;

//Deteriorating pneumothorax countdown
[
    QGVAR(deterioratingPneumothorax_interval),
    "SLIDER",
    [LLSTRING(SETTING_deterioratingPneumothorax_interval), LLSTRING(SETTING_deterioratingPneumothorax_interval_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [1, 3600, 60, 0],
    true
] call CBA_Settings_fnc_init;

//Deteriorating pneumothorax arrest countdown
[
    QGVAR(PneumothoraxArrest),
    "CHECKBOX",
    [LLSTRING(SETTING_PneumothoraxArrest), LLSTRING(SETTING_PneumothoraxArrest_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [true],
    true
] call CBA_Settings_fnc_init;

//Deteriorating pneumothorax arrest countdown
[
    QGVAR(arrestPneumothorax_interval),
    "SLIDER",
    [LLSTRING(SETTING_arrestPneumothorax_interval), LLSTRING(SETTING_arrestPneumothorax_interval_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [1, 3600, 30, 0],
    true
] call CBA_Settings_fnc_init;

// Set if pneumothorax injury should always be visible in medical menu
[
    QGVAR(PneumothoraxAlwaysVisible),
    "CHECKBOX",
    [LLSTRING(SETTING_PneumothoraxAlwaysVisible), LLSTRING(SETTING_PneumothoraxAlwaysVisible_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [false],
    true
] call CBA_Settings_fnc_init;

// Set if tension/hemopneumothorax injury should always be visible in medical menu
[
    QGVAR(TensionHemothoraxAlwaysVisible),
    "CHECKBOX",
    [LLSTRING(SETTING_TensionHemothoraxAlwaysVisible), LLSTRING(SETTING_TensionHemothoraxAlwaysVisible_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [false],
    true
] call CBA_Settings_fnc_init;

// Default is disabled. If enabled, units with tension pneumothorax or hemopneumothorax will also have pneumothorax injury displayed in medical menu.
[
    QGVAR(showPneumothorax_dupe),
    "CHECKBOX",
    [LLSTRING(showPneumothorax_dupe),LLSTRING(showPneumothorax_dupe_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [false],
    true
] call CBA_Settings_fnc_init;

// Sets if inspect chest action is enabled
[
    QGVAR(inspectChest_enable),
    "LIST",
    LLSTRING(SETTING_inspectChest_enable),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [[0, 1, 2], [ACELLSTRING(Common,Disabled), LLSTRING(SETTING_inspectChest_enable_simple), ACELLSTRING(Common,Enabled)], 2],
    true
] call CBA_Settings_fnc_init;

// Sets medical level required to inspect chest
[
    QGVAR(inspectChest_medLvl),
    "LIST",
    LLSTRING(SETTING_inspectChest_medLvl),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

// Sets chest inspect action time
[
    QGVAR(inspectChest_time),
    "SLIDER",
    [LLSTRING(SETTING_inspectChest_time)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [1, 60, 6, 1],
    true
] call CBA_Settings_fnc_init;

// Shows cyanosis in medical menu
[
    QGVAR(showCyanosis),
    "CHECKBOX",
    [LLSTRING(SETTING_showCyanosis), LLSTRING(SETTING_showCyanosis_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Cyanosis)],
    [true],
    true
] call CBA_Settings_fnc_init;

//Slight level for cyanosis
[
    QGVAR(slightValue),
    "SLIDER",
    [LLSTRING(SETTING_slightValue), LLSTRING(SETTING_slightValue_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Cyanosis)],
    [0, 100, 90, 1],
    true
] call CBA_Settings_fnc_init;

//Mild level for cyanosis
[
    QGVAR(mildValue),
    "SLIDER",
    [LLSTRING(SETTING_mildValue), LLSTRING(SETTING_mildValue_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Cyanosis)],
    [0, 100, 75, 1],
    true
] call CBA_Settings_fnc_init;

//Severe level for cyanosis
[
    QGVAR(severeValue),
    "SLIDER",
    [LLSTRING(SETTING_severeValue), LLSTRING(SETTING_severeValue_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Cyanosis)],
    [0, 100, 66, 1],
    true
] call CBA_Settings_fnc_init;

//Enables White Flashing on Below 90% SPO2
[
    QGVAR(enableSPO2Flashing),
    "CHECKBOX",
    [LLSTRING(SETTING_SPO2Flashing_display), LLSTRING(SETTING_SPO2Flashing_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

//Enable stamina loss by low SPO2
[
    QGVAR(staminaLossAtLowSPO2),
    "CHECKBOX",
    [LLSTRING(SETTING_Stamina_Loss_SPO2_display), LLSTRING(SETTING_Stamina_Loss_SPO2_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
]   call CBA_Settings_fnc_init;

//low SPO2 Warning Level
[
    QGVAR(lowSPO2Level),
    "SLIDER",
    [LLSTRING(SETTING_lowSPO2Level_display), LLSTRING(SETTING_lowSPO2Level_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 100, 90, 1],
    true
] call CBA_Settings_fnc_init;

// Sets sound volume of stethoscope
[
    QGVAR(stethoscopeSoundVolume),
    "SLIDER",
    [LLSTRING(SETTING_stethoscopeSoundVolume), LLSTRING(SETTING_stethoscopeSoundVolume_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [0, 4, 2, 1],
    2,
    {
        player setVariable [QGVAR(stethoscopeSoundVolume), _this, true];
    },
    false
] call CBA_Settings_fnc_init;

// Sets how long stethoscope listening action lasts
[
    QGVAR(stethoscopeListeningTime),
    "SLIDER",
    [LLSTRING(SETTING_stethoscopeListeningTime), LLSTRING(SETTING_stethoscopeListeningTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [1, 60, 15, 1],
    true
] call CBA_Settings_fnc_init;

// Sets required medical level for BVM usage
[
    QGVAR(medLvl_BVM),
    "LIST",
    [LLSTRING(SETTING_BVM_MedLvl),LLSTRING(SETTING_BVM_MedLvl_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

// Sets required medical level for Pocket BVM usage
[
    QGVAR(medLvl_PocketBVM),
    "LIST",
    [LLSTRING(SETTING_PocketBVM_MedLvl),LLSTRING(SETTING_PocketBVM_MedLvl_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

// Sets required medical level for BVM with oxygen usage
[
    QGVAR(medLvl_BVM_Oxygen),
    "LIST",
    [LLSTRING(SETTING_BVM_Oxygen_MedLvl),LLSTRING(SETTING_BVM_Oxygen_MedLvl_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

// Sets BVM oxygen effectiveness multiplier
[
    QGVAR(BVMOxygen_Multiplier),
    "SLIDER",
    LLSTRING(SETTING_BVMOxygen_Multiplier),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [1, 10, 1, 1],
    true
] call CBA_Settings_fnc_init;

// Sets time required to refill oxygen tank
[
    QGVAR(PortableOxygenTank_RefillTime),
    "SLIDER",
    [LLSTRING(SETTING_PortableOxygenTank_RefillTime),LLSTRING(SETTING_PortableOxygenTank_RefillTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [0.1, 60, 5, 1],
    true
] call CBA_settings_fnc_init;

// Sets whether medical facilites and/or vehicles provide direct oxygen and refill capability 
[
    QGVAR(locationProvideOxygen),
    "LIST",
    [LLSTRING(SETTING_locationProvideOxygen), LLSTRING(SETTING_locationProvideOxygen_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2, 3], ["STR_ACE_Common_None", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"], 3],
    true
] call CBA_settings_fnc_init;

ADDON = true;
