
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
    QGVAR(csDuration),
    "TIME",
    [LLSTRING(SETTING_csDuration), LLSTRING(SETTING_csDuration_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CS)],
    [0, 3600, 30],
    true
] call CBA_fnc_addSetting;

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
