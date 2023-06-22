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

[
    QGVAR(infectionTime),
    "TIME",
    [LLSTRING(SETTING_infection_time),LLSTRING(SETTING_infection_time_disc)],
    CBA_SETTINGS_CHEM,
    [1, 600, 60],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(affectAI),
    "CHECKBOX",
    [LLSTRING(SETTING_affectAI),LLSTRING(SETTING_affectAI_disc)],
    CBA_SETTINGS_CHEM,
    false,
    true,
    {},
    true
] call CBA_Settings_fnc_init;

ADDON = true;
