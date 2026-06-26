
// =============== Protection & Gear ===============
[
    QGVAR(availGasmask),
    "EDITBOX",
    [LLSTRING(SETTING_AVAIL_GASMASK), LLSTRING(SETTING_AVAIL_GASMASK_DISC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Protection)],
    "'G_AirPurifyingRespirator_01_F', 'kat_mask_M50', 'kat_mask_M04'",
    1,
    {
        private _array = [_this, "CfgGlasses"] call FUNC(getList);
        missionNamespace setVariable [QGVAR(availGasmaskList), _array, true];
    },
    true
] call CBA_fnc_addSetting;

[
    QGVAR(gasmask_durability),
    "TIME",
    [LLSTRING(SETTING_GASMASK_DURABILITY), LLSTRING(SETTING_GASMASK_DURABILITY_DISC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Protection)],
    [1, 3600, 900],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(gasMaskSoundVolume),
    "SLIDER",
    [LLSTRING(SETTING_gasMaskSoundVolume), LLSTRING(SETTING_gasMaskSoundVolume_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Protection)],
    [0, 2, 1, 1],
    2,
    {
        player setVariable [QGVAR(gasMaskSoundVolume), _this, true];
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(maskStaminaLoss),
    "CHECKBOX",
    [LLSTRING(SETTING_gasMaskStaminaLoss), LLSTRING(SETTING_gasMaskStaminaLoss_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Protection)],
    [false],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(availCBRNUniform),
    "EDITBOX",
    [LLSTRING(SETTING_AVAIL_CBRN), LLSTRING(SETTING_AVAIL_CBRN_DISC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Protection)],
    "'U_C_CBRN_Suit_01_Blue_F'",
    1,
    {
        private _array = [_this, "CfgWeapons"] call FUNC(getList);
        missionNamespace setVariable [QGVAR(availCBRNUniformList), _array, true];
    },
    true
] call CBA_fnc_addSetting;

[
    QGVAR(showPoisoning),
    "CHECKBOX",
    [LLSTRING(SETTING_showPoisoning), LLSTRING(SETTING_showPoisoning_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Protection)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableSmellHint),
    "CHECKBOX",
    [LLSTRING(SETTING_enableSmellHint), LLSTRING(SETTING_enableSmellHint_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Protection)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableParticleEffects),
    "CHECKBOX",
    [LLSTRING(SETTING_enableParticleEffects), LLSTRING(SETTING_enableParticleEffects_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Protection)],
    [true],
    true
] call CBA_fnc_addSetting;

// =============== CS Gas (Level 0) ===============
[
    QGVAR(tearGasDropChance),
    "SLIDER",
    [LLSTRING(SETTING_dropWeaponChance), LLSTRING(SETTING_dropWeaponChance_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CS)],
    [0, 1, 0, 2, true],
    true
] call CBA_fnc_addSetting;

// =============== Chlorine (Level 1) ===============
[
    QGVAR(chlorine_onsetTime),
    "TIME",
    [LLSTRING(SETTING_chlorine_onsetTime), LLSTRING(SETTING_chlorine_onsetTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Chlorine)],
    [0, 3600, 30],
    true
] call CBA_fnc_addSetting;

// =============== Phosgene (Level 1) ===============
[
    QGVAR(phosgene_onsetMin),
    "TIME",
    [LLSTRING(SETTING_phosgene_onsetMin), LLSTRING(SETTING_phosgene_onsetMin_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Phosgene)],
    [0, 3600, 120],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(phosgene_onsetMax),
    "TIME",
    [LLSTRING(SETTING_phosgene_onsetMax), LLSTRING(SETTING_phosgene_onsetMax_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Phosgene)],
    [0, 3600, 360],
    true
] call CBA_fnc_addSetting;

// =============== Mustard (Level 2) ===============
[
    QGVAR(mustard_eyeOnsetMin),
    "TIME",
    [LLSTRING(SETTING_mustard_eyeOnsetMin), LLSTRING(SETTING_mustard_eyeOnsetMin_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Mustard)],
    [0, 3600, 40],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(mustard_eyeOnsetMax),
    "TIME",
    [LLSTRING(SETTING_mustard_eyeOnsetMax), LLSTRING(SETTING_mustard_eyeOnsetMax_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Mustard)],
    [0, 3600, 100],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(mustard_burnOnsetMin),
    "TIME",
    [LLSTRING(SETTING_mustard_burnOnsetMin), LLSTRING(SETTING_mustard_burnOnsetMin_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Mustard)],
    [0, 3600, 100],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(mustard_burnOnsetMax),
    "TIME",
    [LLSTRING(SETTING_mustard_burnOnsetMax), LLSTRING(SETTING_mustard_burnOnsetMax_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Mustard)],
    [0, 3600, 240],
    true
] call CBA_fnc_addSetting;

// =============== Sarin (Level 2) ===============
[
    QGVAR(sarin_vomitTime),
    "TIME",
    [LLSTRING(SETTING_sarin_vomitTime), LLSTRING(SETTING_sarin_vomitTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Sarin)],
    [0, 3600, 30],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(sarin_unconsciousTime),
    "TIME",
    [LLSTRING(SETTING_sarin_unconsciousTime), LLSTRING(SETTING_sarin_unconsciousTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Sarin)],
    [0, 3600, 60],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(sarin_cardiacArrestTime),
    "TIME",
    [LLSTRING(SETTING_sarin_cardiacArrestTime), LLSTRING(SETTING_sarin_cardiacArrestTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Sarin)],
    [0, 3600, 90],
    true
] call CBA_fnc_addSetting;

// =============== VX (Level 2) ===============
[
    QGVAR(vx_vomitTime),
    "TIME",
    [LLSTRING(SETTING_vx_vomitTime), LLSTRING(SETTING_vx_vomitTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_VX)],
    [0, 3600, 60],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(vx_unconsciousTime),
    "TIME",
    [LLSTRING(SETTING_vx_unconsciousTime), LLSTRING(SETTING_vx_unconsciousTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_VX)],
    [0, 3600, 120],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(vx_cardiacArrestTime),
    "TIME",
    [LLSTRING(SETTING_vx_cardiacArrestTime), LLSTRING(SETTING_vx_cardiacArrestTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_VX)],
    [0, 3600, 240],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(vx_cloudLifetime),
    "TIME",
    [LLSTRING(SETTING_vx_cloudLifetime), LLSTRING(SETTING_vx_cloudLifetime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_VX)],
    [0, 3600, 600],
    true
] call CBA_fnc_addSetting;

// =============== Contamination & Decontamination ===============
[
    QGVAR(contaminationTickInterval),
    "TIME",
    [LLSTRING(SETTING_contaminationTickInterval), LLSTRING(SETTING_contaminationTickInterval_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Contamination)],
    [1, 3600, 40],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(deconActionTime),
    "TIME",
    [LLSTRING(SETTING_deconActionTime), LLSTRING(SETTING_deconActionTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Contamination)],
    [1, 600, 8],
    true
] call CBA_fnc_addSetting;

// =============== Identification (Detector & M8 Paper) ===============
[
    QGVAR(m8PaperActionTime),
    "TIME",
    [LLSTRING(SETTING_m8PaperActionTime), LLSTRING(SETTING_m8PaperActionTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Identification)],
    [1, 600, 3],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(cloudIdMemoryTime),
    "TIME",
    [LLSTRING(SETTING_cloudIdMemoryTime), LLSTRING(SETTING_cloudIdMemoryTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Identification)],
    [0, 3600, 30],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(m8PaperDisplayTime),
    "TIME",
    [LLSTRING(SETTING_m8PaperDisplayTime), LLSTRING(SETTING_m8PaperDisplayTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Identification)],
    [1, 600, 8],
    true
] call CBA_fnc_addSetting;

// =============== Radiation ===============
[
    QGVAR(rad_enable),
    "CHECKBOX",
    [LLSTRING(SETTING_rad_enable), LLSTRING(SETTING_rad_enable_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_showSickness),
    "CHECKBOX",
    [LLSTRING(SETTING_rad_showSickness), LLSTRING(SETTING_rad_showSickness_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_doseThreshold_mild),
    "SLIDER",
    [LLSTRING(SETTING_rad_doseThreshold_mild), LLSTRING(SETTING_rad_doseThreshold_mild_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 30, 1, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_doseThreshold_moderate),
    "SLIDER",
    [LLSTRING(SETTING_rad_doseThreshold_moderate), LLSTRING(SETTING_rad_doseThreshold_moderate_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 30, 2, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_doseThreshold_severe),
    "SLIDER",
    [LLSTRING(SETTING_rad_doseThreshold_severe), LLSTRING(SETTING_rad_doseThreshold_severe_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 30, 4, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_doseThreshold_lethal),
    "SLIDER",
    [LLSTRING(SETTING_rad_doseThreshold_lethal), LLSTRING(SETTING_rad_doseThreshold_lethal_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 30, 6, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_prodromalDelay),
    "TIME",
    [LLSTRING(SETTING_rad_prodromalDelay), LLSTRING(SETTING_rad_prodromalDelay_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 3600, 120],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_hemaDelay),
    "TIME",
    [LLSTRING(SETTING_rad_hemaDelay), LLSTRING(SETTING_rad_hemaDelay_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 7200, 600],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_giDelay),
    "TIME",
    [LLSTRING(SETTING_rad_giDelay), LLSTRING(SETTING_rad_giDelay_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 7200, 480],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_cnsDelay),
    "TIME",
    [LLSTRING(SETTING_rad_cnsDelay), LLSTRING(SETTING_rad_cnsDelay_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 3600, 180],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_cardiacDelay),
    "TIME",
    [LLSTRING(SETTING_rad_cardiacDelay), LLSTRING(SETTING_rad_cardiacDelay_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 3600, 300],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_protectionFactorMask),
    "SLIDER",
    [LLSTRING(SETTING_rad_protectionFactorMask), LLSTRING(SETTING_rad_protectionFactorMask_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 1, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_protectionFactorCBRN),
    "SLIDER",
    [LLSTRING(SETTING_rad_protectionFactorCBRN), LLSTRING(SETTING_rad_protectionFactorCBRN_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 1, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_protectionFactorRadGear),
    "SLIDER",
    [LLSTRING(SETTING_rad_protectionFactorRadGear), LLSTRING(SETTING_rad_protectionFactorRadGear_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 1, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_protectionFactorVehicle),
    "SLIDER",
    [LLSTRING(SETTING_rad_protectionFactorVehicle), LLSTRING(SETTING_rad_protectionFactorVehicle_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 1, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(availRadProtection),
    "EDITBOX",
    [LLSTRING(SETTING_availRadProtection), LLSTRING(SETTING_availRadProtection_DISC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    "",
    1,
    {
        private _array = [_this, "CfgWeapons"] call FUNC(getList);
        missionNamespace setVariable [QGVAR(availRadProtectionList), _array, true];
    },
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_kiFactor),
    "SLIDER",
    [LLSTRING(SETTING_rad_kiFactor), LLSTRING(SETTING_rad_kiFactor_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 0.5, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_kiDuration),
    "TIME",
    [LLSTRING(SETTING_rad_kiDuration), LLSTRING(SETTING_rad_kiDuration_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 14400, 3600],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_inhalationFactor),
    "SLIDER",
    [LLSTRING(SETTING_rad_inhalationFactor), LLSTRING(SETTING_rad_inhalationFactor_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 2, 0.1, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_internalConversionRate),
    "SLIDER",
    [LLSTRING(SETTING_rad_internalConversionRate), LLSTRING(SETTING_rad_internalConversionRate_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 0.001, 4],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_internalDecayRate),
    "SLIDER",
    [LLSTRING(SETTING_rad_internalDecayRate), LLSTRING(SETTING_rad_internalDecayRate_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 0.0005, 4],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_chelationDuration),
    "TIME",
    [LLSTRING(SETTING_rad_chelationDuration), LLSTRING(SETTING_rad_chelationDuration_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 14400, 600],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_chelationFactor),
    "SLIDER",
    [LLSTRING(SETTING_rad_chelationFactor), LLSTRING(SETTING_rad_chelationFactor_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [1, 50, 5, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_contaminationDeposition),
    "SLIDER",
    [LLSTRING(SETTING_rad_contaminationDeposition), LLSTRING(SETTING_rad_contaminationDeposition_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 0.02, 3],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_contaminationDecay),
    "SLIDER",
    [LLSTRING(SETTING_rad_contaminationDecay), LLSTRING(SETTING_rad_contaminationDecay_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 0.002, 4],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_crossContamStrength),
    "SLIDER",
    [LLSTRING(SETTING_rad_crossContamStrength), LLSTRING(SETTING_rad_crossContamStrength_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 50, 5, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_localProximity),
    "SLIDER",
    [LLSTRING(SETTING_rad_localProximity), LLSTRING(SETTING_rad_localProximity_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 5, 1.5, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_skinBurnThreshold),
    "SLIDER",
    [LLSTRING(SETTING_rad_skinBurnThreshold), LLSTRING(SETTING_rad_skinBurnThreshold_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [1, 50, 5, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_marrowAnemiaRate),
    "SLIDER",
    [LLSTRING(SETTING_rad_marrowAnemiaRate), LLSTRING(SETTING_rad_marrowAnemiaRate_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 20, 2, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_giFluidLossRate),
    "SLIDER",
    [LLSTRING(SETTING_rad_giFluidLossRate), LLSTRING(SETTING_rad_giFluidLossRate_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 30, 3, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_giAcidosisRate),
    "SLIDER",
    [LLSTRING(SETTING_rad_giAcidosisRate), LLSTRING(SETTING_rad_giAcidosisRate_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 0.05, 3],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_cnsHypotension),
    "SLIDER",
    [LLSTRING(SETTING_rad_cnsHypotension), LLSTRING(SETTING_rad_cnsHypotension_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 100, 40, 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_feverMax),
    "SLIDER",
    [LLSTRING(SETTING_rad_feverMax), LLSTRING(SETTING_rad_feverMax_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 5, 2, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_recoveryRate),
    "SLIDER",
    [LLSTRING(SETTING_rad_recoveryRate), LLSTRING(SETTING_rad_recoveryRate_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 0.5, 0.01, 3],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_visualEffect),
    "CHECKBOX",
    [LLSTRING(SETTING_rad_visualEffect), LLSTRING(SETTING_rad_visualEffect_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_infectionEnable),
    "CHECKBOX",
    [LLSTRING(SETTING_rad_infectionEnable), LLSTRING(SETTING_rad_infectionEnable_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_infectionChance),
    "SLIDER",
    [LLSTRING(SETTING_rad_infectionChance), LLSTRING(SETTING_rad_infectionChance_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 1, 0.05, 3],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_infectionSeverityRate),
    "SLIDER",
    [LLSTRING(SETTING_rad_infectionSeverityRate), LLSTRING(SETTING_rad_infectionSeverityRate_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 0.5, 0.02, 3],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_infectionDamageRate),
    "SLIDER",
    [LLSTRING(SETTING_rad_infectionDamageRate), LLSTRING(SETTING_rad_infectionDamageRate_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 50, 15, 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_antibioticDuration),
    "TIME",
    [LLSTRING(SETTING_rad_antibioticDuration), LLSTRING(SETTING_rad_antibioticDuration_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 14400, 600],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_antiemeticDuration),
    "TIME",
    [LLSTRING(SETTING_rad_antiemeticDuration), LLSTRING(SETTING_rad_antiemeticDuration_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 14400, 900],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_filgrastimDuration),
    "TIME",
    [LLSTRING(SETTING_rad_filgrastimDuration), LLSTRING(SETTING_rad_filgrastimDuration_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [0, 14400, 1800],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(rad_filgrastimFactor),
    "SLIDER",
    [LLSTRING(SETTING_rad_filgrastimFactor), LLSTRING(SETTING_rad_filgrastimFactor_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Radiation)],
    [1, 10, 3, 1],
    true
] call CBA_fnc_addSetting;
