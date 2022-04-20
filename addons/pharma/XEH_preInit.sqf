#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "ACE Pharmacy"

[
    QGVAR(enable),
    "CHECKBOX",
    LLSTRING(SETTING_ENABLE),
    "KAT - ADV Medical: Pharmacy",
    [true],
    true
] call CBA_Settings_fnc_init;

//Activate Naloxone
[
    QGVAR(naloxoneActive),
    "CHECKBOX",
    [LLSTRING(NALOXONE_ACTIVE)],
    "KAT - ADV Medical: Pharmacy",
    [true],
    true
] call CBA_Settings_fnc_init;

//Activate Carbonate
[
    QGVAR(carbonateActive),
    "CHECKBOX",
    [LLSTRING(CARBONATE_ACTIVE)],
    "KAT - ADV Medical: Pharmacy",
    [true],
    true
] call CBA_Settings_fnc_init;

//Activate TXA
[
    QGVAR(txaActive),
    "CHECKBOX",
    [LLSTRING(TXA_ACTIVE)],
    "KAT - ADV Medical: Pharmacy",
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVreuse),
    "CHECKBOX",
    [LLSTRING(IV_REUSE)],
    "KAT - ADV Medical: Pharmacy",
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVmedic),
    "LIST",
    [LLSTRING(IV_MEDIC)],
    "KAT - ADV Medical: Pharmacy",
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVdrop),
    "SLIDER",
    [LLSTRING(IV_DROP)],
    "KAT - ADV Medical: Pharmacy",
    [60, 1200, 600, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVestablish),
    "SLIDER",
    [LLSTRING(IV_TIME)],
    "KAT - ADV Medical: Pharmacy",
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IOestablish),
    "SLIDER",
    [LLSTRING(IO_TIME)],
    "KAT - ADV Medical: Pharmacy",
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(PushTime),
    "SLIDER",
    [LLSTRING(PUSH_TIME)],
    "KAT - ADV Medical: Pharmacy",
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(Reorientation_Enable),
    "CHECKBOX",
    [LLSTRING(SETTING_Reorientation_Enable), LLSTRING(SETTING_Reorientation_Enable_DESC)],
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(medLvl_Reorientation),
    "LIST",
    [LLSTRING(SETTING_Allow_Reorientation),LLSTRING(Allow_Reorientation_DESC)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 1],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(Reorientation_Slap),
    "CHECKBOX",
    [LLSTRING(SETTING_Reorientation_Slap), LLSTRING(SETTING_Reorientation_Slap_DESC)],
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;


ADDON = true;
