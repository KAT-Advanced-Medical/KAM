
//low SPO2 Warning Level
[
    QGVAR(effectLowSpO2),
    "SLIDER",
    [LLSTRING(SETTING_lowSpO2_display), LLSTRING(SETTING_lowSpO2_DESC)],
    CBA_SETTINGS_CAT,
    [5, 100, 90, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableOpioidEffect),
    "CHECKBOX",
    [LLSTRING(SETTING_OpioidEffect_display), LLSTRING(SETTING_OpioidEffect_DESC)],
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(effectOverdose),
    "CHECKBOX",
    [LLSTRING(SETTING_effectOverdose_display), LLSTRING(SETTING_effectOverdose_DESC)],
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_fnc_addSetting;
