#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Pharmacy"

// Basic Settings Category
[
    QGVAR(RequireInsIV),
    "CHECKBOX",
    [LLSTRING(SETTING_REQUIRE_INS_IV),LLSTRING(SETTING_REQUIRE_INS_IV_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(MedicationsRequireInsIV),
    "CHECKBOX",
    [LLSTRING(SETTING_REQUIRE_INS_IV_Medications),LLSTRING(SETTING_REQUIRE_INS_IV_Medications_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(RequireInsIVBloodDraw),
    "CHECKBOX",
    [LLSTRING(SETTING_REQUIRE_INS_IV_BLOOD_DRAW),LLSTRING(SETTING_REQUIRE_INS_IV_BLOOD_DRAW_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVdropEnable),
    "CHECKBOX",
    [LLSTRING(IV_DROP_ENABLE)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVdrop),
    "SLIDER",
    [LLSTRING(IV_DROP),LLSTRING(IV_DROP_TIME_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [60, 1200, 600, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(IVreuse),
    "CHECKBOX",
    [LLSTRING(IV_REUSE)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_Settings_fnc_init;

//IV Settings Category
[
    QGVAR(medLvl_ApplyIV),
    "LIST",
    [LLSTRING(medLvl_ApplyIV), LLSTRING(medLvl_ApplyIV_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ApplyIV)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_ApplyIV),
    "SLIDER",
    [LLSTRING(treatmentTime_ApplyIV)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ApplyIV)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(ivCheckLimbDamage),
    "CHECKBOX",
    [LLSTRING(SETTING_ivCheckLimbDamage), LLSTRING(SETTING_ivCheckLimbDamage_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ApplyIV)],
    [false],
    true
] call CBA_Settings_fnc_init;

// IO Settings Category
[
    QGVAR(medLvl_ApplyIO),
    "LIST",
    [LLSTRING(medLvl_ApplyIO), LLSTRING(medLvl_ApplyIO_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ApplyIO)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_ApplyIO),
    "SLIDER",
    [LLSTRING(treatmentTime_ApplyIO)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ApplyIO)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

// Reorientation Settings Category
[
    QGVAR(Reorientation_Enable),
    "CHECKBOX",
    [LLSTRING(SETTING_Reorientation_Enable), LLSTRING(SETTING_Reorientation_Enable_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Reorientation)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(medLvl_Reorientation),
    "LIST",
    [LLSTRING(SETTING_Allow_Reorientation),LLSTRING(SETTING_Allow_Reorientation_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Reorientation)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(treatmentTime_Reorientation),
    "SLIDER",
    [LLSTRING(treatmentTime_Reorientation)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Reorientation)],
    [0.1, 10, 2, 1],
    true
] call CBA_Settings_fnc_init;


[
    QGVAR(Reorientation_Slap),
    "CHECKBOX",
    [LLSTRING(SETTING_Reorientation_Slap), LLSTRING(SETTING_Reorientation_Slap_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Reorientation)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reorientationChance),
    "SLIDER",
    LLSTRING(SETTING_reorientationChance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Reorientation)],
    [0, 100, 50, 0],
    true
] call CBA_Settings_fnc_init;

// Carbonate Settings Category
[
    QGVAR(medLvl_Carbonate),
    "LIST",
    [LLSTRING(medLvl_Carbonate)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Carbonate)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Carbonate),
    "SLIDER",
    [LLSTRING(treatmentTime_Carbonate)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Carbonate)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(carbonateChance),
    "SLIDER",
    LLSTRING(SETTING_carbonateChance),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Carbonate)],
    [0, 100, 100, 0],
    true
] call CBA_Settings_fnc_init;

//Lorazepam Settings Category
[
    QGVAR(medLvl_Lorazepam),
    "LIST",
    [LLSTRING(medLvl_Lorazepam)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Lorazepam)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Lorazepam),
    "SLIDER",
    [LLSTRING(treatmentTime_Lorazepam)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Lorazepam)],
    [0.1, 10, 2, 1],
    true
] call CBA_Settings_fnc_init;

//Etomidate Settings Category
[
    QGVAR(medLvl_Etomidate),
    "LIST",
    [LLSTRING(medLvl_Etomidate)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Etomidate)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Etomidate),
    "SLIDER",
    [LLSTRING(treatmentTime_Etomidate)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Etomidate)],
    [0.1, 10, 2, 1],
    true
] call CBA_Settings_fnc_init;

//FLumazenil Settings Category
[
    QGVAR(medLvl_Flumezenil),
    "LIST",
    [LLSTRING(medLvl_Flumazenil)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Flumazenil)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Flumazenil),
    "SLIDER",
    [LLSTRING(treatmentTime_Flumazenil)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Flumazenil)],
    [0.1, 10, 2, 1],
    true
] call CBA_Settings_fnc_init;

// Naloxone Settings Category
[
    QGVAR(medLvl_Naloxone),
    "LIST",
    [LLSTRING(medLvl_Naloxone)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Naloxone)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Naloxone),
    "SLIDER",
    [LLSTRING(treatmentTime_Naloxone)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Naloxone)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

// Pervitin Settings Category

[
    QGVAR(medLvl_Pervitin),
    "LIST",
    [LLSTRING(medLvl_Pervitin)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Pervitin)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Pervitin),
    "SLIDER",
    [LLSTRING(treatmentTime_Pervitin)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Pervitin)],
    [0.1, 10, 5, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(weapon_sway_pervitin),
    "CHECKBOX",
    [LLSTRING(SETTING_Weapon_Sway_Pervitin), LLSTRING(SETTING_Weapon_Sway_Pervitin_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Pervitin)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(chromatic_aberration_checkbox_pervitin),
    "CHECKBOX",
    [LLSTRING(SETTING_Chromatic_Aberration_Checkbox_Pervitin), LLSTRING(SETTING_Chromatic_Aberration_Checkbox_Pervitin_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Pervitin)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(chromatic_aberration_slider_pervitin),
    "SLIDER",
    [LLSTRING(SETTING_Chromatic_Aberration_Slider_Pervitin), LLSTRING(SETTING_Chromatic_Aberration_Slider_Pervitin_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Pervitin)],
    [0.1, 10, 1, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(pervitinSpeed),
    "SLIDER",
    [LLSTRING(SETTING_PervitinSpeed_displayName), LLSTRING(SETTING_PervitinSpeed_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Pervitin)],
    [1, 1.5, 1.15, 2],
    true
] call CBA_Settings_fnc_init;


// TXA Settings Category
[
    QGVAR(allowStackScript_TXA),
    "CHECKBOX",
    [LLSTRING(SETTING_allowStackScript_TXA), LLSTRING(SETTING_allowStackScript_TXA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_TXA)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(keepScriptRunning_TXA),
    "CHECKBOX",
    [LLSTRING(SETTING_keepScriptRunning_TXA), LLSTRING(SETTING_keepScriptRunning_TXA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_TXA)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(medLvl_TXA),
    "LIST",
    [LLSTRING(medLvl_TXA)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_TXA)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_TXA),
    "SLIDER",
    [LLSTRING(treatmentTime_TXA)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_TXA)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(bandageCycleTime_TXA),
    "TIME",
    [LLSTRING(SETTING_bandageCycleTime_TXA), LLSTRING(SETTING_bandageCycleTime_TXA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_TXA)],
    [1, 180, 5],
    true
] call CBA_Settings_fnc_init;

// Norepinephrine Settings Category
[
    QGVAR(medLvl_Norepinephrine),
    "LIST",
    [LLSTRING(medLvl_Norepinephrine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Norepinephrine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Norepinephrine),
    "SLIDER",
    [LLSTRING(treatmentTime_Norepinephrine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Norepinephrine)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

// Phenylephrine Settings Category
[
    QGVAR(medLvl_Phenylephrine),
    "LIST",
    [LLSTRING(medLvl_Phenylephrine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Phenylephrine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Phenylephrine),
    "SLIDER",
    [LLSTRING(treatmentTime_Phenylephrine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Phenylephrine)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

// Nitroglycerin Settings Category
[
    QGVAR(medLvl_Nitroglycerin),
    "LIST",
    [LLSTRING(medLvl_Nitroglycerin)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Nitroglycerin)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Nitroglycerin),
    "SLIDER",
    [LLSTRING(treatmentTime_Nitroglycerin)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Nitroglycerin)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

// Amiodarone Settings Category
[
    QGVAR(medLvl_Amiodarone),
    "LIST",
    [LLSTRING(medLvl_Amiodarone)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Amiodarone)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Amiodarone),
    "SLIDER",
    [LLSTRING(treatmentTime_Amiodarone)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Amiodarone)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

// Lidocaine Settings Category
[
    QGVAR(medLvl_Lidocaine),
    "LIST",
    [LLSTRING(medLvl_Lidocaine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Lidocaine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Lidocaine),
    "SLIDER",
    [LLSTRING(treatmentTime_Lidocaine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Lidocaine)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

// Atropine Settings Category
[
    QGVAR(medLvl_Atropine),
    "LIST",
    [LLSTRING(medLvl_Atropine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Atropine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Atropine),
    "SLIDER",
    [LLSTRING(treatmentTime_Atropine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Atropine)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

// EACA Settings Category

[
    QGVAR(allowStackScript_EACA),
    "CHECKBOX",
    [LLSTRING(SETTING_allowStackScript_EACA), LLSTRING(SETTING_allowStackScript_EACA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(keepScriptRunning_EACA),
    "CHECKBOX",
    [LLSTRING(SETTING_keepScriptRunning_EACA), LLSTRING(SETTING_keepScriptRunning_EACA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(medLvl_EACA),
    "LIST",
    [LLSTRING(medLvl_EACA)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_EACA),
    "SLIDER",
    [LLSTRING(treatmentTime_EACA)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(bandageCycleTime_EACA),
    "TIME",
    [LLSTRING(SETTING_bandageCycleTime_EACA), LLSTRING(SETTING_bandageCycleTime_EACA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [1, 180, 8],
    true
] call CBA_Settings_fnc_init;

//Ketamine Settings Category
[
    QGVAR(medLvl_Ketamine),
    "LIST",
    [LLSTRING(medLvl_Ketamine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Ketamine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Ketamine),
    "SLIDER",
    [LLSTRING(treatmentTime_Ketamine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Ketamine)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(chromatic_aberration_checkbox_ketamine),
    "CHECKBOX",
    [LLSTRING(SETTING_Chromatic_Aberration_Checkbox_Ketamine), LLSTRING(SETTING_Chromatic_Aberration_Checkbox_Ketamine_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Ketamine)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(chromatic_aberration_slider_ketamine),
    "SLIDER",
    [LLSTRING(SETTING_Chromatic_Aberration_Slider_Ketamine), LLSTRING(SETTING_Chromatic_Aberration_Slider_Ketamine_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Ketamine)],
    [0.1, 10, 0.8, 1],
    true
] call CBA_Settings_fnc_init;

//Fentanyl Settings Category
[
    QGVAR(medLvl_Fentanyl),
    "LIST",
    [LLSTRING(medLvl_Fentanyl)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fentanyl)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Fentanyl),
    "SLIDER",
    [LLSTRING(treatmentTime_Fentanyl)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fentanyl)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(chromatic_aberration_checkbox_fentanyl),
    "CHECKBOX",
    [LLSTRING(SETTING_Chromatic_Aberration_Checkbox_Fentanyl), LLSTRING(SETTING_Chromatic_Aberration_Checkbox_Fentanyl_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fentanyl)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(chromatic_aberration_slider_fentanyl),
    "SLIDER",
    [LLSTRING(SETTING_Chromatic_Aberration_Slider_Fentanyl), LLSTRING(SETTING_Chromatic_Aberration_Slider_Fentanyl_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fentanyl)],
    [0.1, 10, 1, 1],
    true
] call CBA_Settings_fnc_init;

//Nalbuphine Settings Category
[
    QGVAR(medLvl_Nalbuphine),
    "LIST",
    [LLSTRING(medLvl_Nalbuphine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Nalbuphine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Nalbuphine),
    "SLIDER",
    [LLSTRING(treatmentTime_Nalbuphine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Nalbuphine)],
    [0.1, 10, 7, 1],
    true
] call CBA_Settings_fnc_init;

// Penthrox Settings Category
[
    QGVAR(medLvl_Penthrox),
    "LIST",
    [LLSTRING(SETTING_medLvl_Penthrox)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Penthrox)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(treatmentTime_Penthrox),
    "SLIDER",
    [LLSTRING(SETTING_treatmentTime_Penthrox)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Penthrox)],
    [0.1, 10, 8, 1],
    true
] call CBA_Settings_fnc_init;

// Kidney Settings
[
    QGVAR(kidneyAction),
    "CHECKBOX",
    [LLSTRING(SETTING_Kidney_Action), LLSTRING(SETTING_Kidney_Action_DESC)],
    [CBA_SETTINGS_CAT],
    [false],
    true
] call CBA_Settings_fnc_init;

// IV Block Chance Settings
[
    QGVAR(blockChance),
    "SLIDER",
    [LLSTRING(SETTING_Block_Chance), LLSTRING(SETTING_Block_Chance_DESC)],
    CBA_SETTINGS_CAT,
    [0, 100, 20, 0],
    true
] call CBA_Settings_fnc_init;

// Coagulation Settings
[
    QGVAR(coagulation),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation), LLSTRING(SETTING_Coagulation_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_on_all_Bodyparts),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_on_all_Bodyparts), LLSTRING(SETTING_Coagulation_on_all_Bodyparts_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_tourniquetBlock),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_tourniquetBlock), LLSTRING(SETTING_Coagulation_tourniquetBlock_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_allow_clott_text),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_clott_text), LLSTRING(SETTING_Coagulation_allow_clott_text_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_allow_TXA_script),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_TXA_script), LLSTRING(SETTING_Coagulation_allow_TXA_script_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_allow_EACA_script),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_EACA_script), LLSTRING(SETTING_Coagulation_allow_EACA_script_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_allowOnAI),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allowOnAI), LLSTRING(SETTING_Coagulation_allowOnAI_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [false],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_allow_MinorWounds),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_MinorWounds), LLSTRING(SETTING_Coagulation_allow_MinorWounds_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_allow_MediumWounds),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_MediumWounds), LLSTRING(SETTING_Coagulation_allow_MediumWounds_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_allow_LargeWounds),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_LargeWounds), LLSTRING(SETTING_Coagulation_allow_LargeWounds_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_requireHR),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_requireHR), LLSTRING(SETTING_Coagulation_requireHR_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_requireBV),
    "SLIDER",
    [LLSTRING(SETTING_Coagulation_requireBV), LLSTRING(SETTING_Coagulation_requireBV_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [0, 6.0, 3.6, 1],
    true
] call CBA_Settings_fnc_init;


[
    QGVAR(coagulation_factor_count),
    "SLIDER",
    [LLSTRING(SETTING_Coagulation_FactorCount), LLSTRING(SETTING_Coagulation_FactorCount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [0, 100, 15, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_factor_limit),
    "SLIDER",
    [LLSTRING(SETTING_coagulation_Factor_Limit), LLSTRING(SETTING_coagulation_Factor_Limit_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [1, 200, 30, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_time),
    "TIME",
    [LLSTRING(SETTING_Coagulation_Time), LLSTRING(SETTING_Coagulation_Time_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [1, 300, 10],
    true,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_time_minor),
    "TIME",
    [LLSTRING(SETTING_Coagulation_Time_Minor), LLSTRING(SETTING_Coagulation_Time_Clotting_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [0, 300, 15],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_time_medium),
    "TIME",
    [LLSTRING(SETTING_Coagulation_Time_Medium), LLSTRING(SETTING_Coagulation_Time_Clotting_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [0, 300, 30],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_time_large),
    "TIME",
    [LLSTRING(SETTING_Coagulation_Time_Large), LLSTRING(SETTING_Coagulation_Time_Clotting_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [0, 300, 45],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(coagulation_factor_regenerate_time),
    "TIME",
    [LLSTRING(SETTING_Coagulation_Factor_Regenerate_Time), LLSTRING(SETTING_Coagulation_Factor_Regenerate_Time_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [1, 900, 150],
    true
] call CBA_Settings_fnc_init;

// Stamina Settings
[
    QGVAR(staminaMedication),
    "CHECKBOX",
    [LLSTRING(SETTING_staminaMedication), LLSTRING(SETTING_staminaMedication_DESC)],
    CBA_SETTINGS_CAT,
    [false],
    true
] call CBA_Settings_fnc_init;

// Coag Sense setLightnings
[
    QGVAR(CheckCoag_MedLevel),
    "LIST",
    LLSTRING(SETTING_CheckCoag_MedLevel),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coag_Sense)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(CheckCoag_Location),
    "LIST",
    LLSTRING(SETTING_CheckCoag_Location),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coag_Sense)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(CheckCoag_TreatmentTime),
    "TIME",
    LLSTRING(SETTING_CheckCoag_treatmentTime),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coag_Sense)],
    [1, 30, 10],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
