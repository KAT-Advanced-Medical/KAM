
[
    QGVAR(checkLimbTime),
    "SLIDER",
    [LLSTRING(SETTING_checkLimbTime), LLSTRING(SETTING_checkLimbTime_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [4, 20, 8, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(woundWrapTime),
    "SLIDER",
    [LSTRING(WoundWrapTime_DisplayName), LSTRING(WoundWrapTime_Description)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [2, 16, 4, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(CatastrophicEnable),
    "CHECKBOX",
    [LLSTRING(SETTING_ENABLE),LLSTRING(SETTING_ENABLE_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(EviscerationChance),
    "SLIDER",
    LLSTRING(EviscerationChance),
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [0, 100, 5, 0],
    true
] call CBA_fnc_addSetting;


[
    QGVAR(EviscerationDamageThreshold),
    "SLIDER",
    [LLSTRING(Evisceration_DAMAGE_THRESHOLD), LLSTRING(Evisceration_DAMAGE_THRESHOLD_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [0, 4, 1.5, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(EviscerationDamageThreshold_TakenDamage),
    "CHECKBOX",
    [LLSTRING(SETTING_EviscerationDamageThreshold_DamageTaken), LLSTRING(SETTING_EviscerationDamageThreshold_DamageTaken_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [true],
    true
] call CBA_fnc_addSetting;
