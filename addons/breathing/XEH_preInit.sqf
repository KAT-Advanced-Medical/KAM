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
    localize LSTRING(SETTING_ENABLE),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

//Enable breathing death timer for airway injuries
[
    QGVAR(death_timer_enable),
    "CHECKBOX",
    localize LSTRING(SETTING_death_timer_enable),
    CBA_SETTINGS_CAT,
    [false],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 add & remove value small
[
    QGVAR(spo2_small_value),
    "SLIDER",
    localize LSTRING(SETTING_Value_Before),
    CBA_SETTINGS_CAT,
    [0, 100, 2, 0],
    true
] call CBA_Settings_fnc_init;

// breathing SpO2 add % remove value big
[
    QGVAR(spo2_big_value),
    "SLIDER",
    localize LSTRING(SETTING_Value_After),
    CBA_SETTINGS_CAT,
    [0, 100, 5, 0],
    true
] call CBA_Settings_fnc_init;

// breathing probability for a pneumothorax
// a pneumothorax is the presence of air or gas in the cavity between the lungs and the chest wall
[
    QGVAR(pneumothorax),
    "SLIDER",
    localize LSTRING(SETTING_pneumothorax),
    CBA_SETTINGS_CAT,
    [0, 100, 0, 0],
    true
] call CBA_Settings_fnc_init;

//Settable list for using Pulseoximeter per medical class
[
    QGVAR(medLvl_Pulseoximeter),
    "LIST",
    [localize LSTRING(ALLOW_PULSEOXIMETER), localize LSTRING(TRAININGLEVEL_PULSEOXIMETER)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
    true
] call CBA_settings_fnc_init;

//Settable list for using Chestseal per medical class
[
    QGVAR(medLvl_Chestseal),
    "LIST",
    [localize LSTRING(ALLOW_CHESTSEAL), localize LSTRING(TRAININGLEVEL_CHESTSEAL)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
    true
] call CBA_settings_fnc_init;

ADDON = true;
