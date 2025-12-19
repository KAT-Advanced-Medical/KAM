
//Enable breathing
[
    QGVAR(enable),
    "CHECKBOX",
    [LLSTRING(SETTING_ENABLE),LLSTRING(SETTING_ENABLE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_fnc_addSetting;

//Adds available oxygen masks
[
    QGVAR(availOxyMask),
    "EDITBOX",
    [LLSTRING(SETTING_AVAIL_OXYMASK), LLSTRING(SETTING_AVAIL_OXYMASK_DISC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    "'kat_mask_solr'",
    1,
    {
        private _array = [_this, "CfgGlasses"] call FUNC(getList);
        missionNamespace setVariable [QGVAR(availOxyMaskList), _array, true];
    },
    true
] call CBA_fnc_addSetting;

//Adds available oxygen helmets
[
    QGVAR(availOxyHelmet),
    "EDITBOX",
    [LLSTRING(SETTING_AVAIL_OXYHELMET), LLSTRING(SETTING_AVAIL_OXYHELMET_DISC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    "'H_PilotHelmetFighter_B', 'H_PilotHelmetFighter_O', 'H_PilotHelmetFighter_I', 'H_PilotHelmetFighter_I_E'",
    1,
    {
        private _array = [_this, "CfgWeapons"] call FUNC(getList);
        missionNamespace setVariable [QGVAR(availOxyHelmetList), _array, true];
    },
    true
] call CBA_fnc_addSetting;

//Enable Check Breathing medical action
[
    QGVAR(enableCheckBreathing),
    "CHECKBOX",
    [LLSTRING(SETTING_enableCheckBreathing),LLSTRING(SETTING_enableCheckBreathing_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_fnc_addSetting;

// Lethal SpO2 value
[
    QGVAR(SpO2_dieValue),
    "SLIDER",
    LLSTRING(SETTING_SpO2_dieValue),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [5, 95, 65, 0],
    true
] call CBA_fnc_addSetting;

// Enables death in cause of SpO2 lethal value
[
    QGVAR(SpO2_dieActive),
    "CHECKBOX",
    LLSTRING(SETTING_SpO2_dieActive),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_fnc_addSetting;

// Cardiac Arrest SpO2 value
[
    QGVAR(SpO2_cardiacValue),
    "SLIDER",
    LLSTRING(SETTING_SpO2_cardiacValue),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 100, 75, 0],
    true
] call CBA_fnc_addSetting;

// Enables cardiac arrest in cause of SpO2 cardiac value
[
    QGVAR(SpO2_cardiacActive),
    "CHECKBOX",
    LLSTRING(SETTING_SpO2_cardiacActive),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_fnc_addSetting;

// Turn to unconscious in cause of SpO2 unconscious value
[
    QGVAR(SpO2_unconscious),
    "SLIDER",
    [LLSTRING(SETTING_SpO2_unconscious), LLSTRING(SETTING_SpO2_unconscious_Desc)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 100, 75, 0],
    true
] call CBA_fnc_addSetting;

// breathing SpO2 add value
[
    QGVAR(SpO2_MultiplyPositive),
    "SLIDER",
    LLSTRING(SETTING_MultiplyPositive),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 10, 1, 1],
    true
] call CBA_fnc_addSetting;

// breathing SpO2 remove value
[
    QGVAR(SpO2_MultiplyNegative),
    "SLIDER",
    LLSTRING(SETTING_MultiplyNegative),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 10, 1, 1],
    true
] call CBA_fnc_addSetting;

// SpO2 value for stability determination
[
    QGVAR(Stable_spo2),
    "SLIDER",
    [LLSTRING(SETTING_STABLE_SPO2), LLSTRING(DESCRIPTION_STABLE_SPO2)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 95, 85, 0],
    true
] call CBA_fnc_addSetting;

// changes whether SpO2 falls during cardiac arrest
[
    QGVAR(SpO2_perfusion),
    "CHECKBOX",
    LLSTRING(SETTING_SpO2_Perfusion),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_fnc_addSetting;

// breathing SpO2 perfusion multiplier
[
    QGVAR(SpO2_PerfusionMultiplier),
    "SLIDER",
    LLSTRING(SETTING_PerfusionMultiplier),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 10, 1, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(paco2Active),
    "CHECKBOX",
    [LLSTRING(SETTING_PACO2_ENABLE), LLSTRING(SETTING_PACO2_ENABLE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_fnc_addSetting;

//Settable list for using Pulseoximeter per medical class
[
    QGVAR(medLvl_Pulseoximeter),
    "LIST",
    [LLSTRING(ALLOW_PULSEOXIMETER), LLSTRING(TRAININGLEVEL_PULSEOXIMETER)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;

//Settable list for using Chestseal per medical class
[
    QGVAR(medLvl_Chestseal),
    "LIST",
    [LLSTRING(ALLOW_CHESTSEAL), LLSTRING(TRAININGLEVEL_CHESTSEAL)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;

//Settable list for using Nasal Cannula per medical class
[
    QGVAR(medLvl_NasalCannula),
    "LIST",
    [LLSTRING(SETTING_Allow_NasalCannula),LLSTRING(SETTING_Allow_NasalCannula_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;

// Settable action time for Nasal Cannula
[
    QGVAR(NasalCannula_time),
    "SLIDER",
    [LLSTRING(SETTING_Time_NasalCannula),LLSTRING(SETTING_Time_NasalCannula_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [1, 10, 3, 0],
    true
] call CBA_fnc_addSetting;

//Allow ChestSeal SelfTreatment
[
    QGVAR(enable_selfChestseal),
    "LIST",
    LLSTRING(SETTING_SELF_CHESTSEAL),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1], ["STR_ACE_common_No", "STR_ACE_common_Yes"], 1],
    true
] call CBA_fnc_addSetting;

// Clear Chest Seal from medical menu after treatment
[
    QGVAR(clearChestSealAfterTreatment),
    "CHECKBOX",
    LLSTRING(SETTING_clearChestSealAfterTreatment),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [false],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(chestSealTreatmentLoopTime),
    "SLIDER",
    [LLSTRING(ChestSealLoopTime), LLSTRING(ChestSealLoopTime_desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [1, 120, 30, 1],
    true
] call CBA_fnc_addSetting;

// Sets SpO2 level threshold for audible warning
[
    QGVAR(PulseOximeter_SpO2Warning),
    "SLIDER",
    LLSTRING(SETTING_Threshold_SpO2Warning),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [1, 100, 85, 1],
    true
] call CBA_fnc_addSetting;

// breathing probability for a pneumothorax
// a pneumothorax is the presence of air or gas in the cavity between the lungs and the chest wall
[
    QGVAR(pneumothoraxChance),
    "SLIDER",
    LLSTRING(SETTING_pneumothorax),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 100, 5, 0],
    true
] call CBA_fnc_addSetting;


// % Chance of Hemopneumothorax and Tension Pneumothorax happening when a Pneumothorax happens
[
    QGVAR(advPtxChance),
    "SLIDER",
    [LLSTRING(ADVANCED_PTX_CHANCE_OPTION), LLSTRING(DESCRIPTION_ADVANCED_PTX_CHANCE_OPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 100, 5, 0, false],
    true
] call CBA_fnc_addSetting;

// % Chance of Hemopneumothorax (rest of % is chance for tension)
[
    QGVAR(hptxChance),
    "SLIDER",
    [LLSTRING(HEMOPNEUMOTHORAX_CHANCE_OPTION), LLSTRING(DESCRIPTION_HEMOPNEUMOTHORAX_CHANCE_OPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 100, 5, 0, false],
    true
] call CBA_fnc_addSetting;

//Enable Advanced Pneumothorax
[
    QGVAR(advPtxEnable),
    "CHECKBOX",
    [LLSTRING(ADVANCED_PTX_OPTION), LLSTRING(DESCRIPTION_ADVANCED_PTX_OPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [false],
    true
] call CBA_fnc_addSetting;

//Settable list for using Pulseoximeter per medical class

[
    QGVAR(medLvl_tensionpneumothoraxTreatment),
    "LIST",
    [LLSTRING(TENSIONPNEUMOTHORAX_TREATMENT_LEVEL), LLSTRING(TENSIONPNEUMOTHORAX_TREATMENT_LEVEL_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 1],
    true
] call CBA_fnc_addSetting;


//Damage Threshold for Pneumothorax
[
    QGVAR(pneumothoraxDamageThreshold),
    "SLIDER",
    [LLSTRING(PNEUMOTHORAX_DAMAGE_THRESHOLD), LLSTRING(PNEUMOTHORAX_DAMAGE_THRESHOLD_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 1, 0.4, 2],
    true
] call CBA_fnc_addSetting;

// Sets if damage above pneumothorax damage threshold increases chance of inflicting pneumothorax or advanced pneumothorax
[
    QGVAR(pneumothoraxDamageThreshold_TakenDamage),
    "CHECKBOX",
    [LLSTRING(SETTING_PneumothoraxDamageThreshold_DamageTaken), LLSTRING(SETTING_PneumothoraxDamageThreshold_DamageTaken_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [true],
    true
] call CBA_fnc_addSetting;

// Chance for deep penetrating injury to appear when pneumothorax damage threshold is passed but no pneumothorax is inflicted
[
    QGVAR(deepPenetratingInjuryChance),
    "SLIDER",
    [LLSTRING(SETTING_deepPenetratingInjuryChance), LLSTRING(SETTING_deepPenetratingInjuryChance_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 100, 30, 0, false],
    true
] call CBA_fnc_addSetting;

//Chance for pneumothorax to deteriorate into tension pneumothorax
[
    QGVAR(deterioratingPneumothorax_chance),
    "SLIDER",
    [LLSTRING(SETTING_deterioratingPneumothorax_chance), LLSTRING(SETTING_deterioratingPneumothorax_chance_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0, 100, 50, 0],
    true
] call CBA_fnc_addSetting;

//Deteriorating pneumothorax countdown
[
    QGVAR(deterioratingPneumothorax_interval),
    "SLIDER",
    [LLSTRING(SETTING_deterioratingPneumothorax_interval), LLSTRING(SETTING_deterioratingPneumothorax_interval_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [1, 3600, 60, 0],
    true
] call CBA_fnc_addSetting;

//Deteriorating pneumothorax arrest countdown
[
    QGVAR(PneumothoraxArrest),
    "CHECKBOX",
    [LLSTRING(SETTING_PneumothoraxArrest), LLSTRING(SETTING_PneumothoraxArrest_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [true],
    true
] call CBA_fnc_addSetting;

//Deteriorating pneumothorax arrest countdown
[
    QGVAR(arrestPneumothorax_interval),
    "SLIDER",
    [LLSTRING(SETTING_arrestPneumothorax_interval), LLSTRING(SETTING_arrestPneumothorax_interval_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [1, 3600, 30, 0],
    true
] call CBA_fnc_addSetting;

// Set if pneumothorax injury should always be visible in medical menu
[
    QGVAR(PneumothoraxAlwaysVisible),
    "CHECKBOX",
    [LLSTRING(SETTING_PneumothoraxAlwaysVisible), LLSTRING(SETTING_PneumothoraxAlwaysVisible_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [false],
    true
] call CBA_fnc_addSetting;

// Set if tension/hemopneumothorax injury should always be visible in medical menu
[
    QGVAR(TensionHemothoraxAlwaysVisible),
    "CHECKBOX",
    [LLSTRING(SETTING_TensionHemothoraxAlwaysVisible), LLSTRING(SETTING_TensionHemothoraxAlwaysVisible_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [false],
    true
] call CBA_fnc_addSetting;

// Default is disabled. If enabled, units with tension pneumothorax or hemopneumothorax will also have pneumothorax injury displayed in medical menu.
[
    QGVAR(showPneumothorax_dupe),
    "CHECKBOX",
    [LLSTRING(showPneumothorax_dupe),LLSTRING(showPneumothorax_dupe_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [false],
    true
] call CBA_fnc_addSetting;

// Sets if inspect chest action is enabled
[
    QGVAR(inspectChest_enable),
    "LIST",
    LLSTRING(SETTING_inspectChest_enable),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [[0, 1, 2], [ACELLSTRING(Common,Disabled), LLSTRING(SETTING_inspectChest_enable_simple), ACELLSTRING(Common,Enabled)], 2],
    true
] call CBA_fnc_addSetting;

// Sets medical level required to inspect chest
[
    QGVAR(inspectChest_medLvl),
    "LIST",
    LLSTRING(SETTING_inspectChest_medLvl),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;

// Sets chest inspect action time
[
    QGVAR(inspectChest_time),
    "SLIDER",
    [LLSTRING(SETTING_inspectChest_time)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [1, 60, 6, 1],
    true
] call CBA_fnc_addSetting;

// Shows cyanosis in medical menu
[
    QGVAR(showCyanosis),
    "CHECKBOX",
    [LLSTRING(SETTING_showCyanosis), LLSTRING(SETTING_showCyanosis_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Cyanosis)],
    [true],
    true
] call CBA_fnc_addSetting;

//Slight level for cyanosis
[
    QGVAR(slightValue),
    "SLIDER",
    [LLSTRING(SETTING_slightValue), LLSTRING(SETTING_slightValue_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Cyanosis)],
    [0, 100, 90, 1],
    true
] call CBA_fnc_addSetting;

//Mild level for cyanosis
[
    QGVAR(mildValue),
    "SLIDER",
    [LLSTRING(SETTING_mildValue), LLSTRING(SETTING_mildValue_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Cyanosis)],
    [0, 100, 75, 1],
    true
] call CBA_fnc_addSetting;

//Severe level for cyanosis
[
    QGVAR(severeValue),
    "SLIDER",
    [LLSTRING(SETTING_severeValue), LLSTRING(SETTING_severeValue_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Cyanosis)],
    [0, 100, 66, 1],
    true
] call CBA_fnc_addSetting;

//Enable stamina loss by low SPO2
[
    QGVAR(staminaLossAtLowSPO2),
    "CHECKBOX",
    [LLSTRING(SETTING_Stamina_Loss_SPO2_display), LLSTRING(SETTING_Stamina_Loss_SPO2_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
]   call CBA_fnc_addSetting;

// enable/disable etco2 and respiratory rate readouts
[
    QGVAR(Etco2_Enabled),
    "CHECKBOX",
    [LLSTRING(SETTING_Enable_Etco2),LLSTRING(SETTING_Enable_Etco2_Desc)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_fnc_addSetting;

// select units for etco2
[
    QGVAR(Etco2_Units),
    "LIST",
    LLSTRING(SETTING_Select_Etco2_Units),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [[0, 1], ["mmHg", "kPa"], 0],
    true
] call CBA_fnc_addSetting;

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
] call CBA_fnc_addSetting;

// Sets how long stethoscope listening action lasts
[
    QGVAR(stethoscopeListeningTime),
    "SLIDER",
    [LLSTRING(SETTING_stethoscopeListeningTime), LLSTRING(SETTING_stethoscopeListeningTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [1, 60, 15, 1],
    true
] call CBA_fnc_addSetting;

// Sets required medical level for BVM usage
[
    QGVAR(medLvl_BVM),
    "LIST",
    [LLSTRING(SETTING_BVM_MedLvl),LLSTRING(SETTING_BVM_MedLvl_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;

// Sets required medical level for Pocket BVM usage
[
    QGVAR(medLvl_PocketBVM),
    "LIST",
    [LLSTRING(SETTING_PocketBVM_MedLvl),LLSTRING(SETTING_PocketBVM_MedLvl_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;

// Sets required medical level for BVM with oxygen usage
[
    QGVAR(medLvl_BVM_Oxygen),
    "LIST",
    [LLSTRING(SETTING_BVM_Oxygen_MedLvl),LLSTRING(SETTING_BVM_Oxygen_MedLvl_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;

// Sets BVM oxygen effectiveness multiplier
[
    QGVAR(BVMOxygen_Multiplier),
    "SLIDER",
    LLSTRING(SETTING_BVMOxygen_Multiplier),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [1, 10, 1, 1],
    true
] call CBA_fnc_addSetting;

// Sets time required to refill oxygen tank
[
    QGVAR(PortableOxygenTank_RefillTime),
    "SLIDER",
    [LLSTRING(SETTING_PortableOxygenTank_RefillTime),LLSTRING(SETTING_PortableOxygenTank_RefillTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [0.1, 60, 5, 1],
    true
] call CBA_fnc_addSetting;

// Sets whether medical facilites and/or vehicles provide direct oxygen and refill capability
[
    QGVAR(locationProvideOxygen),
    "LIST",
    [LLSTRING(SETTING_locationProvideOxygen), LLSTRING(SETTING_locationProvideOxygen_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2, 3], ["STR_ACE_Common_None", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"], 3],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(medLvl_FingerThoracostomyTreatment),
    "LIST",
    LLSTRING(SETTING_FingerThoracostomyTreatment_medLvl),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(incisionTime),
    "SLIDER",
    LLSTRING(INCISION_TIMER),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0,100,10,0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(ChestTubeintermediateTime),
    "SLIDER",
    [LLSTRING(INTERMEDIATE_TIMER), LLSTRING(INTERMEDIATE_TIMER_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0,100,8,0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(openTime),
    "SLIDER",
    LLSTRING(OPEN_TIMER),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0,100,15,0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(chestTubeAction_MedLevel),
    "LIST",
    LLSTRING(CHESTTUBE_ACTION_MEDLEVEL),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(chestTubeLocation),
    "LIST",
    LLSTRING(CHESTTUBE_LOCATION),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],3],
    true
] call CBA_fnc_addSetting;

// 0 Surgery Causes Unconsciousness: If you do an incision (without anesthesia & sedative) patient will go into CA
// 1 Unconsciousness Required for Surgery: Surgery fails unless patient is unconscious, needs anesthesia
// 2 No Unconsciousness from Surgery: Patient can stay awake without anesthesia, causes pain
// 3 Surgery Anesthesia: The patient is able to stay awake through the entirety of the surgery. If Etomidate has not been applied, then the patient will go into CA.
[
    QGVAR(chestTube_ConsciousnessRequirement),
    "LIST",
    [LLSTRING(SETTING_ConsciousnessRequirement), LLSTRING(SETTING_ConsciousnessRequirement_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [[0, 1, 2, 3], [LLSTRING(SETTING_Causes_Unconsciousness), LLSTRING(SETTING_Unconsciousness_Required), LLSTRING(SETTING_No_Unconsciousness), LLSTRING(SETTING_Anesthesia)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(chestTubeDrainAmount),
    "SLIDER",
    [LLSTRING(chestTubeDrainAmount), LLSTRING(chestTubeDrainAmount_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ThoraxInjuries)],
    [0,100,15,0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(medLvl_Vent),
    "LIST",
    [LLSTRING(ALLOW_Vent), LLSTRING(TRAININGLEVEL_Vent)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;
