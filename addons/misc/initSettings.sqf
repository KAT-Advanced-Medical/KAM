//Enable aceExposure things
[
    QGVAR(enable),
    "CHECKBOX",
    localize LSTRING(SETTING_enable),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [true],
    true
] call CBA_Settings_fnc_init;
