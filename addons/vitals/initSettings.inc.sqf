
[
    QGVAR(enableSimpleMedical),
    "CHECKBOX",
    [LLSTRING(SIMPLEMED_ENABLE), LLSTRING(SIMPLEMED_ENABLE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableFluidShift),
    "CHECKBOX",
    LLSTRING(FLUID_SHIFT),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableBasicDiagnostic),
    "CHECKBOX",
    LLSTRING(BASIC_DIAGNOSTIC_ENABLE),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(basicDiagnosticTime),
    "SLIDER",
    LLSTRING(BASIC_DIAGNOSTIC_TIME),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0.1, 60, 15, 1],
    true
] call CBA_fnc_addSetting;
