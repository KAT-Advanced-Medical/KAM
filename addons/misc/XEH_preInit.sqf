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
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

// Sets whether player can use items straight from vehicle inventory for treatment, and their priority
[
    QGVAR(allowSharedVehicleEquipment),
    "LIST",
    [LLSTRING(SETTING_allowSharedVehicleEquipment), LLSTRING(SETTING_allowSharedVehicleEquipment_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [[0, 1, 2, 3, 4], ["STR_ACE_Common_No", "STR_ACE_Medical_Treatment_AllowSharedEquipment_PriorityMedic", LLSTRING(SETTING_allowSharedVehicleEquipment_PriorityVehicleNoSelfTreatment), LLSTRING(SETTING_allowSharedVehicleEquipment_PriorityVehicleExceptSelfTreatment), LLSTRING(SETTING_allowSharedVehicleEquipment_PriorityVehicleAlways)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTimeDetachTourniquet),
    "SLIDER",
    [LLSTRING(SETTING_treatmentTimeDetachTourniquet)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [1, 60, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(neckTourniquet),
    "CHECKBOX",
    [LLSTRING(neckTourniquetDescription)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;


//Incompatibility Warning with other addons
[
    QGVAR(incompatibilityWarning),
    "CHECKBOX",
    [LLSTRING(SETTING_incompatibilityWarning), LLSTRING(SETTING_incompatibilityWarning_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

//Enable Arsenal Medical category
[
    QGVAR(arsenalMedCategory),
    "CHECKBOX",
    [LLSTRING(SETTING_arsenalMedCategory), LLSTRING(SETTING_arsenalMedCategory_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Basic)],
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

//IFAK First Slot Item
[
    QGVAR(IFAKFirstSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FirstSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    "ACE_tourniquet",
    1
] call CBA_Settings_fnc_init;

//IFAK First Slot Amount
[
    QGVAR(IFAKFirstSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_FirstSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    [1, 20, 2, 0],
    true
] call CBA_Settings_fnc_init;

//IFAK Second Slot Item
[
    QGVAR(IFAKSecondSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SecondSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    "ACE_packingBandage",
    1
] call CBA_Settings_fnc_init;

//IFAK Second Slot Amount
[
    QGVAR(IFAKSecondSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_SecondSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    [1, 20, 10, 0],
    true
] call CBA_Settings_fnc_init;

//IFAK Third Slot Item
[
    QGVAR(IFAKThirdtSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_ThirdSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    "ACE_quikclot",
    1
] call CBA_Settings_fnc_init;

//IFAK Third Slot Amount
[
    QGVAR(IFAKThirdSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_ThirdSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    [1, 20, 5, 0],
    true
] call CBA_Settings_fnc_init;

//IFAK Fourth Item
[
    QGVAR(IFAKFourthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FourthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    "kat_chestSeal",
    1
] call CBA_Settings_fnc_init;

// IFAK Fourth Amount
[
    QGVAR(IFAKFourthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_FourthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_IFAK)],
    [1, 20, 1, 0],
    true
] call CBA_Settings_fnc_init;

//AFAK First Slot Item
[
    QGVAR(AFAKFirstSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FirstSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "ACE_tourniquet",
    1
] call CBA_Settings_fnc_init;

//AFAK First Slot Amount
[
    QGVAR(AFAKFirstSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_FirstSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [1, 30, 2, 0],
    true
] call CBA_Settings_fnc_init;

//AFAK Second Slot Item
[
    QGVAR(AFAKSecondSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SecondSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "ACE_packingBandage",
    1
] call CBA_Settings_fnc_init;

//AFAK Second Slot Amount
[
    QGVAR(AFAKSecondSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_SecondSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [1, 30, 10, 0],
    true
] call CBA_Settings_fnc_init;

//AFAK Third Slot Item
[
    QGVAR(AFAKThirdtSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_ThirdSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "ACE_quikclot",
    1
] call CBA_Settings_fnc_init;

//AFAK Third Slot Amount
[
    QGVAR(AFAKThirdSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_ThirdSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [1, 30, 10, 0],
    true
] call CBA_Settings_fnc_init;

//AFAK Fourth Item
[
    QGVAR(AFAKFourthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FourthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "ACE_elasticBandage",
    1
] call CBA_Settings_fnc_init;

//AFAK Fourth Amount
[
    QGVAR(AFAKFourthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_FourthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [1, 30, 10, 0],
    true
] call CBA_Settings_fnc_init;

//AFAK Fifth Item
[
    QGVAR(AFAKFifthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FifthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "kat_chestSeal",
    1
] call CBA_Settings_fnc_init;

//AFAK Fifth Amount
[
    QGVAR(AFAKFifthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_FifthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [1, 30, 2, 0],
    true
] call CBA_Settings_fnc_init;

//AFAK Sixth Item
[
    QGVAR(AFAKSixthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SixthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "kat_ncdKit",
    1
] call CBA_Settings_fnc_init;

//AFAK Sixth Amount
[
    QGVAR(AFAKSixthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_SixthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [1, 30, 4, 0],
    true
] call CBA_Settings_fnc_init;

//AFAK Seventh Item
[
    QGVAR(AFAKSeventhSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SeventhSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "kat_larynx",
    1
] call CBA_Settings_fnc_init;

//AFAK Seventh Amount
[
    QGVAR(AFAKSeventhSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_SeventhSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [1, 30, 4, 0],
    true
] call CBA_Settings_fnc_init;

//AFAK Eighth Item
[
    QGVAR(AFAKEighthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_EighthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    "ACE_morphine",
    1
] call CBA_Settings_fnc_init;

//AFAK Eighth Amount
[
    QGVAR(AFAKEighthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_EighthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_AFAK)],
    [1, 30, 4, 0],
    true
] call CBA_Settings_fnc_init;

//MFAK First Slot Item
[
    QGVAR(MFAKFirstSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FirstSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "ACE_tourniquet",
    1
] call CBA_Settings_fnc_init;

//MFAK First Slot Amount
[
    QGVAR(MFAKFirstSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_FirstSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [1, 50, 8, 0],
    true
] call CBA_Settings_fnc_init;

//MFAK Second Slot Item
[
    QGVAR(MFAKSecondSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SecondSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "ACE_packingBandage",
    1
] call CBA_Settings_fnc_init;

//MFAK Second Slot Amount
[
    QGVAR(MFAKSecondSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_SecondSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [1, 50, 20, 0],
    true
] call CBA_Settings_fnc_init;

//MFAK Third Slot Item
[
    QGVAR(MFAKThirdtSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_ThirdSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "ACE_quikclot",
    1
] call CBA_Settings_fnc_init;

//MFAK Third Slot Amount
[
    QGVAR(MFAKThirdSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_ThirdSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [1, 50, 15, 0],
    true
] call CBA_Settings_fnc_init;

//MFAK Fourth Item
[
    QGVAR(MFAKFourthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FourthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "kat_chestSeal",
    1
] call CBA_Settings_fnc_init;

//MFAK Fourth Amount
[
    QGVAR(MFAKFourthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_FourthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [1, 50, 4, 0],
    true
] call CBA_Settings_fnc_init;

//MFAK Fifth Item
[
    QGVAR(MFAKFifthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_FifthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "kat_aatKit",
    1
] call CBA_Settings_fnc_init;

//MFAK Fifth Amount
[
    QGVAR(MFAKFifthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_FifthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [1, 50, 4, 0],
    true
] call CBA_Settings_fnc_init;

//MFAK Sixth Item
[
    QGVAR(MFAKSixthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SixthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "kat_larynx",
    1
] call CBA_Settings_fnc_init;

//MFAK Sixth Amount
[
    QGVAR(MFAKSixthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_SixthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [1, 50, 8, 0],
    true
] call CBA_Settings_fnc_init;

//MFAK Seventh Item
[
    QGVAR(MFAKSeventhSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_SeventhSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "ACE_morphine",
    1
] call CBA_Settings_fnc_init;

//MFAK Seventh Amount
[
    QGVAR(MFAKSeventhSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_SeventhSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [1, 50, 4, 0],
    true
] call CBA_Settings_fnc_init;

//MFAK Eighth Item
[
    QGVAR(MFAKEighthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_EighthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "ACE_epinephrine",
    1
] call CBA_Settings_fnc_init;

//MFAK Eighth Amount
[
    QGVAR(MFAKEighthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_EighthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [1, 50, 4, 0],
    true
] call CBA_Settings_fnc_init;

//MFAK Ninth Item
[
    QGVAR(MFAKNinthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_NinthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "kat_Painkiller",
    1
] call CBA_Settings_fnc_init;

//MFAK Ninth Amount
[
    QGVAR(MFAKNinthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_NinthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [1, 50, 3, 0],
    true
] call CBA_Settings_fnc_init;

//MFAK Tenth Item
[
    QGVAR(MFAKTenthSlotItem),
    "EDITBOX",
    [LLSTRING(SETTING_TenthSlot_Item), LLSTRING(SETTING_ItemSlot_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    "kat_pocketBVM",
    1
] call CBA_Settings_fnc_init;

//MFAK Tenth Amount
[
    QGVAR(MFAKTenthSlotAmount),
    "SLIDER",
    [LLSTRING(SETTING_TenthSlot_Amount), LLSTRING(SETTING_ItemAmount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_MFAK)],
    [1, 50, 1, 0],
    true
] call CBA_Settings_fnc_init;

if (GVAR(arsenalMedCategory)) then {
    [
        ["kat_aatKit","kat_ncdKit","kat_accuvac","ACE_adenosine","ACE_epinephrine","kat_X_AED","ACE_elasticBandage","ACE_packingBandage","kat_crossPanel","kat_bloodIV_O","kat_bloodIV_A","kat_bloodIV_AB","ACE_bloodIV","kat_bloodIV_B","ACE_bloodIV_250","kat_bloodIV_O_250","kat_bloodIV_A_250","kat_bloodIV_AB_250","kat_bloodIV_B_250","ACE_bloodIV_500","kat_bloodIV_O_500","kat_bloodIV_A_500","kat_bloodIV_AB_500","kat_bloodIV_B_500","ACE_bodyBag","KAT_Empty_bloodIV_250","KAT_Empty_bloodIV_500","kat_bloodIV_O_N","kat_bloodIV_A_N","kat_bloodIV_AB_N","kat_bloodIV_B_N","kat_bloodIV_O_N_250","kat_bloodIV_A_N_250","kat_bloodIV_AB_N_250","kat_bloodIV_B_N_250","kat_bloodIV_O_N_500","kat_bloodIV_A_N_500","kat_bloodIV_AB_N_500","kat_bloodIV_B_N_500","FirstAidKit","kat_AED","kat_chestSeal","kat_larynx","ACE_fieldDressing","Medikit","ACE_morphine","kat_guedel","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","kat_Pulseoximeter","ACE_quikclot","ACE_salineIV_250","ACE_salineIV","ACE_salineIV_500","ACE_splint","kat_stethoscope","ACE_surgicalKit","ACE_tourniquet","Attachable_Helistretcher","kat_CarbonateItem","kat_PainkillerItem","kat_PervitinItem","kat_CaffeineItem","kat_IV_16","kat_IO_FAST","kat_naloxone","kat_EACA","kat_TXA","kat_norepinephrine","kat_phenylephrine","kat_nitroglycerin","kat_amiodarone","kat_lidocaine","kat_atropine","kat_ketamine","kat_fentanyl","kat_nalbuphine","kat_lorazepam","kat_flumazenil","kat_etomidate","kat_scalpel","kat_retractor","kat_clamp","kat_plate","kat_vacuum","kat_BVM","kat_pocketBVM","kat_oxygenTank_150_Item","kat_oxygenTank_300_Item","kat_oxygenTank_150_Empty","kat_oxygenTank_300_Empty","kat_Bubble_Wrap_Item","kat_IFAK","kat_MFAK","kat_AFAK"],
        localize "STR_ACE_Medical_GUI_Medical",
        "\z\ace\addons\medical_gui\data\categories\triage_card.paa"
    ] call ACEFUNC(arsenal,addRightPanelButton);
};

ADDON = true;
