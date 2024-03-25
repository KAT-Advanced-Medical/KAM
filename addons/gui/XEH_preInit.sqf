#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: GUI"

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

// OVERRIDE ACE

/*
* Default damage colouring follows a "white, yellow, red" colour scale with 10 steps, Bezier interpolation and Correct lightness gradient.
* See: https://gka.github.io/palettes
* // KAM // "#ffef7a, yellow, red" - 9 steps
*/
private _bloodLossColors = [
    [1.00, 1.00, 1.00, 1],
    [1.00, 0.94, 0.48, 1],
    [1.00, 0.87, 0.25, 1],
    [1.00, 0.79, 0.17, 1],
    [1.00, 0.71, 0.11, 1],
    [1.00, 0.62, 0.05, 1],
    [1.00, 0.53, 0.01, 1],
    [1.00, 0.42, 0.00, 1],
    [1.00, 0.29, 0.00, 1],
    [1.00, 0.00, 0.00, 1]
];

/*
* Default damage colouring follows a "white, cyan, blue" colour scale with 10 steps, Bezier interpolation and Correct lightness gradient.
* See: https://gka.github.io/palettes
* // KAM // "white, cyan, blue" - 12 steps
*/
private _damageColors = [
    [1.00, 1.00, 1.00, 1],
    [0.52, 0.73, 1.00, 1],
    [0.38, 0.68, 1.00, 1],
    [0.37, 0.60, 1.00, 1],
    [0.35, 0.53, 1.00, 1],
    [0.33, 0.45, 1.00, 1],
    [0.30, 0.37, 1.00, 1],
    [0.25, 0.29, 1.00, 1],
    [0.18, 0.18, 1.00, 1],
    [0.00, 0.00, 1.00, 1]
];

private _categoryColors = [ACELSTRING(medical,Interface_Category), format ["| %1 |", ACELLSTRING(common,subcategory_colors)]];
{
    [
        format ["%1_%2", QACEGVAR(medical_gui,bloodLossColor), _forEachIndex],
        "COLOR",
        [format [localize ACELSTRING(medical_gui,BloodLossColorX_DisplayName), _forEachIndex], ACELSTRING(medical_gui,BloodLossColor_Description)],
        _categoryColors,
        _x,
        false // isGlobal
    ] call CBA_fnc_addSetting;
} forEach _bloodLossColors;

{
    [
        format ["%1_%2", QACEGVAR(medical_gui,damageColor), _forEachIndex],
        "COLOR",
        [format [localize ACELSTRING(medical_gui,DamageColorX_DisplayName), _forEachIndex], ACELSTRING(medical_gui,DamageColor_Description)],
        _categoryColors,
        _x,
        false // isGlobal
    ] call CBA_fnc_addSetting;
} forEach _damageColors;
