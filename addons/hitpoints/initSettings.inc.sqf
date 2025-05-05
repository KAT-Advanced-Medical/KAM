
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
    LSTRING(Category),
    [4, 16, 4, 1],
    true
] call CBA_fnc_addSetting;