
[
    QGVAR(availGasmask),
    "EDITBOX",
    [LLSTRING(SETTING_AVAIL_GASMASK), LLSTRING(SETTING_AVAIL_GASMASK_DISC)],
    CBA_SETTINGS_CAT,
    "'G_AirPurifyingRespirator_01_F', 'kat_mask_M50', 'kat_mask_M04'",
    1,
    {
        private _array = [_this, "CfgGlasses"] call FUNC(getList);
        missionNamespace setVariable [QGVAR(availGasmaskList), _array, true];
    },
    true
] call CBA_fnc_addSetting;

[
    QGVAR(availBackpack),
    "EDITBOX",
    [LLSTRING(SETTING_AVAIL_BACKPACK), LLSTRING(SETTING_AVAIL_BACKPACK_DISC)],
    CBA_SETTINGS_CAT,
    "'B_SCBA_01_F', 'B_CombinationUnitRespirator_01_F'",
    1,
    {
        private _array = [_this, "CfgVehicles"] call FUNC(getList);
        missionNamespace setVariable [QGVAR(availBackpackList), _array, true];
    },
    true
] call CBA_fnc_addSetting;

[
    QGVAR(availSuits),
    "EDITBOX",
    [LLSTRING(SETTING_AVAIL_SUITS), LLSTRING(SETTING_AVAIL_SUITS_DISC)],
    CBA_SETTINGS_CAT,
    "'U_C_CBRN_Suit_01_Blue_F', 'U_B_CBRN_Suit_01_MTP_F', 'U_B_CBRN_Suit_01_Tropic_F', 'U_C_CBRN_Suit_01_White_F', 'U_B_CBRN_Suit_01_Wdl_F', 'U_I_CBRN_Suit_01_AAF_F', 'U_I_E_CBRN_Suit_01_EAF_F'",
    1,
    {
        private _array = [_this, "CfgWeapons"] call FUNC(getList);
        missionNamespace setVariable [QGVAR(availSuitsList), _array, true];
    },
    true
] call CBA_fnc_addSetting;

[
    QGVAR(gasmask_durability),
    "TIME",
    [LLSTRING(SETTING_GASMASK_DURABILITY), LLSTRING(SETTING_GASMASK_DURABILITY_DISC)],
    CBA_SETTINGS_CAT,
    [1, 3600, 900],
    true
] call CBA_fnc_addSetting;

// Sets sound volume of gas mask breathing
[
    QGVAR(gasMaskSoundVolume),
    "SLIDER",
    [LLSTRING(SETTING_gasMaskSoundVolume), LLSTRING(SETTING_gasMaskSoundVolume_DESC)],
    CBA_SETTINGS_CAT,
    [0, 2, 1, 1],
    2,
    {
        player setVariable [QGVAR(gasMaskSoundVolume), _this, true];
    },
    false
] call CBA_fnc_addSetting;

// Should gas mask affect stamina
[
    QGVAR(maskStaminaLoss),
    "CHECKBOX",
    [LLSTRING(SETTING_gasMaskStaminaLoss),LLSTRING(SETTING_gasMaskStaminaLoss_DESC)],
    CBA_SETTINGS_CAT,
    [false],
    true
] call CBA_fnc_addSetting;

// Chance of weapon drop by tear gas
[
    QGVAR(tearGasDropChance),
    "SLIDER",
    [LLSTRING(SETTING_dropWeaponChance), LLSTRING(SETTING_dropWeaponChance_DESC)],
    CBA_SETTINGS_CAT,
    [0, 1, 0, 2, true],
    true
] call CBA_fnc_addSetting;

// Infection time
[
    QGVAR(infectionTime),
    "TIME",
    [LLSTRING(SETTING_infectionTime), LLSTRING(SETTING_infectionTime_DESC)],
    CBA_SETTINGS_CAT,
    [0, 3600, 60],
    true
] call CBA_fnc_addSetting;

// Shows poisioning image
[
    QGVAR(showPoisoning),
    "CHECKBOX",
    [LLSTRING(SETTING_showPoisoning), LLSTRING(SETTING_showPoisoning_DESC)],
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_fnc_addSetting;
