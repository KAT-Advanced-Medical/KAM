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
    [[0, 1, 2, 3, 4], ["STR_ACE_Common_No", "STR_ACE_Medical_Treatment_AllowSharedEquipment_PriorityMedic", LLSTRING(SETTING_allowSharedVehicleEquipment_PriorityVehicleNoSelfTreatment), LLSTRING(SETTING_allowSharedVehicleEquipment_PriorityVehicleExceptSelfTreatment), LLSTRING(SETTING_allowSharedVehicleEquipment_PriorityVehicleAlways)], 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTimeDetachTourniquet),
    "SLIDER",
    [LLSTRING(SETTING_treatmentTimeDetachTourniquet)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Tourniquet)],
    [1, 60, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(neckTourniquet),
    "CHECKBOX",
    [LLSTRING(neckTourniquetDescription)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Tourniquet)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(tourniquetEffects_Enable),
    "CHECKBOX",
    [LLSTRING(SETTING_tourniquetEffects_Enable)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Tourniquet)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(tourniquetEffects_PositiveMultiplier),
    "SLIDER",
    [LLSTRING(SETTING_tourniquetEffects_PositiveMultiplier)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Tourniquet)],
    [0.1, 10, 1, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(tourniquetEffects_NegativeMultiplier),
    "SLIDER",
    [LLSTRING(SETTING_tourniquetEffects_NegativeMultiplier)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Tourniquet)],
    [0.1, 10, 1, 1],
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
    "[0.2, -0.39, -0.2]",
    2,
    {
        private _string = missionNamespace getVariable [QGVAR(armbandSlingLeftArm), ""];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(armbandSlingLeftArm), _array, true];
    }
] call CBA_Settings_fnc_init;

//Adjust armband rotation left arm (yaw, pitch, roll)
[
    QGVAR(armbandSlingLeftArmRotation),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingLeftArmRot_Display), LLSTRING(SETTING_ArmbandSlingLeftArmRot_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "[240, 33, 26]",
    2,
    {
        private _string = missionNamespace getVariable [QGVAR(armbandSlingLeftArmRotation), ""];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(armbandSlingLeftArmRotation), _array, true];
    }
] call CBA_Settings_fnc_init;

//Adjust armband sling right arm (x, y, z)
[
    QGVAR(armbandSlingRightArm),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingRightArmPos_Display), LLSTRING(SETTING_ArmbandSlingRightArmPos_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "[-0.228, -0.1, -0.43]",
    2,
    {
        private _string = missionNamespace getVariable [QGVAR(armbandSlingRightArm), ""];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(armbandSlingRightArm), _array, true];
    }
] call CBA_Settings_fnc_init;

//Adjust armband rotation right arm (yaw, pitch, roll)
[
    QGVAR(armbandSlingRightArmRotation),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingRightArmRot_Display), LLSTRING(SETTING_ArmbandSlingRightArmRot_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "[5, -5, -5]",
    2,
    {
        private _string = missionNamespace getVariable [QGVAR(armbandSlingRightArmRotation), ""];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(armbandSlingRightArmRotation), _array, true];
    }
] call CBA_Settings_fnc_init;

//Adjust armband sling left leg (x, y, z)
[
    QGVAR(armbandSlingLeftLeg),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingLeftLegPos_Display), LLSTRING(SETTING_ArmbandSlingLeftLegPos_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "[0.435, -0.075, -0.38]",
    2,
    {
        private _string = missionNamespace getVariable [QGVAR(armbandSlingLeftLeg), ""];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(armbandSlingLeftLeg), _array, true];
    }
] call CBA_Settings_fnc_init;

//Adjust armband rotation left leg (yaw, pitch, roll)
[
    QGVAR(armbandSlingLeftLegRotation),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingLeftLegRot_Display), LLSTRING(SETTING_ArmbandSlingLeftLegRot_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "[-160, -5, 45]",
    2,
    {
        private _string = missionNamespace getVariable [QGVAR(armbandSlingLeftLegRotation), ""];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(armbandSlingLeftLegRotation), _array, true];
    }
] call CBA_Settings_fnc_init;

//Adjust armband sling right leg (x, y, z)
[
    QGVAR(armbandSlingRightLeg),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingRightLegPos_Display), LLSTRING(SETTING_ArmbandSlingRightLegPos_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "[-0.32, -0.29, -0.42]",
    2,
    {
        private _string = missionNamespace getVariable [QGVAR(armbandSlingRightLeg), ""];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(armbandSlingRightLeg), _array, true];
    }
] call CBA_Settings_fnc_init;

//Adjust armband rotation right Leg (yaw, pitch, roll)
[
    QGVAR(armbandSlingRightLegRotation),
    "EDITBOX",
    [LLSTRING(SETTING_ArmbandSlingRightLegRot_Display), LLSTRING(SETTING_ArmbandSlingRightLegRot_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Armband)],
    "[-30, -5, 38]",
    2,
    {
        private _string = missionNamespace getVariable [QGVAR(armbandSlingRightLegRotation), ""];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(armbandSlingRightLegRotation), _array, true];
    }
] call CBA_Settings_fnc_init;

// Remove IFAK when empty
[
    QGVAR(IFAK_RemoveWhenEmpty),
    "CHECKBOX",
    LLSTRING(SETTING_FAK_RemoveWhenEmpty),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    [true],
    true
] call CBA_fnc_addSetting;

//IFAK Container
[
    QGVAR(IFAK_Container),
    "LIST",
    [LLSTRING(SETTING_FAK_Container), LLSTRING(SETTING_FAK_Container_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    [[0, 1, 2, 3], [LLSTRING(SETTING_Container_Default), LLSTRING(SETTING_Container_Uniform), LLSTRING(SETTING_Container_Vest), LLSTRING(SETTING_Container_Backpack)], 0],
    2
] call CBA_fnc_addSetting;

//IFAK Slot Color
[
    QGVAR(IFAK_Slot_Color),
    "COLOR",
    [LLSTRING(SETTING_FAK_SlotColor), LLSTRING(SETTING_FAK_SlotColor_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    [1, 0.30, 0.30],
    2
] call CBA_fnc_addSetting;

//IFAK Item Color
[
    QGVAR(IFAK_Item_Color),
    "COLOR",
    [LLSTRING(SETTING_FAK_ItemColor), LLSTRING(SETTING_FAK_ItemColor_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    [0.67, 0.84, 0.90],
    2
] call CBA_fnc_addSetting;

//IFAK First Slot Item
[
    QGVAR(IFAKFirstSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FirstSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    "[['ACE_tourniquet', 2]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(IFAKFirstSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(IFAKFirstSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//IFAK Second Slot Item
[
    QGVAR(IFAKSecondSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SecondSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    "[['ACE_packingBandage', 5], ['ACE_quikclot', 5]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(IFAKSecondSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(IFAKSecondSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//IFAK Third Slot Item
[
    QGVAR(IFAKThirdSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_ThirdSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    "[['kat_Painkiller', 1]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(IFAKThirdSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(IFAKThirdSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//IFAK Fourth Item
[
    QGVAR(IFAKFourthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FourthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    "[['kat_chestSeal', 1]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(IFAKFourthSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(IFAKFourthSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

// Remove AFAK when empty
[
    QGVAR(AFAK_RemoveWhenEmpty),
    "CHECKBOX",
    LLSTRING(SETTING_FAK_RemoveWhenEmpty),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [true],
    true
] call CBA_fnc_addSetting;

//AFAK Container
[
    QGVAR(AFAK_Container),
    "LIST",
    [LLSTRING(SETTING_FAK_Container), LLSTRING(SETTING_FAK_Container_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [[0, 1, 2, 3], [LLSTRING(SETTING_Container_Default), LLSTRING(SETTING_Container_Uniform), LLSTRING(SETTING_Container_Vest), LLSTRING(SETTING_Container_Backpack)], 0],
    2
] call CBA_fnc_addSetting;

//AFAK Slot Color
[
    QGVAR(AFAK_Slot_Color),
    "COLOR",
    [LLSTRING(SETTING_FAK_SlotColor), LLSTRING(SETTING_FAK_SlotColor_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [1, 0.96, 0.32],
    2
] call CBA_fnc_addSetting;

//AFAK Item Color
[
    QGVAR(AFAK_Item_Color),
    "COLOR",
    [LLSTRING(SETTING_FAK_ItemColor), LLSTRING(SETTING_FAK_ItemColor_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [0.67, 0.84, 0.90],
    2
] call CBA_fnc_addSetting;

//AFAK First Slot Item
[
    QGVAR(AFAKFirstSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FirstSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "[['ACE_tourniquet', 4], ['ACE_splint', 2]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(AFAKFirstSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(AFAKFirstSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//AFAK Second Slot Item
[
    QGVAR(AFAKSecondSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SecondSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "[['ACE_packingBandage', 10], ['ACE_quikclot', 10]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(AFAKSecondSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(AFAKSecondSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//AFAK Third Slot Item
[
    QGVAR(AFAKThirdSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_ThirdSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "[['ACE_morphine', 3], ['kat_Penthrox', 1], ['kat_Painkiller', 1]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(AFAKThirdSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(AFAKThirdSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//AFAK Fourth Item
[
    QGVAR(AFAKFourthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FourthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "[['kat_chestSeal', 3], ['kat_ncdKit', 3]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(AFAKFourthSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(AFAKFourthSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//AFAK Fifth Item
[
    QGVAR(AFAKFifthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FifthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "[['kat_guedel', 4]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(AFAKFifthSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(AFAKFifthSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//AFAK Sixth Item
[
    QGVAR(AFAKSixthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SixthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "[['ACE_epinephrine', 3], ['kat_Carbonate', 1]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(AFAKSixthSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(AFAKSixthSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

// Remove MFAK when empty
[
    QGVAR(MFAK_RemoveWhenEmpty),
    "CHECKBOX",
    LLSTRING(SETTING_FAK_RemoveWhenEmpty),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [true],
    true
] call CBA_fnc_addSetting;

//MFAK Container
[
    QGVAR(MFAK_Container),
    "LIST",
    [LLSTRING(SETTING_FAK_Container), LLSTRING(SETTING_FAK_Container_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [[0, 1, 2, 3], [LLSTRING(SETTING_Container_Default), LLSTRING(SETTING_Container_Uniform), LLSTRING(SETTING_Container_Vest), LLSTRING(SETTING_Container_Backpack)], 0],
    2
] call CBA_fnc_addSetting;

//MFAK Slot Color
[
    QGVAR(MFAK_Slot_Color),
    "COLOR",
    [LLSTRING(SETTING_FAK_SlotColor), LLSTRING(SETTING_FAK_SlotColor_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [0.56, 0.93, 0.56],
    2
] call CBA_fnc_addSetting;

//MFAK Item Color
[
    QGVAR(MFAK_Item_Color),
    "COLOR",
    [LLSTRING(SETTING_FAK_ItemColor), LLSTRING(SETTING_FAK_ItemColor_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [0.67, 0.84, 0.90],
    2
] call CBA_fnc_addSetting;

//MFAK First Slot Item
[
    QGVAR(MFAKFirstSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FirstSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "[['ACE_tourniquet', 6], ['ACE_splint', 4]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(MFAKFirstSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(MFAKFirstSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//MFAK Second Slot Item
[
    QGVAR(MFAKSecondSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SecondSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "[['ACE_packingBandage', 15], ['ACE_quikclot', 15], ['ACE_fieldDressing', 15]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(MFAKSecondSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(MFAKSecondSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//MFAK Third Slot Item
[
    QGVAR(MFAKThirdSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_ThirdSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "[['ACE_morphine', 6], ['kat_Painkiller', 2], ['kat_Penthrox', 2]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(MFAKThirdSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(MFAKThirdSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//MFAK Fourth Item
[
    QGVAR(MFAKFourthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FourthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "[['kat_chestSeal', 6], ['kat_aatKit', 3], ['kat_ncdKit', 3], ['kat_stethoscope', 1]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(MFAKFourthSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(MFAKFourthSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//MFAK Fifth Item
[
    QGVAR(MFAKFifthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FifthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "[['kat_larynx', 6]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(MFAKFifthSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(MFAKFifthSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//MFAK Sixth Item
[
    QGVAR(MFAKSixthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SixthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "[['ACE_epinephrine', 6], ['kat_IV_16', 4], ['kat_nitroglycerin', 2], ['kat_phenylephrine', 2], ['kat_atropine', 2], ['kat_naloxone', 2], ['kat_Carbonate', 1]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(MFAKSixthSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(MFAKSixthSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//MFAK Seventh Item
[
    QGVAR(MFAKSeventhSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SeventhSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "[['ACE_salineIV_250', 4], ['kat_IV_16', 4]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(MFAKSeventhSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(MFAKSeventhSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//MFAK Eighth Item
[
    QGVAR(MFAKEighthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_EighthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "[['kat_Pulseoximeter', 1], ['kat_pocketBVM', 1], ['kat_AED', 1]]",
    1,
    {
        private _string = missionNamespace getVariable [QGVAR(MFAKEighthSlotItem), []];
        private _array = parseSimpleArray _string;
        missionNamespace setVariable [QGVAR(MFAKEighthSlotItem), _array, true];
        call FUNC(FAK_updateContents);
    }
] call CBA_Settings_fnc_init;

//Enable's Stitching of the Full Body 
[
    QGVAR(enableStitchFullBody),
    "CHECKBOX",
    [LLSTRING(SETTING_EnableStitchFullBody), LLSTRING(SETTING_EnableStitchFullBody_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
