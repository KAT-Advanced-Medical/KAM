#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {
    // Decrease of 0.7C for each degree of lattitude gained. Middle lattitudes between 20N and 20S have average temperatures of 27C, everything decreases from there.
    private _mapPosition = if (count([worldName] call ACEFUNC(common,getMapData)) != 0) then { abs([worldName] call ACEFUNC(common,getMapData) select 0) } else { 25 };
    private _mapHighTemperature = if ((_mapPosition - 20) > 0) then { 27 + (-0.7 * (_mapPosition - 27)) } else { 27 };

    GVAR(positionTemperature) = [_mapPosition, _mapHighTemperature];
};

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Hypothermia"

[
    QGVAR(hypothermia),
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
