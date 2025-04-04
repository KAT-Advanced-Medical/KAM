
// Enable or disable Colored Action Logs
[
    QGVAR(ColoredLogs),
    "CHECKBOX",
    [LLSTRING(SETTING_ColoredLogs), LLSTRING(SETTING_ColoredLogs_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Label left and right in medical menu
[
    QGVAR(showPatientSideLabels),
    "CHECKBOX",
    LLSTRING(SETTING_showPatientSideLabels),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [false],
    false
] call CBA_Settings_fnc_init;