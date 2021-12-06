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
    "ACE Pharmacy - Medications",
    [true],
    true
] call CBA_Settings_fnc_init;

//Activate Naloxone
[
    QGVAR(naloxoneActive),
    "CHECKBOX",
    [LLSTRING(NALOXONE_ACTIVE)],
    "ACE Pharmacy - Medications",
    [true],
    true
] call CBA_Settings_fnc_init;

//Activate Carbonate
[
    QGVAR(carbonateActive),
    "CHECKBOX",
    [LLSTRING(CARBONATE_ACTIVE)],
    "ACE Pharmacy - Medications",
    [true],
    true
] call CBA_Settings_fnc_init;

//Activate TXA
[
    QGVAR(txaActive),
    "CHECKBOX",
    [LLSTRING(TXA_ACTIVE)],
    "ACE Pharmacy - Medications",
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVreuse),
    "CHECKBOX",
    [LLSTRING(IV_REUSE)],
    "ACE Pharmacy - Medications",
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVmedic),
    "LIST",
    [LLSTRING(IV_MEDIC)],
    "ACE Pharmacy - Medications",
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 2],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVdrop),
    "SLIDER",
    [LLSTRING(IV_DROP)],
    "ACE Pharmacy - Medications",
    [60, 1200, 600, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVestablish),
    "SLIDER",
    [LLSTRING(IV_TIME)],
    "ACE Pharmacy - Medications",
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IOestablish),
    "SLIDER",
    [LLSTRING(IO_TIME)],
    "ACE Pharmacy - Medications",
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(PushTime),
    "SLIDER",
    [LLSTRING(PUSH_TIME)],
    "ACE Pharmacy - Medications",
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;
//location for AED - Defi:
[
    QGVAR(useLocation_AED),
    "LIST",
    [LLSTRING(LOCATION_AED),LLSTRING(LOCATION_AED_DESCRIPTION)],
    "ACE Pharmacy - AED",
    [[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],0],
    true
] call CBA_Settings_fnc_init;

//Succes chance for AED-X
[
    QGVAR(SuccesCh_AED_X),
    "SLIDER",
    LLSTRING(SUCESSCHANCE_AED_X),
    "ACE Pharmacy - AED",
    [1, 100, 85, 0],
    true
] call CBA_Settings_fnc_init;

//Succes chance for AED
[
    QGVAR(SuccesCh_AED),
    "SLIDER",
    LLSTRING(SUCESSCHANCE_AED),
    "ACE Pharmacy - AED",
    [1, 100, 80, 0],
    true
] call CBA_Settings_fnc_init;

//Settable list for using AED-X per medical class
[
    QGVAR(medLvl_AED_X),
    "LIST",
    [LLSTRING(ALLOW_AED_X),LLSTRING(TRAINING_LEVEL_AED_X)],
    "ACE Pharmacy - AED",
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 2],
    true
] call CBA_settings_fnc_init;

//Distance limit for AED-X
[
    QGVAR(distanceLimit_AEDX),
    "SLIDER",
    LLSTRING(DISTANCELIMIT_AED_X),
    "ACE Pharmacy - AED",
    [2, 100, 30, 0],
    true
] call CBA_Settings_fnc_init;

//Time limit for monitor of AED-X
[
    QGVAR(timeLimit_AEDX),
    "SLIDER",
    LLSTRING(TIMELIMIT_AED_X),
    "ACE Pharmacy - AED",
    [60, 14400, 1800, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(DeactMon_whileAED_X),
    "CHECKBOX",
    LLSTRING(DEACTIVATE_MONITOR_WHILEAED_X),
    "ACE Pharmacy - AED",
    [true],
    true
] call CBA_Settings_fnc_init;


//Enable different CPR chances per medical level
[
    QGVAR(enable_CPR_Chances),
    "CHECKBOX",
    LLSTRING(SETTING_CPR_CHANCES),
    "ACE Pharmacy - AED",
    [true],
    true
] call CBA_Settings_fnc_init;

//CPR Chance for Doctors
[
    QGVAR(CPR_Chance_Doctor),
    "SLIDER",
    LLSTRING(SETTING_CPR_CHANCE_DOCTOR),
    "ACE Pharmacy - AED",
    [0,100,40,0],
    true
] call CBA_Settings_fnc_init;

//CPR Chance for Regular medics
[
    QGVAR(CPR_Chance_RegularMedic),
    "SLIDER",
    LLSTRING(SETTING_CPR_CHANCE_REGULARMEDIC),
    "ACE Pharmacy - AED",
    [0,100,30,0],
    true
] call CBA_Settings_fnc_init;

//CPR Chance for Default
[
    QGVAR(CPR_Chance_Default),
    "SLIDER",
    LLSTRING(SETTING_CPR_CHANCE_DEFAULT),
    "ACE Pharmacy - AED",
    [0,100,20,0],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
