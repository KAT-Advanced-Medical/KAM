
// Basic Settings Category
[
    QGVAR(RequireInsIV),
    "CHECKBOX",
    [LLSTRING(SETTING_REQUIRE_INS_IV),LLSTRING(SETTING_REQUIRE_INS_IV_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(MedicationsRequireInsIV),
    "CHECKBOX",
    [LLSTRING(SETTING_REQUIRE_INS_IV_Medications),LLSTRING(SETTING_REQUIRE_INS_IV_Medications_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(RequireInsIVBloodDraw),
    "CHECKBOX",
    [LLSTRING(SETTING_REQUIRE_INS_IV_BLOOD_DRAW),LLSTRING(SETTING_REQUIRE_INS_IV_BLOOD_DRAW_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(IVflowControl),
    "CHECKBOX",
    [LLSTRING(SETTING_IV_FLOW_CONTROL),LLSTRING(SETTING_IV_FLOW_CONTROL_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(IVdropEnable),
    "CHECKBOX",
    [LLSTRING(IV_DROP_ENABLE), LLSTRING(IV_DROP_ENABLE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(IVdrop),
    "SLIDER",
    [LLSTRING(IV_DROP),LLSTRING(IV_DROP_TIME_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [60, 1200, 600, 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(IVreuse),
    "CHECKBOX",
    [LLSTRING(IV_REUSE), LLSTRING(IV_REUSE_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [false],
    true
] call CBA_fnc_addSetting;

//IV Settings Category
[
    QGVAR(medLvl_ApplyIV),
    "LIST",
    [LLSTRING(medLvl_ApplyIV), LLSTRING(medLvl_ApplyIV_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ApplyIV)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_ApplyIV),
    "SLIDER",
    [LLSTRING(treatmentTime_ApplyIV), LLSTRING(treatmentTime_ApplyIV_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ApplyIV)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(ivCheckLimbDamage),
    "CHECKBOX",
    [LLSTRING(SETTING_ivCheckLimbDamage), LLSTRING(SETTING_ivCheckLimbDamage_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ApplyIV)],
    [false],
    true
] call CBA_fnc_addSetting;

// IO Settings Category
[
    QGVAR(medLvl_ApplyIO),
    "LIST",
    [LLSTRING(medLvl_ApplyIO), LLSTRING(medLvl_ApplyIO_Desc)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ApplyIO)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_ApplyIO),
    "SLIDER",
    [LLSTRING(treatmentTime_ApplyIO), LLSTRING(treatmentTime_ApplyIO_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_ApplyIO)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

// Reorientation Settings Category
[
    QGVAR(Reorientation_Enable),
    "CHECKBOX",
    [LLSTRING(SETTING_Reorientation_Enable), LLSTRING(SETTING_Reorientation_Enable_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Reorientation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(medLvl_Reorientation),
    "LIST",
    [LLSTRING(SETTING_Allow_Reorientation),LLSTRING(SETTING_Allow_Reorientation_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Reorientation)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Reorientation),
    "SLIDER",
    [LLSTRING(treatmentTime_Reorientation)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Reorientation)],
    [0.1, 10, 2, 1],
    true
] call CBA_fnc_addSetting;


[
    QGVAR(Reorientation_Slap),
    "CHECKBOX",
    [LLSTRING(SETTING_Reorientation_Slap), LLSTRING(SETTING_Reorientation_Slap_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Reorientation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(reorientationChance),
    "SLIDER",
    [LLSTRING(SETTING_reorientationChance), LLSTRING(SETTING_reorientationChance_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Reorientation)],
    [0, 100, 50, 0],
    true
] call CBA_fnc_addSetting;

// Carbonate Settings Category
[
    QGVAR(medLvl_Carbonate),
    "LIST",
    [LLSTRING(medLvl_Carbonate)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Carbonate)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Carbonate),
    "SLIDER",
    [LLSTRING(treatmentTime_Carbonate)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Carbonate)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(carbonateChance),
    "SLIDER",
    [LLSTRING(SETTING_carbonateChance), LLSTRING(SETTING_carbonateChance_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Carbonate)],
    [0, 100, 100, 0],
    true
] call CBA_fnc_addSetting;

//Lorazepam Settings Category
[
    QGVAR(medLvl_Lorazepam),
    "LIST",
    [LLSTRING(medLvl_Lorazepam)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Lorazepam)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Lorazepam),
    "SLIDER",
    [LLSTRING(treatmentTime_Lorazepam)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Lorazepam)],
    [0.1, 10, 2, 1],
    true
] call CBA_fnc_addSetting;

//Etomidate Settings Category
[
    QGVAR(medLvl_Etomidate),
    "LIST",
    [LLSTRING(medLvl_Etomidate)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Etomidate)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Etomidate),
    "SLIDER",
    [LLSTRING(treatmentTime_Etomidate)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Etomidate)],
    [0.1, 10, 2, 1],
    true
] call CBA_fnc_addSetting;

//FLumazenil Settings Category
[
    QGVAR(medLvl_Flumezenil),
    "LIST",
    [LLSTRING(medLvl_Flumazenil)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Flumazenil)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Flumazenil),
    "SLIDER",
    [LLSTRING(treatmentTime_Flumazenil)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Flumazenil)],
    [0.1, 10, 2, 1],
    true
] call CBA_fnc_addSetting;

// Naloxone Settings Category
[
    QGVAR(medLvl_Naloxone),
    "LIST",
    [LLSTRING(medLvl_Naloxone)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Naloxone)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Naloxone),
    "SLIDER",
    [LLSTRING(treatmentTime_Naloxone)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Naloxone)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

// Pervitin Settings Category

[
    QGVAR(medLvl_Pervitin),
    "LIST",
    [LLSTRING(medLvl_Pervitin)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Pervitin)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Pervitin),
    "SLIDER",
    [LLSTRING(treatmentTime_Pervitin)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Pervitin)],
    [0.1, 10, 5, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(weapon_sway_pervitin),
    "CHECKBOX",
    [LLSTRING(SETTING_Weapon_Sway_Pervitin), LLSTRING(SETTING_Weapon_Sway_Pervitin_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Pervitin)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(pervitinSpeed),
    "SLIDER",
    [LLSTRING(SETTING_PervitinSpeed_displayName), LLSTRING(SETTING_PervitinSpeed_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Pervitin)],
    [1, 1.5, 1.15, 2],
    true
] call CBA_fnc_addSetting;


// TXA Settings Category
[
    QGVAR(allowStackScript_TXA),
    "CHECKBOX",
    [LLSTRING(SETTING_allowStackScript_TXA), LLSTRING(SETTING_allowStackScript_TXA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_TXA)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(keepScriptRunning_TXA),
    "CHECKBOX",
    [LLSTRING(SETTING_keepScriptRunning_TXA), LLSTRING(SETTING_keepScriptRunning_TXA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_TXA)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(medLvl_TXA),
    "LIST",
    [LLSTRING(medLvl_TXA)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_TXA)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_TXA),
    "SLIDER",
    [LLSTRING(treatmentTime_TXA)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_TXA)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(bandageCycleTime_TXA),
    "TIME",
    [LLSTRING(SETTING_bandageCycleTime_TXA), LLSTRING(SETTING_bandageCycleTime_TXA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_TXA)],
    [1, 180, 5],
    true
] call CBA_fnc_addSetting;

// EpinephrineIV Settings Category
[
    QGVAR(medLvl_EpinephrineIV),
    "LIST",
    [LLSTRING(medLvl_EpinephrineIV)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EpinephrineIV)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_EpinephrineIV),
    "SLIDER",
    [LLSTRING(treatmentTime_EpinephrineIV)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EpinephrineIV)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

// Norepinephrine Settings Category
[
    QGVAR(medLvl_Norepinephrine),
    "LIST",
    [LLSTRING(medLvl_Norepinephrine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Norepinephrine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Norepinephrine),
    "SLIDER",
    [LLSTRING(treatmentTime_Norepinephrine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Norepinephrine)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

// Phenylephrine Settings Category
[
    QGVAR(medLvl_Phenylephrine),
    "LIST",
    [LLSTRING(medLvl_Phenylephrine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Phenylephrine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Phenylephrine),
    "SLIDER",
    [LLSTRING(treatmentTime_Phenylephrine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Phenylephrine)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

// Nitroglycerin Settings Category
[
    QGVAR(medLvl_Nitroglycerin),
    "LIST",
    [LLSTRING(medLvl_Nitroglycerin)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Nitroglycerin)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Nitroglycerin),
    "SLIDER",
    [LLSTRING(treatmentTime_Nitroglycerin)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Nitroglycerin)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

// Amiodarone Settings Category
[
    QGVAR(medLvl_Amiodarone),
    "LIST",
    [LLSTRING(medLvl_Amiodarone)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Amiodarone)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Amiodarone),
    "SLIDER",
    [LLSTRING(treatmentTime_Amiodarone)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Amiodarone)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

// Lidocaine Settings Category
[
    QGVAR(medLvl_Lidocaine),
    "LIST",
    [LLSTRING(medLvl_Lidocaine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Lidocaine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Lidocaine),
    "SLIDER",
    [LLSTRING(treatmentTime_Lidocaine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Lidocaine)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

// Atropine Settings Category
[
    QGVAR(medLvl_Atropine),
    "LIST",
    [LLSTRING(medLvl_Atropine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Atropine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Atropine),
    "SLIDER",
    [LLSTRING(treatmentTime_Atropine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Atropine)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

// EACA Settings Category

[
    QGVAR(allowStackScript_EACA),
    "CHECKBOX",
    [LLSTRING(SETTING_allowStackScript_EACA), LLSTRING(SETTING_allowStackScript_EACA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(keepScriptRunning_EACA),
    "CHECKBOX",
    [LLSTRING(SETTING_keepScriptRunning_EACA), LLSTRING(SETTING_keepScriptRunning_EACA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(medLvl_EACA),
    "LIST",
    [LLSTRING(medLvl_EACA)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_EACA),
    "SLIDER",
    [LLSTRING(treatmentTime_EACA)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(eacaClearTrauma),
    "CHECKBOX",
    [LLSTRING(SETTING_EACA_Trauma), LLSTRING(SETTING_EACA_Trauma_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [false],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(bandageCycleTime_EACA),
    "TIME",
    [LLSTRING(SETTING_bandageCycleTime_EACA), LLSTRING(SETTING_bandageCycleTime_EACA_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_EACA)],
    [1, 180, 8],
    true
] call CBA_fnc_addSetting;

//Ketamine Settings Category
[
    QGVAR(medLvl_Ketamine),
    "LIST",
    [LLSTRING(medLvl_Ketamine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Ketamine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Ketamine),
    "SLIDER",
    [LLSTRING(treatmentTime_Ketamine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Ketamine)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

//Fentanyl Settings Category
[
    QGVAR(medLvl_Fentanyl),
    "LIST",
    [LLSTRING(medLvl_Fentanyl)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fentanyl)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Fentanyl),
    "SLIDER",
    [LLSTRING(treatmentTime_Fentanyl)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fentanyl)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

//Nalbuphine Settings Category
[
    QGVAR(medLvl_Nalbuphine),
    "LIST",
    [LLSTRING(medLvl_Nalbuphine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Nalbuphine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Nalbuphine),
    "SLIDER",
    [LLSTRING(treatmentTime_Nalbuphine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Nalbuphine)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

// Penthrox Settings Category
[
    QGVAR(medLvl_Penthrox),
    "LIST",
    [LLSTRING(SETTING_medLvl_Penthrox)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Penthrox)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Penthrox),
    "SLIDER",
    [LLSTRING(SETTING_treatmentTime_Penthrox)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Penthrox)],
    [0.1, 10, 8, 1],
    true
] call CBA_fnc_addSetting;

// Kidney Settings
[
    QGVAR(kidneyAction),
    "CHECKBOX",
    [LLSTRING(SETTING_Kidney_Action), LLSTRING(SETTING_Kidney_Action_DESC)],
    [CBA_SETTINGS_CAT],
    [false],
    true
] call CBA_fnc_addSetting;

// IV Block Chance Settings
[
    QGVAR(blockChance),
    "SLIDER",
    [LLSTRING(SETTING_Block_Chance), LLSTRING(SETTING_Block_Chance_DESC)],
    CBA_SETTINGS_CAT,
    [0, 100, 20, 0],
    true
] call CBA_fnc_addSetting;

// Coagulation Settings
[
    QGVAR(coagulation),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation), LLSTRING(SETTING_Coagulation_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_on_all_Bodyparts),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_on_all_Bodyparts), LLSTRING(SETTING_Coagulation_on_all_Bodyparts_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_tourniquetBlock),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_tourniquetBlock), LLSTRING(SETTING_Coagulation_tourniquetBlock_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_allow_clot_text),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_clot_text), LLSTRING(SETTING_Coagulation_allow_clot_text_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_allow_TXA_script),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_TXA_script), LLSTRING(SETTING_Coagulation_allow_TXA_script_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_allow_EACA_script),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_EACA_script), LLSTRING(SETTING_Coagulation_allow_EACA_script_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_allowOnAI),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allowOnAI), LLSTRING(SETTING_Coagulation_allowOnAI_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [false],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_allow_MinorWounds),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_MinorWounds), LLSTRING(SETTING_Coagulation_allow_MinorWounds_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_allow_MediumWounds),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_MediumWounds), LLSTRING(SETTING_Coagulation_allow_MediumWounds_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_allow_LargeWounds),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_allow_LargeWounds), LLSTRING(SETTING_Coagulation_allow_LargeWounds_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_requireHR),
    "CHECKBOX",
    [LLSTRING(SETTING_Coagulation_requireHR), LLSTRING(SETTING_Coagulation_requireHR_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_requireBV),
    "SLIDER",
    [LLSTRING(SETTING_Coagulation_requireBV), LLSTRING(SETTING_Coagulation_requireBV_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [0, 6.0, 3.6, 1],
    true
] call CBA_fnc_addSetting;


[
    QGVAR(coagulation_factor_count),
    "SLIDER",
    [LLSTRING(SETTING_Coagulation_FactorCount), LLSTRING(SETTING_Coagulation_FactorCount_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [0, 100, 30, 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_factor_limit),
    "SLIDER",
    [LLSTRING(SETTING_coagulation_Factor_Limit), LLSTRING(SETTING_coagulation_Factor_Limit_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [1, 200, 60, 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_time),
    "TIME",
    [LLSTRING(SETTING_Coagulation_Time), LLSTRING(SETTING_Coagulation_Time_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [1, 300, 10],
    true,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_time_minor),
    "TIME",
    [LLSTRING(SETTING_Coagulation_Time_Minor), LLSTRING(SETTING_Coagulation_Time_Clotting_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [0, 300, 15],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_time_medium),
    "TIME",
    [LLSTRING(SETTING_Coagulation_Time_Medium), LLSTRING(SETTING_Coagulation_Time_Clotting_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [0, 300, 30],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_time_large),
    "TIME",
    [LLSTRING(SETTING_Coagulation_Time_Large), LLSTRING(SETTING_Coagulation_Time_Clotting_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [0, 300, 45],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(coagulation_factor_regenerate_time),
    "TIME",
    [LLSTRING(SETTING_Coagulation_Factor_Regenerate_Time), LLSTRING(SETTING_Coagulation_Factor_Regenerate_Time_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coagulation)],
    [1, 900, 150],
    true
] call CBA_fnc_addSetting;

// Stamina Settings
[
    QGVAR(staminaMedication),
    "CHECKBOX",
    [LLSTRING(SETTING_staminaMedication), LLSTRING(SETTING_staminaMedication_DESC)],
    CBA_SETTINGS_CAT,
    [false],
    true
] call CBA_fnc_addSetting;

// Coag Sense setLightnings
[
    QGVAR(CheckCoag_MedLevel),
    "LIST",
    [LLSTRING(SETTING_CheckCoag_MedLevel), LLSTRING(SETTING_CheckCoag_MedLevel_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coag_Sense)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(CheckCoag_Location),
    "LIST",
    [LLSTRING(SETTING_CheckCoag_Location), LLSTRING(SETTING_CheckCoag_Location_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coag_Sense)],
    [[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(CheckCoag_TreatmentTime),
    "TIME",
    [LLSTRING(SETTING_CheckCoag_treatmentTime), LLSTRING(SETTING_CheckCoag_treatmentTime_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Coag_Sense)],
    [1, 30, 10],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(medLvl_Caffeine),
    "LIST",
    [LLSTRING(medLvl_Caffeine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Caffeine)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_Caffeine),
    "SLIDER",
    [LLSTRING(treatmentTime_Caffeine)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Caffeine)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(medLvl_CWMP),
    "LIST",
    [LLSTRING(medLvl_CWMP)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CWMP)],
    [[0, 1, 2], [ACELSTRING(medical_treatment,Anyone), ACELSTRING(medical_treatment,Medics), ACELSTRING(medical_treatment,Doctors)], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTime_CWMP),
    "SLIDER",
    [LLSTRING(treatmentTime_CWMP)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_CWMP)],
    [0.1, 10, 7, 1],
    true
] call CBA_fnc_addSetting;
