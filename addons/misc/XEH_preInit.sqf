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

if (GVAR(arsenalMedCategory)) then {
    [
        ["kat_aatKit","kat_ncdKit","kat_accuvac","ACE_adenosine","ACE_epinephrine","kat_X_AED","ACE_elasticBandage","ACE_packingBandage","kat_crossPanel","kat_bloodIV_O","kat_bloodIV_A","kat_bloodIV_AB","ACE_bloodIV","kat_bloodIV_B","ACE_bloodIV_250","kat_bloodIV_O_250","kat_bloodIV_A_250","kat_bloodIV_AB_250","kat_bloodIV_B_250","ACE_bloodIV_500","kat_bloodIV_O_500","kat_bloodIV_A_500","kat_bloodIV_AB_500","kat_bloodIV_B_500","ACE_bodyBag","KAT_Empty_bloodIV_250","KAT_Empty_bloodIV_500","kat_bloodIV_O_N","kat_bloodIV_A_N","kat_bloodIV_AB_N","kat_bloodIV_B_N","kat_bloodIV_O_N_250","kat_bloodIV_A_N_250","kat_bloodIV_AB_N_250","kat_bloodIV_B_N_250","kat_bloodIV_O_N_500","kat_bloodIV_A_N_500","kat_bloodIV_AB_N_500","kat_bloodIV_B_N_500","FirstAidKit","kat_AED","kat_chestSeal","kat_larynx","ACE_fieldDressing","Medikit","ACE_morphine","kat_guedel","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","kat_Pulseoximeter","ACE_quikclot","ACE_salineIV_250","ACE_salineIV","ACE_salineIV_500","ACE_splint","kat_stethoscope","ACE_surgicalKit","ACE_tourniquet","Attachable_Helistretcher","kat_CarbonateItem","kat_PainkillerItem","kat_PervitinItem","kat_CaffeineItem","kat_IV_16","kat_IO_FAST","kat_naloxone","kat_EACA","kat_TXA","kat_norepinephrine","kat_phenylephrine","kat_nitroglycerin","kat_amiodarone","kat_lidocaine","kat_atropine","kat_ketamine","kat_fentanyl","kat_nalbuphine","kat_lorazepam","kat_flumazenil","kat_etomidate","kat_scalpel","kat_retractor","kat_clamp","kat_plate","kat_vacuum","kat_BVM","kat_pocketBVM","kat_oxygenTank_150_Item","kat_oxygenTank_300_Item","kat_oxygenTank_150_Empty","kat_oxygenTank_300_Empty"],
        localize "STR_ACE_Medical_GUI_Medical",
        "\z\ace\addons\medical_gui\data\categories\triage_card.paa"
    ] call ACEFUNC(arsenal,addRightPanelButton);
};

ADDON = true;
