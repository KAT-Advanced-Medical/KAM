#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CHEM "KAT - ADV Medical: Chemical"

[
    QGVAR(availGasmask),
    "EDITBOX",
    [LLSTRING(SETTING_AVAIL_GASMASK), LLSTRING(SETTING_AVAIL_GASMASK_DISC)],
    CBA_SETTINGS_CHEM,
    "'G_AirPurifyingRespirator_01_F', 'kat_mask_M50', 'kat_mask_M04'",
    1,
    {
        private _array = [_this, "CfgGlasses"] call FUNC(getList);
        missionNamespace setVariable [QGVAR(availGasmaskList), _array, true];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(gasmask_durability),
    "TIME",
    [LLSTRING(SETTING_GASMASK_DURABILITY), LLSTRING(SETTING_GASMASK_DURABILITY_DISC)],
    CBA_SETTINGS_CHEM,
    [1, 3600, 900],
    true
] call CBA_Settings_fnc_init;

// Sets sound volume of gas mask breathing
[
    QGVAR(gasMaskSoundVolume),
    "SLIDER",
    [LLSTRING(SETTING_gasMaskSoundVolume), LLSTRING(SETTING_gasMaskSoundVolume_DESC)],
    CBA_SETTINGS_CHEM,
    [0, 2, 1, 1],
    2,
    {
        player setVariable [QGVAR(gasMaskSoundVolume), _this, true];
    },
    false
] call CBA_Settings_fnc_init;

// Chance of weapon drop by tear gas
[
    QGVAR(tearGasDropChance),
    "SLIDER",
    [LLSTRING(SETTING_dropWeaponChance), LLSTRING(SETTING_dropWeaponChance_DESC)],
    CBA_SETTINGS_CHEM,
    [0, 1, 0, 2, true],
    true
] call CBA_Settings_fnc_init;

// Infection time
[
    QGVAR(infectionTime),
    "TIME",
    [LLSTRING(SETTING_infectionTime), LLSTRING(SETTING_infectionTime_DESC)],
    CBA_SETTINGS_CHEM,
    [0, 3600, 60],
    true
] call CBA_Settings_fnc_init;

// Shows poisioning image
[
    QGVAR(showPoisoning),
    "CHECKBOX",
    [LLSTRING(SETTING_showPoisoning), LLSTRING(SETTING_showPoisoning_DESC)],
    CBA_SETTINGS_CHEM,
    [true],
    true
] call CBA_Settings_fnc_init;
ADDON = true;
