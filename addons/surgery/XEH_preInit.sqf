#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Surgery"

[
    QGVAR(enable_fracture),
    "CHECKBOX",
    LLSTRING(ADVANCED_FRACTURE),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fractures)],
    [true],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(simpleChance),
    "SLIDER",
    [LLSTRING(SIMPLE_FRACTURE_CHANCE),LLSTRING(SIMPLE_FRACTURE_CHANCE_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fractures)],
    [0,100,60,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(closedReductionFailChance),
    "SLIDER",
    [LLSTRING(CLOSED_REDUCTION_FAIL),LLSTRING(CLOSED_REDUCTION_FAIL_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fractures)],
    [0,100,10,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(compoundChance),
    "SLIDER",
    [LLSTRING(COMPOUND_FRACTURE_CHANCE) ,LLSTRING(COMPOUND_FRACTURE_CHANCE_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fractures)],
    [0,100,30,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(fractureCheck_MedLevel),
    "LIST",
    LLSTRING(FRACTURE_CHECK_MEDLEVEL),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fractures)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enable_selfCheckFracture),
    "LIST",
    [LLSTRING(SETTING_SELF_CHECKFRACTURE)],
     [CBA_SETTINGS_CAT, LSTRING(SubCategory_Fractures)],
    [[0, 1], ["STR_ACE_common_No", "STR_ACE_common_Yes"], 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(etomidateTime),
    "SLIDER",
    [LLSTRING(ETOMIDATE_TIMER), LLSTRING(ETOMIDATE_TIMER_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [0,100,45,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(closedTime),
    "SLIDER",
    LLSTRING(CLOSED_TIMER),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [0,100,10,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(incisionTime),
    "SLIDER",
    LLSTRING(INCISION_TIMER),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [0,100,10,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(intermediateTime),
    "SLIDER",
    [LLSTRING(INTERMEDIATE_TIMER), LLSTRING(INTERMEDIATE_TIMER_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [0,100,8,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(openTime),
    "SLIDER",
    LLSTRING(OPEN_TIMER),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [0,100,15,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(fractureCheck_Time),
    "SLIDER",
    LLSTRING(FRACTURE_CHECK_TIMER),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [0,100,10,0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(closedReduction_MedLevel),
    "LIST",
    LLSTRING(CLOSED_REDUCTION_MEDLEVEL),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 2],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(surgicalAction_MedLevel),
    "LIST",
    LLSTRING(SURGICAL_ACTION_MEDLEVEL),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 2],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(closedLocation),
    "LIST",
    LLSTRING(CLOSED_LOCATION),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(surgicalLocation),
    "LIST",
    LLSTRING(SURGICAL_LOCATION),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],3],
    true
] call CBA_Settings_fnc_init;

// 0 Surgery Causes Unconsciousness: If you do an incision (without anesthesia & sedative) patient will go into CA
// 1 Unconsciousness Required for Surgery: Surgery fails unless patient is unconscious, needs anesthesia
// 2 No Unconsciousness from Surgery: Patient can stay awake without anesthesia, causes pain
// 3 Surgery Anesthesia: The patient is able to stay awake through the entirety of the surgery. If Etomidate has not been applied, then the patient will go into CA.
[
    QGVAR(Surgery_ConsciousnessRequirement),
    "LIST",
    [LLSTRING(SETTING_ConsciousnessRequirement), LLSTRING(SETTING_ConsciousnessRequirement_DESC)],
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_SurgicalActions)],
    [[0, 1, 2, 3], [LLSTRING(SETTING_Causes_Unconsciousness), LLSTRING(SETTING_Unconsciousness_Required), LLSTRING(SETTING_No_Unconsciousness), LLSTRING(SETTING_Anesthesia)], 1],
    true
] call CBA_Settings_fnc_init;

// Sets time to apply NPWT dressing
[
    QGVAR(npwtTime),
    "SLIDER",
    LLSTRING(SETTING_NPWTTime),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_NPWT)],
    [0.1, 60, 5, 1],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(npwtLocation),
    "LIST",
    LLSTRING(NPWT_LOCATION),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_NPWT)],
    [[0,1,2,3],["STR_ACE_Common_Anywhere", "STR_ACE_Common_Vehicle", "STR_ACE_Medical_Treatment_MedicalFacilities", "STR_ACE_Medical_Treatment_VehiclesAndFacilities"],3],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(npwtMedLevel),
    "LIST",
    LLSTRING(NPWT_ACTION_MEDLEVEL),
    [CBA_SETTINGS_CAT, LSTRING(SubCategory_NPWT)],
    [[0, 1, 2], ["STR_ACE_Medical_Treatment_Anyone", "STR_ACE_Medical_Treatment_Medics", "STR_ACE_Medical_Treatment_Doctors"], 2],
    true
] call CBA_Settings_fnc_init;

ADDON = true;
