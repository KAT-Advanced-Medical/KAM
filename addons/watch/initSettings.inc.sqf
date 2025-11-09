
[
    QGVAR(temperatureUnit),
    "LIST",
    [LLSTRING(SETTING_TemperatureForm), LLSTRING(SETTING_TemperatureForm_Desc)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [[0, 1], [LLSTRING(SETTING_TemperatureForm_Celsius), LLSTRING(SETTING_TemperatureForm_Fahrenheit)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(pressureUnit),
    "LIST",
    [LLSTRING(SETTING_PressureForm), LLSTRING(SETTING_PressureForm_Desc)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [[0, 1], [LLSTRING(SETTING_PressureForm_mmHg), LLSTRING(SETTING_PressureForm_hPa)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(altitudeUnit),
    "LIST",
    [LLSTRING(SETTING_AltitudeForm), LLSTRING(SETTING_AltitudeForm_Desc)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [[0, 1], [LLSTRING(SETTING_AltitudeForm_meters), LLSTRING(SETTING_AltitudeForm_feet)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(watchInaccuracy),
    "CHECKBOX",
    [LLSTRING(SETTING_WatchInaccuracy), LLSTRING(SETTING__WatchInaccuracy_Desc)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_fnc_addSetting;
