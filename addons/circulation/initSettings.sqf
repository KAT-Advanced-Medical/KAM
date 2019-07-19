[
    QGVAR(enable),
    "CHECKBOX",
    localize LSTRING(SETTING_enable),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [true],
    true
] call CBA_Settings_fnc_init;


private _type = round random(3);
[
    QGVAR(bloodgroup),
    "LIST",
    localize LSTRING(SETTING_bloodtype),
    [CBA_SETTINGS_CAT, QUOTE(COMPONENT_BEAUTIFIED)],
    [["A", "B", "AB", "O"], ["A", "B", "AB", "O"], _type],
    2,
    {
        player setVariable [QGVAR(bloodtype), _this, true];
        player setVariable ["ace_dogtags_dogtagData", nil, true];
    }
] call CBA_Settings_fnc_init;
