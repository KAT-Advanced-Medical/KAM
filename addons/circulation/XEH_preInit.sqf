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
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

//Advanced Rhythms
[
    QGVAR(AdvRhythm),
    "CHECKBOX",
    LLSTRING(RHYTHM_ENABLE),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Sets how player bloodtype is designated
[
    QGVAR(bloodTypeSetting),
    "LIST",
    [LLSTRING(SETTING_bloodtype_assign), LLSTRING(SETTING_bloodtype_assign_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [[0,1,2,3,4,5],[LSTRING(SETTING_bloodtype_assign_player), LSTRING(SETTING_bloodtype_assign_player_forced), LSTRING(SETTING_bloodtype_assign_random), LSTRING(SETTING_bloodtype_assign_random_onJoin), LSTRING(SETTING_bloodtype_assign_steamid), LSTRING(SETTING_bloodtype_assign_steamid_custom)],4],
    true
] call CBA_Settings_fnc_init;

// Sets if randomizer should be weighted (according to bloodtype commonness)
[
    QGVAR(bloodTypeRandomWeighted),
    "CHECKBOX",
    [LLSTRING(SETTING_bloodtype_random_weighted), LLSTRING(SETTING_bloodtype_random_weighted_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Sets the player's desired bloodtype
[
    QGVAR(bloodTypeSettingPlayer),
    "LIST",
    LLSTRING(SETTING_bloodtype_player),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [["A", "A_N", "B", "B_N", "AB", "AB_N", "O", "O_N"], ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"], 7],
    2,
    {
        player setVariable [QGVAR(bloodTypePlayer), _this, true];
        player setVariable [QACEGVAR(dogtags,dogtagData), nil, true];
    },
    false
] call CBA_Settings_fnc_init;

// Custom bloodtype list to use with custom steamid option
[
    QGVAR(bloodTypeCustomList),
    "EDITBOX",
    [LLSTRING(SETTING_bloodtype_custom_list), LLSTRING(SETTING_bloodtype_custom_list_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    "O,O,A,A,O_N,B,A_N,AB,B_N,AB_N",
    true
] call CBA_Settings_fnc_init;

//location for AED - Defi:
[
    QGVAR(useLocation_AED),
    "LIST",
    [LLSTRING(LOCATION_AED),LLSTRING(LOCATION_AED_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],0],
    true
] call CBA_Settings_fnc_init;

//Max Succes chance for AED-X
[
    QGVAR(AED_X_MaxChance),
    "SLIDER",
    LLSTRING(AED_X_MaxChance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 100, 90, 0],
    true
] call CBA_Settings_fnc_init;

//Min Succes chance for AED-X
[
    QGVAR(AED_X_MinChance),
    "SLIDER",
    LLSTRING(AED_X_MinChance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 100, 45, 0],
    true
] call CBA_Settings_fnc_init;

//Max Succes chance for AED
[
    QGVAR(AED_MaxChance),
    "SLIDER",
    LLSTRING(AED_MaxChance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 100, 80, 0],
    true
] call CBA_Settings_fnc_init;

//Min Succes chance for AED
[
    QGVAR(AED_MinChance),
    "SLIDER",
    LLSTRING(AED_MinChance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 100, 40, 0],
    true
] call CBA_Settings_fnc_init;

//Settable list for using AED per medical class
[
    QGVAR(medLvl_AED),
    "LIST",
    [LLSTRING(ALLOW_AED),LLSTRING(TRAINING_LEVEL_AED)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

//Settable list for using AED-X per medical class
[
    QGVAR(medLvl_AED_X),
    "LIST",
    [LLSTRING(ALLOW_AED_X),LLSTRING(TRAINING_LEVEL_AED_X)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

// Sets time required to attach AED-X monitor
[
    QGVAR(AED_X_AttachTime),
    "SLIDER",
    LLSTRING(SETTING_AED_X_AttachTime),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 60, 10, 1],
    true
] call CBA_Settings_fnc_init;

// Sets time required to detach AED-X monitor
[
    QGVAR(AED_X_DetachTime),
    "SLIDER",
    LLSTRING(SETTING_AED_X_DetachTime),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 60, 5, 1],
    true
] call CBA_Settings_fnc_init;

//Distance limit for AED-X
[
    QGVAR(distanceLimit_AEDX),
    "SLIDER",
    LLSTRING(DISTANCELIMIT_AED_X),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [2, 100, 30, 0],
    true
] call CBA_Settings_fnc_init;

//Time limit for monitor of AED-X
[
    QGVAR(timeLimit_AEDX),
    "SLIDER",
    LLSTRING(TIMELIMIT_AED_X),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [60, 14400, 1800, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(DeactMon_whileAED_X),
    "CHECKBOX",
    LLSTRING(DEACTIVATE_MONITOR_WHILEAED_X),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [true],
    true
] call CBA_Settings_fnc_init;

//No aggresive AED Sounds (Beeps and charging)
[
    QGVAR(AED_BeepsAndCharge),
    "CHECKBOX",
    [LLSTRING(SETTING_AED_BeepsAndCharge), LLSTRING(SETTING_AED_BeepsAndCharge_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Sets type of tone played on AED-X monitor when patient has no heart rate
[
    QGVAR(AED_X_Monitor_NoHeartRate),
    "LIST",
    [LLSTRING(SETTING_AED_X_Monitor_NoHeartRate)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [[0, 1], [LLSTRING(SETTING_AED_X_Monitor_NoHeartRate_Continous), LLSTRING(SETTING_AED_X_Monitor_NoHeartRate_Alternating)], 0],
    true
] call CBA_Settings_fnc_init;

// Sets SpO2 level threshold for audible warning
[
    QGVAR(AED_X_Monitor_SpO2Warning),
    "SLIDER",
    LELSTRING(breathing,SETTING_Threshold_SpO2Warning),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 100, 85, 1],
    true
] call CBA_Settings_fnc_init;

//Enable different CPR chances per medical level
[
    QGVAR(enable_CPR_Chances),
    "CHECKBOX",
    LLSTRING(SETTING_CPR_CHANCES),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CPR)],
    [true],
    true
] call CBA_Settings_fnc_init;

//Max CPR Chance for Doctors
[
    QGVAR(CPR_MaxChance_Doctor),
    "SLIDER",
    LLSTRING(CPR_MaxChance_Doctor),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CPR)],
    [0,100,40,0],
    true
] call CBA_Settings_fnc_init;

//Min CPR Chance for Doctors
[
    QGVAR(CPR_MinChance_Doctor),
    "SLIDER",
    LLSTRING(CPR_MinChance_Doctor),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CPR)],
    [0,100,20,0],
    true
] call CBA_Settings_fnc_init;

//Max CPR Chance for Regular medics
[
    QGVAR(CPR_MaxChance_RegularMedic),
    "SLIDER",
    LLSTRING(CPR_MaxChance_RegularMedic),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CPR)],
    [0,100,30,0],
    true
] call CBA_Settings_fnc_init;

//Min CPR Chance for Regular medics
[
    QGVAR(CPR_MinChance_RegularMedic),
    "SLIDER",
    LLSTRING(CPR_MinChance_RegularMedic),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CPR)],
    [0,100,15,0],
    true
] call CBA_Settings_fnc_init;

//Max CPR Chance for Default
[
    QGVAR(CPR_MaxChance_Default),
    "SLIDER",
    LLSTRING(CPR_MaxChance_Default),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CPR)],
    [0,100,20,0],
    true
] call CBA_Settings_fnc_init;

//Min CPR Chance for Default
[
    QGVAR(CPR_MinChance_Default),
    "SLIDER",
    LLSTRING(CPR_MinChance_Default),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CPR)],
    [0,100,10,0],
    true
] call CBA_Settings_fnc_init;

//Blood draw uses blood groups
[
    QGVAR(bloodGroups),
    "CHECKBOX",
    LLSTRING(SETTING_DRAW_BLOODGROUPS),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_BloodDraw)],
    [true],
    true
] call CBA_Settings_fnc_init;

//Enable self blood draw
[
    QGVAR(enable_selfBloodDraw),
    "LIST",
    LLSTRING(SETTING_SELF_BLOOD_DRAW),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_BloodDraw)],
    [[0, 1], ["STR_ACE_common_No", "STR_ACE_common_Yes"], 1],
    true
] call CBA_Settings_fnc_init;

//blood draw time for 500ml kit
[
    QGVAR(blood_drawTime_500ml),
    "SLIDER",
    LLSTRING(SETTING_BLOOD_DRAWTIME_500ML),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_BloodDraw)],
    [1,600,50,0],
    true
] call CBA_Settings_fnc_init;

//blood draw time for 250ml kit
[
    QGVAR(blood_drawTime_250ml),
    "SLIDER",
    LLSTRING(SETTING_BLOOD_DRAWTIME_250ML),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_BloodDraw)],
    [1,600,25,0],
    true
] call CBA_Settings_fnc_init;

//Minimum acceptable blood volume for drawing blood
[
    QGVAR(blood_draw_limit),
    "SLIDER",
    [LLSTRING(SETTING_MINIMUM_SAFE_DRAW),LLSTRING(SETTING_MINIMUM_SAFE_DRAW_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_BloodDraw)],
    [0, 6, 3.6, 1], // 3.6 default matches ACE Class IV hemorrhage 
    true
] call CBA_Settings_fnc_init;

ADDON = true;