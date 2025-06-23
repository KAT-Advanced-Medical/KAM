
[
    QGVAR(checkLimbTime),
    "SLIDER",
    [LLSTRING(SETTING_checkLimbTime), LLSTRING(SETTING_checkLimbTime_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [4, 20, 8, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(woundWrapTime),
    "SLIDER",
    [LSTRING(WoundWrapTime_DisplayName), LSTRING(WoundWrapTime_Description)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [2, 16, 4, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTimeHastyTourniquet),
    "SLIDER",
    [LSTRING(TreatmentTimeHastyTourniquet_DisplayName), LSTRING(TreatmentTimeHastyTourniquet_Description)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0.1, 60, 7, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTimeTrainedHastyTourniquet),
    "SLIDER",
    [LSTRING(TreatmentTimeTrainedHastyTourniquet_DisplayName), LSTRING(TreatmentTimeTrainedHastyTourniquet_Description)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0.1, 60, 7, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTimeDelibrateTourniquet),
    "SLIDER",
    [LSTRING(TreatmentTimeDelibrateTourniquet_DisplayName), LSTRING(TreatmentTimeDelibrateTourniquet_Description)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0.1, 60, 7, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(treatmentTimeTrainedDelibrateTourniquet),
    "SLIDER",
    [LSTRING(TreatmentTimeTrainedDelibrateTourniquet_DisplayName), LSTRING(TreatmentTimeTrainedDelibrateTourniquet_Description)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0.1, 60, 7, 1],
    true
] call CBA_fnc_addSetting;


[
    QGVAR(ArterialChance),
    "SLIDER",
    [LLSTRING(SETTING_ArterialChance), LLSTRING(SETTING_ArterialChance_DESC)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [0, 100, 1.5, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(InternalBleedingEnable),
    "CHECKBOX",
    [LLSTRING(SETTING_InternalBleedingEnable), LLSTRING(SETTING_InternalBleedingEnable_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [true],
    true
] call CBA_fnc_addSetting;


[
    QGVAR(CatastrophicEnable),
    "CHECKBOX",
    [LLSTRING(SETTING_ENABLE),LLSTRING(SETTING_ENABLE_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(EviscerationChance),
    "SLIDER",
    LLSTRING(EviscerationChance),
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [0, 100, 5, 0],
    true
] call CBA_fnc_addSetting;


[
    QGVAR(EviscerationDamageThreshold),
    "SLIDER",
    [LLSTRING(Evisceration_DAMAGE_THRESHOLD), LLSTRING(Evisceration_DAMAGE_THRESHOLD_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [0, 3, 1.5, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(EviscerationDamageThreshold_TakenDamage),
    "CHECKBOX",
    [LLSTRING(SETTING_EviscerationDamageThreshold_DamageTaken), LLSTRING(SETTING_EviscerationDamageThreshold_DamageTaken_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(PelvicFractureChance),
    "SLIDER",
    LLSTRING(PelvicChance),
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [0, 100, 5, 0],
    true
] call CBA_fnc_addSetting;


[
    QGVAR(PelvicDamageThreshold),
    "SLIDER",
    [LLSTRING(Pelvic_DAMAGE_THRESHOLD), LLSTRING(Pelvic_DAMAGE_THRESHOLD_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [0, 6, 3, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(PelvicDamageThreshold_TakenDamage),
    "CHECKBOX",
    [LLSTRING(SETTING_PelvicDamageThreshold_DamageTaken), LLSTRING(SETTING_PelvicDamageThreshold_DamageTaken_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Catastrophic_Injuries)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(JointChance),
    "SLIDER",
    LLSTRING(JointChance),
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Joints)],
    [0, 100, 5, 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(JointDamageThreshold),
    "SLIDER",
    [LLSTRING(Joint_DAMAGE_THRESHOLD), LLSTRING(Joint_DAMAGE_THRESHOLD_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Joints)],
    [0, 3, 1.5, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(JointDamageThreshold_TakenDamage),
    "CHECKBOX",
    [LLSTRING(SETTING_JointDamageThreshold_DamageTaken), LLSTRING(SETTING_JointDamageThreshold_DamageTaken_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Joints)],
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(JointCareLevel),
    "LIST",
    LLSTRING(JOINT_CARE_MEDLEVEL),
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Joints)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(iceTime),
    "SLIDER",
    LLSTRING(ICE_TIMER),
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Joints)],
    [0,100,10,0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(wrapTime),
    "SLIDER",
    LLSTRING(WRAP_TIMER),
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Joints)],
    [0,100,10,0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(stabilizeTime),
    "SLIDER",
    LLSTRING(STABILIZE_TIMER),
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Joints)],
    [0,100,10,0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(reduceTime),
    "SLIDER",
    LLSTRING(REDUCE_TIMER),
    [CBA_SETTINGS_CAT, LSTRING(Subcatagory_Joints)],
    [0,100,10,0],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(removalTimeETD),
    "SLIDER",
    [LSTRING(removalTimeETD_DisplayName), LSTRING(removalTimeETD_Description)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [2, 16, 8, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(removalTimeIsraeli),
    "SLIDER",
    [LSTRING(removalTimeIsraeli_DisplayName), LSTRING(removalTimeIsraeli_Description)],
    [CBA_SETTINGS_CAT, ELSTRING(GUI,SubCategory_Basic)],
    [2, 16, 6, 1],
    true
] call CBA_fnc_addSetting;
