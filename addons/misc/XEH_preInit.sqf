#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Misc"

//Enable aceExposure things
[
    QGVAR(enable),
    "CHECKBOX",
    LLSTRING(SETTING_ENABLE),
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Sets whether player can use items straight from vehicle inventory for treatment, and their priority
[
    QGVAR(allowSharedVehicleEquipment),
    "LIST",
    [LLSTRING(SETTING_allowSharedVehicleEquipment), LLSTRING(SETTING_allowSharedVehicleEquipment_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [[0, 1, 2, 3, 4], ["STR_ACE_Common_No", "STR_ACE_Medical_Treatment_AllowSharedEquipment_PriorityMedic", LLSTRING(SETTING_allowSharedVehicleEquipment_PriorityVehicleNoSelfTreatment), LLSTRING(SETTING_allowSharedVehicleEquipment_PriorityVehicleExceptSelfTreatment), LLSTRING(SETTING_allowSharedVehicleEquipment_PriorityVehicleAlways)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTimeDetachTourniquet),
    "SLIDER",
    [LLSTRING(SETTING_treatmentTimeDetachTourniquet)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [1, 60, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(neckTourniquet),
    "CHECKBOX",
    [LLSTRING(neckTourniquetDescription)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;


//Incompatibility Warning with other addons
[
    QGVAR(incompatibilityWarning),
    "CHECKBOX",
    [LLSTRING(SETTING_incompatibilityWarning), LLSTRING(SETTING_incompatibilityWarning_Desc)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

//Adjust armband sling left arm (x, y, z)
[
    QGVAR(armbandSlingLeftArm),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingLeftArmPos_Display), LLSTRING(SETTING_ArmbandSlingLeftArmPos_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "0.2, -0.39, -0.2",
    2
] call CBA_Settings_fnc_init;

//Adjust armband rotation left arm (yaw, pitch, roll)
[
    QGVAR(armbandSlingLeftArmRotation),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingLeftArmRot_Display), LLSTRING(SETTING_ArmbandSlingLeftArmRot_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "240, 33, 26",
    2
] call CBA_Settings_fnc_init;

//Adjust armband sling right arm (x, y, z)
[
    QGVAR(armbandSlingRightArm),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingRightArmPos_Display), LLSTRING(SETTING_ArmbandSlingRightArmPos_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "-0.228, -0.1, -0.43",
    2
] call CBA_Settings_fnc_init;

//Adjust armband rotation right arm (yaw, pitch, roll)
[
    QGVAR(armbandSlingRightArmRotation),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingRightArmRot_Display), LLSTRING(SETTING_ArmbandSlingRightArmRot_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "5, -5, -5",
    2
] call CBA_Settings_fnc_init;

//Adjust armband sling left leg (x, y, z)
[
    QGVAR(armbandSlingLeftLeg),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingLeftLegPos_Display), LLSTRING(SETTING_ArmbandSlingLeftLegPos_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "0.435, -0.075, -0.38",
    2
] call CBA_Settings_fnc_init;

//Adjust armband rotation left leg (yaw, pitch, roll)
[
    QGVAR(armbandSlingLeftLegRotation),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingLeftLegRot_Display), LLSTRING(SETTING_ArmbandSlingLeftLegRot_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "-160, -5, 45",
    2
] call CBA_Settings_fnc_init;

//Adjust armband sling right leg (x, y, z)
[
    QGVAR(armbandSlingRightLeg),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingRightLegPos_Display), LLSTRING(SETTING_ArmbandSlingRightLegPos_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "-0.32, -0.29, -0.42",
    2
] call CBA_Settings_fnc_init;

//Adjust armband rotation right Leg (yaw, pitch, roll)
[
    QGVAR(armbandSlingRightLegRotation),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingRightLegRot_Display), LLSTRING(SETTING_ArmbandSlingRightLegRot_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "-30, -5, 38",
    2
] call CBA_Settings_fnc_init;

ADDON = true;
