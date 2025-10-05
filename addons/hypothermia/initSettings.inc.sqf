
[
    QGVAR(hypothermiaActive),
    "CHECKBOX",
    LLSTRING(ENABLE_HYPOTHERMIA),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Hypothermia)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(baroPressureEnable),
    "CHECKBOX",
    [LLSTRING(PRESSURE_ENABLE), LLSTRING(PRESSURE_ENABLE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(useACEpressure),
    "CHECKBOX",
    [LLSTRING(PRESSURE_ACE), LLSTRING(PRESSURE_ACE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_fnc_addSetting;