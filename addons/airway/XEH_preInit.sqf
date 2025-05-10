#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Airway"

/*
When a patient enters the unconscious state, there are two things that can happen.
First of all the airway can collapse. In medical sense this mean, the airway can be blocked from your tongue muscle, 'cause of the missing muscle tone.
For example in real life, this will happen to nearly every unconscious person lying on the back.

The second thing that can happen is the the airway occluded state. When a patient is lying on the back and the body puke, it will not leave the mouth space.
It will stay in there and can block the airway too. The right treatment here, is to remove this vomit.
In real life, this will happen sometimes, not quiet often.
*/

// Enable airway injuries
[
    QGVAR(enable),
    "CHECKBOX",
    LLSTRING(SETTING_ENABLE),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Settable action time for CheckAirway
[
    QGVAR(CheckAirway_time),
    "SLIDER",
    [LLSTRING(TIME_CHECKAIRWAY),LLSTRING(TIME_CHECKAIRWAY_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [1, 10, 2, 0],
    true
] call CBA_Settings_fnc_init;

// airway Injuries probability obstruction
[
    QGVAR(probability_obstruction),
    "SLIDER",
    [LLSTRING(SETTING_obstruction),LLSTRING(SETTING_obstruction_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 100, 15, 0],
    true
] call CBA_Settings_fnc_init;

// airway Injuries probability occluded
[
    QGVAR(probability_occluded),
    "SLIDER",
    [LLSTRING(SETTING_occluded),LLSTRING(SETTING_occluded_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 100, 10, 0],
    true
] call CBA_Settings_fnc_init;

// Occlusion repeat timer
[
    QGVAR(occlusion_repeatTimer),
    "SLIDER",
    LLSTRING(SETTING_occlusion_repeatTimer),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [1, 1200, 60, 0],
    true
] call CBA_Settings_fnc_init;

// Set period during which patient cannot get another occlusion after last occlusion was cleared, disabled if 0
[
    QGVAR(occlusion_cooldownPeriod),
    "SLIDER",
    LLSTRING(SETTING_occlusion_cooldownPeriod),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 60, 6, 1],
    true
] call CBA_Settings_fnc_init;

// Succes for headturning
[
    QGVAR(probability_headturning),
    "SLIDER",
    [LLSTRING(SUCCES_HEADTURNING),LLSTRING(SUCCES_HEADTURNING_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [1, 100, 50, 0],
    true
] call CBA_Settings_fnc_init;

// Settable action time for Head turning
[
    QGVAR(HeadTurn_Interval),
    "SLIDER",
    [LLSTRING(SETTING_HeadTurning_Interval), LLSTRING(SETTING_HeadTurning_Interval_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [1, 30, 3, 0],
    true
] call CBA_Settings_fnc_init;

// Blocks head turning if patient has Guedel Tube or KingLT inserted
[
    QGVAR(block_headTurning_ifAirwayItem),
    "CHECKBOX",
    [LLSTRING(BLOCK_HEADTURNING),LLSTRING(BLOCK_HEADTURNING_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// airway puking sound yes or no?
// somebody told me that the sound which is played then someone is puking is super annoying and now you can remove it easily
[
    QGVAR(checkbox_puking_sound),
    "CHECKBOX",
    LLSTRING(SETTING_puking_sound),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(string_exit),
    "LIST",
    ["keko_wasPunched string", LLSTRING(SETTING_exit)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [["", "keko_wasPunched"], ["", "keko_wasPunched"], 0],
    true
] call CBA_Settings_fnc_init;

//Settable list for using Larynxtubus per medical class
[
    QGVAR(medLvl_Larynxtubus),
    "LIST",
    [LLSTRING(ALLOW_LARYNXTUBUS),LLSTRING(ALLOW_LARYNXTUBUS_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

//Settable list for using Guedeltubus per medical class
[
    QGVAR(medLvl_Guedeltubus),
    "LIST",
    [LLSTRING(ALLOW_GUEDELTUBUS),LLSTRING(ALLOW_GUEDELTUBUS_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

//Settable list for using Accuvac per medical class
[
    QGVAR(medLvl_Accuvac),
    "LIST",
    [LLSTRING(ALLOW_ACCUVAC),LLSTRING(ALLOW_ACCUVAC_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Suction)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

// Settable action time for Accuvac
[
    QGVAR(Accuvac_time),
    "SLIDER",
    [LLSTRING(TIME_ACCUVAC),LLSTRING(TIME_ACCUVAC_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Suction)],
    [1, 30, 8, 0],
    true
] call CBA_Settings_fnc_init;

//Settable list for using Manual Suction Pump per medical class
[
    QGVAR(medLvl_Suction),
    "LIST",
    [LLSTRING(ALLOW_SUCTION),LLSTRING(ALLOW_SUCTION_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Suction)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_settings_fnc_init;

// Settable action time for Manual Suction Pump
[
    QGVAR(Suction_time),
    "SLIDER",
    [LLSTRING(TIME_SUCTION),LLSTRING(TIME_SUCTION_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Suction)],
    [1, 30, 12, 0],
    true
] call CBA_Settings_fnc_init;

// Reuse Item checkbox for Manual Suction Pump
[
    QGVAR(Suction_reuse),
    "CHECKBOX",
    [LLSTRING(SUCTION_REUSE),LLSTRING(SUCTION_REUSE_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Suction)],
    [false],
    true
] call CBA_Settings_fnc_init;

// Settable action time for Larynxtubus
[
    QGVAR(Larynxtubus_time),
    "SLIDER",
    [LLSTRING(TIME_LARYNXTUBUS),LLSTRING(TIME_LARYNXTUBUS_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [1, 10, 3, 0],
    true
] call CBA_Settings_fnc_init;

// Settable action time for Guedeltubus
[
    QGVAR(Guedeltubus_time),
    "SLIDER",
    [LLSTRING(TIME_GUEDELTUBUS),LLSTRING(TIME_GUEDELTUBUS_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [1, 20, 6, 0],
    true
] call CBA_Settings_fnc_init;

// Enable reuasble Larynxtubus & Guedeltubus
[
    QGVAR(ReusableAirwayItems),
    "CHECKBOX",
    [LLSTRING(Reusable_AirwayItems),LLSTRING(Reusable_AirwayItems_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Items)],
    [false],
    true
] call CBA_Settings_fnc_init;

// Settable action time for Head overstretching
[
    QGVAR(Hyperextend_Time),
    "SLIDER",
    [LLSTRING(Hyperextend_Time), LLSTRING(Hyperextend_Time_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_RecoveryPositionHyperextend)],
    [1, 10, 3, 0],
    true
] call CBA_Settings_fnc_init;

// Settable action time for Recovery position
[
    QGVAR(RecoveryPosition_Time),
    "SLIDER",
    [LLSTRING(SETTING_RecoveryPosition_Time), LLSTRING(SETTING_RecoveryPosition_Time_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_RecoveryPositionHyperextend)],
    [1, 60, 6, 0],
    true
] call CBA_Settings_fnc_init;

// Settable action time for Cancel recovery position
[
    QGVAR(CancelRecoveryPosition_Time),
    "SLIDER",
    [LLSTRING(SETTING_CancelRecoveryPosition_Time), LLSTRING(SETTING_CancelRecoveryPosition_Time_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_RecoveryPositionHyperextend)],
    [1, 60, 3, 0],
    true
] call CBA_Settings_fnc_init;

// Settable maximum time required for occlusion to be cleared from patient in recovery position
[
    QGVAR(RecoveryPosition_TimeToDrain),
    "SLIDER",
    [LLSTRING(SETTING_RecoveryPosition_TimeToDrain), LLSTRING(SETTING_RecoveryPosition_TimeToDrain_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_RecoveryPositionHyperextend)],
    [0, 30, 10, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(autoTriage),
    "CHECKBOX",
    [LLSTRING(AutoTriage),LLSTRING(AutoTriage_Desc)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
