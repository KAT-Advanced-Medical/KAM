
// Enable or disable Colored Action Logs
[
    QGVAR(ColoredLogs),
    "CHECKBOX",
    [LLSTRING(SETTING_ColoredLogs), LLSTRING(SETTING_ColoredLogs_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [true],
    true
] call CBA_fnc_addSetting;

// Label left and right in medical menu
[
    QGVAR(showPatientSideLabels),
    "CHECKBOX",
    LLSTRING(SETTING_showPatientSideLabels),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [false],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showBleeding),
    "LIST",
    [LSTRING(showBleeding_DisplayName), LSTRING(showBleeding_Description)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [[0, 1, 2, 3], [ACELSTRING(common,Disabled), ACELSTRING(common,Enabled), LSTRING(ShowBleeding_Rate), LSTRING(ShowBleeding_Rate_Limb)], 2],
    true // isGlobal
] call CBA_fnc_addSetting;
