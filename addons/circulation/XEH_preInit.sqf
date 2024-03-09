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
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Sets how player bloodtype is designated
[
    QGVAR(bloodTypeSetting),
    "LIST",
    [LLSTRING(SETTING_bloodtype_assign), LLSTRING(SETTING_bloodtype_assign_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [[0,1,2,3,4,5],[LSTRING(SETTING_bloodtype_assign_player), LSTRING(SETTING_bloodtype_assign_player_forced), LSTRING(SETTING_bloodtype_assign_random), LSTRING(SETTING_bloodtype_assign_random_onJoin), LSTRING(SETTING_bloodtype_assign_steamid), LSTRING(SETTING_bloodtype_assign_steamid_custom)],4],
    true
] call CBA_Settings_fnc_init;

// Sets if randomizer should be weighted (according to bloodtype commonness)
[
    QGVAR(bloodTypeRandomWeighted),
    "CHECKBOX",
    [LLSTRING(SETTING_bloodtype_random_weighted), LLSTRING(SETTING_bloodtype_random_weighted_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Sets the player's desired bloodtype
[
    QGVAR(bloodTypeSettingPlayer),
    "LIST",
    LLSTRING(SETTING_bloodtype_player),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [["A", "A_N", "B", "B_N", "AB", "AB_N", "O", "O_N"], ["A+", "A-", "B+", "B-", "AB+", "AB-", "0+", "0-"], 7],
    2,
    {
        profileNamespace setVariable [QGVAR(preferredBloodType), _this];
        saveProfileNamespace;
        player setVariable [QACEGVAR(dogtags,dogtagData), nil, true];
    },
    false
] call CBA_Settings_fnc_init;

// Custom bloodtype list to use with custom steamid option
[
    QGVAR(bloodTypeCustomList),
    "EDITBOX",
    [LLSTRING(SETTING_bloodtype_custom_list), LLSTRING(SETTING_bloodtype_custom_list_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
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
    [1, 100, 50, 0],
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
    [1, 100, 45, 0],
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

//Sets medical level required to pick up placed AED/X Station
[
    QGVAR(medLvl_AED_Station_Interact),
    "LIST",
    [LLSTRING(SETTING_AEDStation_AllowInteraction),LLSTRING(SETTING_AEDStation_AllowInteraction_DESCRIPTION)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

// Sets time required to attach AED-X monitor
[
    QGVAR(AEDX_VitalsMonitor_AttachTime),
    "SLIDER",
    LLSTRING(SETTING_AEDX_VitalsMonitor_AttachTime),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 60, 6, 1],
    true
] call CBA_Settings_fnc_init;

// Sets time required to detach AED-X monitor
[
    QGVAR(AEDX_VitalsMonitor_DetachTime),
    "SLIDER",
    LLSTRING(SETTING_AEDX_VitalsMonitor_DetachTime),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 60, 3, 1],
    true
] call CBA_Settings_fnc_init;

// Sets time required to attach defibrillator pads
[
    QGVAR(DefibrillatorPads_AttachTime),
    "SLIDER",
    LLSTRING(SETTING_DefibrillatorPads_AttachTime),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 60, 6, 1],
    true
] call CBA_Settings_fnc_init;

// Sets time required to detach defibrillator pads
[
    QGVAR(DefibrillatorPads_DetachTime),
    "SLIDER",
    LLSTRING(SETTING_DefibrillatorPads_DetachTime),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 60, 3, 1],
    true
] call CBA_Settings_fnc_init;

// Distance limit for AED
[
    QGVAR(Defibrillator_DistanceLimit),
    "SLIDER",
    LLSTRING(SETTING_Defibrillator_DistanceLimit),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [2, 15, 6, 0],
    true
] call CBA_Settings_fnc_init;

// Sets sounds played by AED-X vitals monitor
[
    QGVAR(AED_X_VitalsMonitor_SoundsSelect),
    "LIST",
    [LLSTRING(SETTING_AED_X_VitalsMonitor_SoundsSelect)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [[0, 1], [LLSTRING(SETTING_AED_X_VitalsMonitor_SoundsSelect_Original), LLSTRING(SETTING_AED_X_VitalsMonitor_SoundsSelect_Default)], 1],
    true
] call CBA_Settings_fnc_init;

// Sets SpO2 level threshold for audible warning
[
    QGVAR(AED_X_Monitor_SpO2Warning),
    "SLIDER",
    LLSTRING(SETTING_Threshold_SpO2Warning),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [1, 100, 85, 1],
    true
] call CBA_Settings_fnc_init;

// Sets vitals monitor blood pressure measurement behaviour
// Automatic Instant - every second along with HR
// Automatic - use set time interval to update and store BP for patient
// Manual - must manually push to measure BP on AED-X
[
    QGVAR(AED_X_VitalsMonitor_BloodPressureInterval),
    "LIST",
    [LLSTRING(SETTING_AED_X_VitalsMonitor_BloodPressureInterval)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [[0, 1, 2], [LLSTRING(SETTING_AED_X_VitalsMonitor_BloodPressureInterval_AutomaticInstant), LLSTRING(SETTING_AED_X_VitalsMonitor_BloodPressureInterval_Automatic), LLSTRING(SETTING_AED_X_VitalsMonitor_BloodPressureInterval_Manual)], 0],
    true
] call CBA_Settings_fnc_init;

// Set vitals monitor blood pressure measurement time interval
[
    QGVAR(AED_X_VitalsMonitor_BloodPressureInterval_Time),
    "SLIDER",
    [LLSTRING(SETTING_AED_X_VitalsMonitor_BloodPressureInterval_Time)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AED)],
    [30, 300, 30, 0],
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

// Sets interval at which CPR chance is rolled
[
    QGVAR(CPR_ChanceInterval),
    "SLIDER",
    LLSTRING(SETTING_CPR_ChanceInterval),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CPR)],
    [1 , 3600, 15, 0],
    true
] call CBA_Settings_fnc_init;

// Sets oxygenation period length after CPR has stopped
[
    QGVAR(CPR_OxygenationPeriod),
    "SLIDER",
    LLSTRING(SETTING_CPR_OxygenationPeriod),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CPR)],
    [0, 3600, 15, 0],
    true
] call CBA_Settings_fnc_init;

//Advanced Rhythms
[
    QGVAR(AdvRhythm),
    "CHECKBOX",
    LLSTRING(SETTING_AdvRhythm_Enable),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [true],
    true,
    {},
    true
] call CBA_Settings_fnc_init;

// Sets if cardiac arrest rhythms can deteriorate
[
    QGVAR(AdvRhythm_canDeteriorate),
    "CHECKBOX",
    LLSTRING(SETTING_AdvRhythm_canDeteriorate),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Sets maximum time for cardiac arrest rhythm deterioration randomizer
[
    QGVAR(AdvRhythm_deteriorateTimeMax),
    "SLIDER",
    LLSTRING(SETTING_AdvRhythm_deteriorateTimeMax),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [30,3600,900,0],
    true
] call CBA_Settings_fnc_init;

// Sets time weight for cardiac arrest rhythm deterioration time randomizer // should be less than maximum
[
    QGVAR(AdvRhythm_deteriorateTimeWeight),
    "SLIDER",
    LLSTRING(SETTING_AdvRhythm_deteriorateTimeWeight),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [20,3600,180,0],
    true
] call CBA_Settings_fnc_init;

// Sets chance for Pulseless Electrical Activity / Asystole
[
    QGVAR(AdvRhythm_PEAChance),
    "SLIDER",
    LLSTRING(SETTING_AdvRhythm_PEAChance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [0,100,50,0],
    true
] call CBA_Settings_fnc_init;

// Sets chance for Ventricular Tachycardia / Ventricular Fibrillation
[
    QGVAR(AdvRhythm_VTChance),
    "SLIDER",
    LLSTRING(SETTING_AdvRhythm_VTChance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [0,100,50,0],
    true
] call CBA_Settings_fnc_init;

// Non-shockable Bloodloss Threshold
[
    QGVAR(AdvRhythm_asystoleBloodlossThreshold),
    "SLIDER",
    LLSTRING(SETTING_AdvRhythm_asystoleBloodlossThreshold),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [0,6.0,3.6,1],
    true
] call CBA_Settings_fnc_init;

// Sets if cardiac arrest rhythm can deteriorate after CPR/AED treatment
[
    QGVAR(AdvRhythm_deteriorateAfterTreatment),
    "CHECKBOX",
    LLSTRING(SETTING_AdvRhythm_deteriorateAfterTreatment),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Sets chance for Return Of Spontaneous Circulation after CPR
[
    QGVAR(AdvRhythm_CPR_ROSC_Chance),
    "SLIDER",
    LLSTRING(SETTING_AdvRhythm_CPR_ROSC_Chance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [0,100,5,0],
    true
] call CBA_Settings_fnc_init;

// Sets chance for Return Of Spontaneous Circulation after AED
[
    QGVAR(AdvRhythm_AED_ROSC_Chance),
    "SLIDER",
    LLSTRING(SETTING_AdvRhythm_AED_ROSC_Chance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [0,100,50,0],
    true
] call CBA_Settings_fnc_init;

// Sets if hardcore cardiac arrest rhythm behaviours are enabled
// Incorrect AED usage (stable/non-shockable) has chance to deteriorate rhythm
// Chance for cardiac arrest rhythm to deteriorate from shockable straight to non-shockable
[
    QGVAR(AdvRhythm_Hardcore_Enable),
    "CHECKBOX",
    LLSTRING(SETTING_AdvRhythm_Hardcore_Enable),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [false],
    true
] call CBA_Settings_fnc_init;

// Sets chance for cardiac arrest rhythm to deteriorate from shockable straight to non-shockable
[
    QGVAR(AdvRhythm_hardcoreDeteriorationChance),
    "SLIDER",
    LLSTRING(SETTING_AdvRhythm_hardcoreDeteriorationChance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [0,100,10,0],
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

//Blood draw uses blood groups
[
    QGVAR(bloodGroups),
    "CHECKBOX",
    LLSTRING(SETTING_DRAW_BLOODGROUPS),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_BloodDraw)],
    [true],
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

[
    QGVAR(cardiacArrestBleedRate),
    "SLIDER",
    LLSTRING(SETTING_cardiacArrestBleedRate),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 0.2, 0.05, 3],
    true
] call CBA_Settings_fnc_init;

// Chance of tamponade from chest wounds
[
    QGVAR(tamponadeChance),
    "SLIDER",
    LLSTRING(SETTING_tamponadeChance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [0,100,10,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(deterioratingTamponade_chance),
    "SLIDER",
    LLSTRING(SETTING_tamponadeChance_deterioration),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [0,100,35,0],
    true
] call CBA_Settings_fnc_init;

// Tamponade deterioration timer
[
    QGVAR(deterioratingTamponade_interval),
    "SLIDER",
    LLSTRING(SETTING_tamponadeInterval),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AdvRhythms)],
    [0,3600,60,0],
    true
] call CBA_Settings_fnc_init;



ADDON = true;