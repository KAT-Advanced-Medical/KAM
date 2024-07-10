#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Hypothermia"

[
    QGVAR(enable_hypothermia),
    "CHECKBOX",
    LLSTRING(ENABLE_HYPOTHERMIA),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Hypothermia)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(handWarmerImpact),
    "SLIDER",
    [LLSTRING(HAND_WARMER_IMPACT),LLSTRING(HAND_WARMER_IMPACT_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Hypothermia)],
    [0,5,1,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(fluidWarmerImpact),
    "SLIDER",
    [LLSTRING(FLUID_WARMER_IMPACT),LLSTRING(FLUID_WARMER_IMPACT_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Hypothermia)],
    [0,5,1,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(warmClothing),
    "EDITBOX",
    [LLSTRING(WARM_CLOTHING),LLSTRING(WARM_CLOTHING_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Hypothermia)],
    "'U_O_R_Gorka_01_F', 'U_B_CombatUniform_mcam', 'U_O_CombatUniform_ocamo'",
    1,
    {
        private _array = [_this, "CfgGlasses"] call EFUNC(chemical,getList);
        missionNamespace setVariable [QGVAR(warmClothing), _array, true];
    },
    true
] call CBA_Settings_fnc_init;

ADDON = true;
