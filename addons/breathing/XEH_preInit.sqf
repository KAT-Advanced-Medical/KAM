#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Breathing"

//Enable breathing
[
    QGVAR(enable),
    "CHECKBOX",
    LLSTRING(SETTING_ENABLE),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

//Enable breathing death timer for airway injuries
[
    QGVAR(death_timer_enable),
    "CHECKBOX",
    LLSTRING(SETTING_death_timer_enable),
    CBA_SETTINGS_CAT,
    [false],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 add & remove value small
[
    QGVAR(spo2_small_value),
    "SLIDER",
    LLSTRING(SETTING_Value_Before),
    CBA_SETTINGS_CAT,
    [0, 100, 4, 0],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 add % remove value big
[
    QGVAR(spo2_big_value),
    "SLIDER",
    LLSTRING(SETTING_Value_After),
    CBA_SETTINGS_CAT,
    [0, 100, 10, 0],
    true
] call CBA_Settings_fnc_init;

// breathing probability for a pneumothorax
// a pneumothorax is the presence of air or gas in the cavity between the lungs and the chest wall
[
    QGVAR(pneumothorax),
    "SLIDER",
    LLSTRING(SETTING_pneumothorax),
    CBA_SETTINGS_CAT,
    [0, 100, 5, 0],
    true
] call CBA_Settings_fnc_init;

//Settable list for using Pulseoximeter per medical class
[
    QGVAR(medLvl_Pulseoximeter),
    "LIST",
    [LLSTRING(ALLOW_PULSEOXIMETER), LLSTRING(TRAININGLEVEL_PULSEOXIMETER)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
    true
] call CBA_settings_fnc_init;

//Settable list for using Chestseal per medical class
[
    QGVAR(medLvl_Chestseal),
    "LIST",
    [LLSTRING(ALLOW_CHESTSEAL), LLSTRING(TRAININGLEVEL_CHESTSEAL)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
    true
] call CBA_settings_fnc_init;

// breathing SpO2 add % remove value big
[
    QGVAR(Stable_spo2),
    "SLIDER",
    [LLSTRING(SETTING_STABLE_SPO2), LLSTRING(DESCRIPTION_STABLE_SPO2)],
    CBA_SETTINGS_CAT,
    [0, 95, 85, 0],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 add % remove value big
[
    QGVAR(hemopneumothoraxChance),
    "SLIDER",
    [LLSTRING(HEMOPNEUMOTHORAX_CHANCE_OPTION), LLSTRING(DESCRIPTION_HEMOPNEUMOTHORAX_CHANCE_OPTION)],
    CBA_SETTINGS_CAT,
    [0, 95, 5, 0, true],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
