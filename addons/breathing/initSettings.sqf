//Enable breathing
[
    QGVAR(enable),
    "CHECKBOX",
    localize LSTRING(SETTING_ENABLE),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [true],
    true
] call CBA_Settings_fnc_init;

//Enable breathing death timer for airway injuries
[
    QGVAR(death_timer_enable),
    "CHECKBOX",
    localize LSTRING(SETTING_death_timer_enable),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [false],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 add & remove value small
[
    QGVAR(spo2_small_value),
    "SLIDER",
    localize LSTRING(SETTING_Value_Before),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [0, 100, 2, 0],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 add % remove value big
[
    QGVAR(spo2_big_value),
    "SLIDER",
    localize LSTRING(SETTING_Value_After),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [0, 100, 5, 0],
    true
] call CBA_Settings_fnc_init;
