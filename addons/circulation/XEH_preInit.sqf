#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Circulation"

[
    QGVAR(enable),
    "CHECKBOX",
    LLSTRING(SETTING_ENABLE),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

//location for AED - Defi:
[
    QGVAR(useLocation_AED),
    "LIST",
    [LLSTRING(LOCATION_AED),LLSTRING(LOCATION_AED_DESCRIPTION)],
    CBA_SETTINGS_CAT,
    [[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],0],
    true
] call CBA_Settings_fnc_init;

//Succes chance for AED-X
[
    QGVAR(SuccesCh_AED_X),
    "SLIDER",
    LLSTRING(SUCESSCHANCE_AED_X),
    CBA_SETTINGS_CAT,
    [1, 100, 85, 0],
    true
] call CBA_Settings_fnc_init;

//Succes chance for AED
[
    QGVAR(SuccesCh_AED),
    "SLIDER",
    LLSTRING(SUCESSCHANCE_AED),
    CBA_SETTINGS_CAT,
    [1, 100, 80, 0],
    true
] call CBA_Settings_fnc_init;

private _type = round random(3);
[
    QGVAR(bloodgroup),
    "LIST",
    LLSTRING(client_bt),
    CBA_SETTINGS_CAT,
    [["A", "B", "AB", "O"], ["A", "B", "AB", "O"], _type],
    2,
    {
        player setVariable [QGVAR(bloodtype), _this, true];
        player setVariable ["ace_dogtags_dogtagData", nil, true];
    }
] call CBA_Settings_fnc_init;

//Settable list for using AED per medical class
[
    QGVAR(medLvl_AED),
    "LIST",
    [LLSTRING(ALLOW_AED),LLSTRING(TRAINING_LEVEL_AED)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 0],
    true
] call CBA_settings_fnc_init;

//Settable list for using AED-X per medical class
[
    QGVAR(medLvl_AED_X),
    "LIST",
    [LLSTRING(ALLOW_AED_X),LLSTRING(TRAINING_LEVEL_AED_X)],
    CBA_SETTINGS_CAT,
    [[0, 1, 2], ["Anyone", "Medics", "Doctors"], 0],
    true
] call CBA_settings_fnc_init;

//Distance limit for AED-X
[
    QGVAR(distanceLimit_AEDX),
    "SLIDER",
    LLSTRING(DISTANCELIMIT_AED_X),
    CBA_SETTINGS_CAT,
    [2, 100, 30, 0],
    true
] call CBA_Settings_fnc_init;

//Time limit for monitor of AED-X
[
    QGVAR(timeLimit_AEDX),
    "SLIDER",
    LLSTRING(TIMELIMIT_AED_X),
    CBA_SETTINGS_CAT,
    [60, 14400, 1800, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(DeactMon_whileAED_X),
    "CHECKBOX",
    LLSTRING(DEACTIVATE_MONITOR_WHILEAED_X),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;


//Enable different CPR chances per medical level
[
    QGVAR(enable_CPR_Chances),
    "CHECKBOX",
    LLSTRING(SETTING_CPR_CHANCES),
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

//CPR Chance for Doctors
[
    QGVAR(CPR_Chance_Doctor),
    "SLIDER",
    LLSTRING(SETTING_CPR_CHANCE_DOCTOR),
    CBA_SETTINGS_CAT,
    [0,100,40,0],
    true
] call CBA_Settings_fnc_init;

//CPR Chance for Regular medics
[
    QGVAR(CPR_Chance_RegularMedic),
    "SLIDER",
    LLSTRING(SETTING_CPR_CHANCE_REGULARMEDIC),
    CBA_SETTINGS_CAT,
    [0,100,30,0],
    true
] call CBA_Settings_fnc_init;

//CPR Chance for Default
[
    QGVAR(CPR_Chance_Default),
    "SLIDER",
    LLSTRING(SETTING_CPR_CHANCE_DEFAULT),
    CBA_SETTINGS_CAT,
    [0,100,20,0],
    true
] call CBA_Settings_fnc_init;

//Enable self blood draw
[
    QGVAR(enable_selfBloodDraw),
    "LIST",
    LLSTRING(SETTING_SELF_BLOOD_DRAW),
    CBA_SETTINGS_CAT,
    [[0, 1], ["STR_ACE_common_No", "STR_ACE_common_Yes"], 1],
    true
] call CBA_Settings_fnc_init;

//blood draw time for 500ml kit
[
    QGVAR(blood_drawTime_500ml),
    "SLIDER",
    LLSTRING(SETTING_BLOOD_DRAWTIME_500ML),
    CBA_SETTINGS_CAT,
    [1,600,50,0],
    true
] call CBA_Settings_fnc_init;

//blood draw time for 250ml kit
[
    QGVAR(blood_drawTime_250ml),
    "SLIDER",
    LLSTRING(SETTING_BLOOD_DRAWTIME_250ML),
    CBA_SETTINGS_CAT,
    [1,600,25,0],
    true
] call CBA_Settings_fnc_init;

//No aggresive AED Sounds (Beeps and charging)
[
    QGVAR(AED_BeepsAndCharge),
    "CHECKBOX",
    [LLSTRING(SETTING_AED_BeepsAndCharge), LLSTRING(SETTING_AED_BeepsAndCharge_DESC)],
    CBA_SETTINGS_CAT,
    [true],
    true
] call CBA_Settings_fnc_init;

ADDON = true;