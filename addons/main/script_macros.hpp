#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"
#include "\z\ace\addons\medical_engine\script_macros_medical.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineCommonColors.inc"

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2

#define DGVAR(varName)    if(isNil "KAT_DEBUG_NAMESPACE") then { KAT_DEBUG_NAMESPACE = []; }; if(!(QUOTE(GVAR(varName)) in KAT_DEBUG_NAMESPACE)) then { PUSH(KAT_DEBUG_NAMESPACE, QUOTE(GVAR(varName))); }; GVAR(varName)
#define DVAR(varName)     if(isNil "KAT_DEBUG_NAMESPACE") then { KAT_DEBUG_NAMESPACE = []; }; if(!(QUOTE(varName) in KAT_DEBUG_NAMESPACE)) then { PUSH(KAT_DEBUG_NAMESPACE, QUOTE(varName)); }; varName
#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)
#define DEFUNC(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)

#define SIXES(var1,var2,var3,var4,var5,var6) var1##_##var2##_##var3##_##var4##_##var5##_##var6
#define KATPUSHCSTRING(var1,var2,var3) QUOTE(SIXES($STR,ADDON,Push,var1,var2,var3))
#define KATPUSHINGCSTRING(var1,var2,var3) QUOTE(SIXES($STR,ADDON,Pushing,var1,var2,var3))
#define KATDISPLAYCSTRING(var1,var2,var3) QUOTE(SIXES($STR,ADDON,SyringeDisplay,var1,var2,var3))

#undef QFUNC
#undef QEFUNC
#define QFUNC(var1) QUOTE(DFUNC(var1))
#define QEFUNC(var1,var2) QUOTE(DEFUNC(var1,var2))

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(var1),var2)]
#define SETVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(var1),var2)]
#define SETPVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(var1),var2,true)]

#undef GETVAR
#define GETVAR(var1,var2,var3) (var1 GETVAR_SYS(var2,var3))
#define GETMVAR(var1,var2) (missionNamespace GETVAR_SYS(var1,var2))
#define GETUVAR(var1,var2) (uiNamespace GETVAR_SYS(var1,var2))
#define GETPRVAR(var1,var2) (profileNamespace GETVAR_SYS(var1,var2))
#define GETPAVAR(var1,var2) (parsingNamespace GETVAR_SYS(var1,var2))

#undef SETVAR
#define SETVAR(var1,var2,var3) var1 SETVAR_SYS(var2,var3)
#define SETPVAR(var1,var2,var3) var1 SETPVAR_SYS(var2,var3)
#define SETMVAR(var1,var2) missionNamespace SETVAR_SYS(var1,var2)
#define SETUVAR(var1,var2) uiNamespace SETVAR_SYS(var1,var2)
#define SETPRVAR(var1,var2) profileNamespace SETVAR_SYS(var1,var2)
#define SETPAVAR(var1,var2) parsingNamespace SETVAR_SYS(var1,var2)

#define GETGVAR(var1,var2) GETMVAR(GVAR(var1),var2)
#define GETEGVAR(var1,var2,var3) GETMVAR(EGVAR(var1,var2),var3)

#define QGETGVAR(var1,var2) QUOTE(GETMVAR(QGVAR(var1),var2))

#define ARR_SELECT(ARRAY,INDEX,DEFAULT) (if (count ARRAY > INDEX) then {ARRAY select INDEX} else {DEFAULT})
#define ANY_OF(ARRAY,CONDITION) (ARRAY findIf {CONDITION} != -1)

#define MACRO_ADDWEAPON(WEAPON,COUNT) class _xx_##WEAPON { \
    weapon = #WEAPON; \
    count = COUNT; \
}

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
}

#define MACRO_ADDMAGAZINE(MAGAZINE,COUNT) class _xx_##MAGAZINE { \
    magazine = #MAGAZINE; \
    count = COUNT; \
}

#define MACRO_ADDBACKPACK(BACKPACK,COUNT) class _xx_##BACKPACK { \
    backpack = #BACKPACK; \
    count = COUNT; \
}

// Returns a text config entry as compiled code or variable from missionNamespace
#define GET_FUNCTION(var,cfg) \
    private var = getText (cfg); \
    if (isNil var) then { \
        var = compile var; \
    } else { \
        var = missionNamespace getVariable var; \
    }

// Returns a number config entry with default value of 0
// If entry is a string, will get the variable from missionNamespace
#define GET_NUMBER_ENTRY(cfg) \
    if (isText (cfg)) then { \
        missionNamespace getVariable [getText (cfg), 0]; \
    } else { \
        getNumber (cfg); \
    }

// BEGIN ACE3 reference macros

#define ACE_PREFIX ace

#define ACE_ADDON(component)        DOUBLES(ACE_PREFIX,component)

#define ACEGVAR(module,var)         TRIPLES(ACE_PREFIX,module,var)
#define QACEGVAR(module,var)        QUOTE(ACEGVAR(module,var))
#define QQACEGVAR(module,var)       QUOTE(QACEGVAR(module,var))

#define ACEFUNC(module,function)    TRIPLES(DOUBLES(ACE_PREFIX,module),fnc,function)
#define QACEFUNC(module,function)   QUOTE(ACEFUNC(module,function))

#define ACELSTRING(module,string)   QUOTE(TRIPLES(STR,DOUBLES(ACE_PREFIX,module),string))
#define ACELLSTRING(module,string)  localize ACELSTRING(module,string)
#define ACECSTRING(module,string)   QUOTE(TRIPLES($STR,DOUBLES(ACE_PREFIX,module),string))

#define ACEPATHTOF(component,path) \z\ace\addons\component\path
#define QACEPATHTOF(component,path) QUOTE(ACEPATHTOF(component,path))

// Macros for checking if unit is in medical vehicle or facility
// Defined mostly to make location check in canTreat more readable
#define IN_MED_VEHICLE(unit)  (unit call ACEFUNC(medical_treatment,isInMedicalVehicle))
#define IN_MED_FACILITY(unit) (unit call ACEFUNC(medical_treatment,isInMedicalFacility))

#define TREATMENT_LOCATIONS_ALL 0
#define TREATMENT_LOCATIONS_VEHICLES 1
#define TREATMENT_LOCATIONS_FACILITIES 2
#define TREATMENT_LOCATIONS_VEHICLES_AND_FACILITIES 3
#define TREATMENT_LOCATIONS_NONE 4

// medical_statemachine/script_component.hpp
#define FATAL_INJURIES_ALWAYS 0
#define FATAL_INJURIES_CRDC_ARRST 1
#define FATAL_INJURIES_NEVER 2


#undef PENETRATION_THRESHOLD
#undef PENETRATION_THRESHOLD_DEFAULT
#define PENETRATION_THRESHOLD ACEGVAR(medical,const_penetrationThreshold)
#define PENETRATION_THRESHOLD_DEFAULT 0.35


#undef BLOOD_LOSS_KNOCK_OUT_THRESHOLD
#define BLOOD_LOSS_KNOCK_OUT_THRESHOLD ACEGVAR(medical,const_bloodLossKnockOutThreshold)

#undef GET_BLOOD_LOSS
#define GET_BLOOD_LOSS(unit)        ([unit] call EFUNC(vitals,getBloodLoss))

// Minimum leg damage required for limping
#undef LIMPING_DAMAGE_THRESHOLD
#define LIMPING_DAMAGE_THRESHOLD ACEGVAR(medical,const_limpingDamageThreshold)

// Minimum limb damage required for fracture
#undef FRACTURE_DAMAGE_THRESHOLD
#define FRACTURE_DAMAGE_THRESHOLD ACEGVAR(medical,const_fractureDamageThreshold)

// Minimum cardiac output
#undef CARDIAC_OUTPUT_MIN
#define CARDIAC_OUTPUT_MIN ACEGVAR(medical,const_minCardiacOutput)

//We have to undef them before redefining
#undef VAR_BLOOD_PRESS
#undef VAR_BLOOD_VOL
#undef VAR_WOUND_BLEEDING
#undef VAR_CRDC_ARRST
#undef VAR_HEART_RATE
#undef VAR_PAIN
#undef VAR_PAIN_SUPP
#undef VAR_PERIPH_RES
#undef VAR_OPEN_WOUNDS
#undef VAR_BANDAGED_WOUNDS
#undef VAR_STITCHED_WOUNDS
#undef VAR_MEDICATIONS
#undef VAR_HEMORRHAGE
#undef VAR_IN_PAIN
#undef VAR_TOURNIQUET
#undef VAR_FRACTURES
#undef GET_PAIN_PERCEIVED
#undef GET_TOURNIQUETS
#undef HAS_TOURNIQUET_APPLIED_ON
#undef PAIN_UNCONSCIOUS
#undef DEFAULT_TOURNIQUET_VALUES

// These variables get stored in object space and used across components
// Defined here for easy consistency with GETVAR/SETVAR (also a list for reference)
#define VAR_BLOOD_PRESS       QACEGVAR(medical,bloodPressure)
#define VAR_BLOOD_VOL         QACEGVAR(medical,bloodVolume)
#define VAR_WOUND_BLEEDING    QEGVAR(circulation,woundBleeding)
#define VAR_CRDC_ARRST        QACEGVAR(medical,inCardiacArrest)
#define VAR_HEART_RATE        QACEGVAR(medical,heartRate)
#define VAR_PAIN              QACEGVAR(medical,pain)
#define VAR_PAIN_SUPP         QACEGVAR(medical,painSuppress)
#define VAR_PERIPH_RES        QACEGVAR(medical,peripheralResistance)
#define VAR_OPEN_WOUNDS       QACEGVAR(medical,openWounds)
#define VAR_BANDAGED_WOUNDS   QACEGVAR(medical,bandagedWounds)
#define VAR_STITCHED_WOUNDS   QACEGVAR(medical,stitchedWounds)
#define VAR_COAGED_WOUNDS     QEGVAR(hitpoints,coagedWounds)
#define VAR_WRAPPED_WOUNDS    QEGVAR(hitpoints,wrappedWounds)
#define GET_COAGED_WOUNDS(unit)   (unit getVariable [VAR_COAGED_WOUNDS, createHashMap])
#define GET_WRAPPED_WOUNDS(unit)   (unit getVariable [VAR_WRAPPED_WOUNDS, createHashMap])
// These variables track gradual adjustments (from medication, etc.)
#define VAR_MEDICATIONS       QACEGVAR(medical,medications)
// These variables track the current state of status values above
#define VAR_HEMORRHAGE        QACEGVAR(medical,hemorrhage)
#define VAR_IN_PAIN           QACEGVAR(medical,inPain)
#define VAR_TOURNIQUET        QACEGVAR(medical,tourniquets)
#define VAR_FRACTURES         QACEGVAR(medical,fractures)
#define VAR_JOINTS            QEGVAR(hitpoints,joints)

// - Unit Functions ---------------------------------------------------
// Retrieval macros for common unit values
// Defined for easy consistency and speed
#undef GET_SM_STATE
#define GET_SM_STATE(_unit)         ([_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState)

#undef GET_BLOOD_VOLUME

#define GET_OPIOID_FACTOR(unit)           (unit getVariable [QEGVAR(pharma,opioidFactor), 0])
#define GET_OPIOID_DEPRESSION(unit)           (unit getVariable [QEGVAR(pharma,opioidDepression), 0])
#define GET_PAIN_PERCEIVED(unit)    (0 max ((GET_PAIN(unit) - GET_PAIN_SUPPRESS(unit)) min 1))

#undef GET_DAMAGE_THRESHOLD
#define GET_DAMAGE_THRESHOLD(unit)  ((unit getVariable [QACEGVAR(medical,damageThreshold), [ACEGVAR(medical,AIDamageThreshold),ACEGVAR(medical,playerDamageThreshold)] select ((isPlayer unit) || (GET_CONVERT_STATUS(unit)))]) * (GET_OPIOID_FACTOR(unit) + 1))

#define VAR_KAT_TOURNIQUET        QEGVAR(hitpoints,tourniquets)
#define DEFAULT_TOURNIQUET_VALUES   [0,0,0,0,0,0,0,0,0,0,0,0]
#define GET_TOURNIQUETS(unit)       (unit getVariable [VAR_TOURNIQUET, DEFAULT_TOURNIQUET_VALUES])
#define GET_KAT_TOURNIQUETS(unit)       (unit getVariable [VAR_KAT_TOURNIQUET, DEFAULT_TOURNIQUET_VALUES])
#define GET_SURGICAL_TOURNIQUETS(unit)       (unit getVariable [QEGVAR(surgery,surgicalBlock), DEFAULT_TOURNIQUET_VALUES])
#define HAS_TOURNIQUET_APPLIED_ON(unit,index) ((GET_TOURNIQUETS(unit) select index) > 0 )
#define HAS_TOURNIQUET_ACTUAL(unit,index) (((GET_TOURNIQUETS(unit) select index) > 0) && ((GET_SURGICAL_TOURNIQUETS(unit) select index) < 1))

#define PAIN_UNCONSCIOUS ACEGVAR(medical,painUnconsciousThreshold)

// END ACE3 reference macros

// item types
#define TYPE_DEFAULT 0
#define TYPE_MUZZLE 101
#define TYPE_OPTICS 201
#define TYPE_FLASHLIGHT 301
#define TYPE_BIPOD 302
#define TYPE_FIRST_AID_KIT 401
#define TYPE_FINS 501 // not implemented
#define TYPE_BREATHING_BOMB 601 // not implemented
#define TYPE_NVG 602
#define TYPE_GOGGLE 603
#define TYPE_SCUBA 604 // not implemented
#define TYPE_HEADGEAR 605
#define TYPE_FACTOR 607
#define TYPE_RADIO 611
#define TYPE_HMD 616
#define TYPE_BINOCULAR 617
#define TYPE_MEDIKIT 619
#define TYPE_TOOLKIT 620
#define TYPE_UAV_TERMINAL 621
#define TYPE_VEST 701
#define TYPE_UNIFORM 801
#define TYPE_BACKPACK 901

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#define PREP_MODULE(folder) [] call compile preprocessFileLineNumbers QPATHTOF(folder\__PREP__.sqf)

#define KAT_isHC (!hasInterface && !isDedicated)

#define IDC_STAMINA_BAR 193

#define KAT_DEPRECATED(arg1,arg2,arg3) WARNING_3("%1 is deprecated. Support will be dropped in version %2. Replaced by: %3",arg1,arg2,arg3)

#define PFORMAT_10(MESSAGE,A,B,C,D,E,F,G,H,I,J) \
    format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8, H=%9, I=%10 J=%11', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G), RETNIL(H), RETNIL(I), RETNIL(J)]
#ifdef DEBUG_MODE_FULL
#define TRACE_10(MESSAGE,A,B,C,D,E,F,G,H,I,J) \
    [THIS_FILE_, __LINE__, PFORMAT_10(MESSAGE,A,B,C,D,E,F,G,H,I,J)] call CBA_fnc_log
#else
   #define TRACE_10(MESSAGE,A,B,C,D,E,F,G,H,I,J) /* disabled */
#endif

#define GRAVITY 9.8066

#define SD_TO_MIN_MAX(d) ((d) * 3.371) // Standard deviation -> min / max of random [min, mid, max]

// Angular unit conversion
#define MRAD_TO_MOA(d) ((d) * 3.43774677) // Conversion factor: 54 / (5 * PI)
#define MOA_TO_MRAD(d) ((d) * 0.29088821) // Conversion factor: (5 * PI) / 54
#define DEG_TO_MOA(d) ((d) * 60) // Conversion factor: 60
#define MOA_TO_DEG(d) ((d) / 60) // Conversion factor: 1 / 60
#define DEG_TO_MRAD(d) ((d) * 17.45329252) // Conversion factor: (50 * PI) / 9
#define MRAD_TO_DEG(d) ((d) / 17.45329252) // Conversion factor: 9 / (50 * PI)
#define MOA_TO_RAD(d) ((d) * 0.00029088) // Conversion factor: PI / 10800

#define QPATHTOF_SOUND(var1) QUOTE(PATHTOF2_SYS(PREFIX,COMPONENT,var1))
#define QQPATHTOF_SOUND(var1) QUOTE(QPATHTOF_SOUND(var1))

#include "script_debug.hpp"

#define ALL_BODY_PARTS_PRIORITY ["chest", "body", "head", "neck", "leftarm", "upperleftarm", "rightarm", "upperrightarm", "leftleg", "upperleftleg", "rightleg", "upperrightleg"]

#define DEFAULT_PACO2 40
#define DEFAULT_PAO2 90
#define DEFAULT_O2SAT 0.96
#define DEFAULT_HCO3 24
#define DEFAULT_PH 7.4
#define DEFAULT_ETCO2 37
#define DEFAULT_BLOOD_GAS [DEFAULT_PACO2, DEFAULT_PAO2, DEFAULT_O2SAT, DEFAULT_HCO3, DEFAULT_PH, DEFAULT_ETCO2]
#define DEFAULT_RESPIRATORY_DEPTH       10
#define DEFAULT_LOCAL_ANESTHESIA        [0,0,0,0,0,0,0,0,0,0,0,0]

#define DEFAULT_ANEROBIC_EXCHANGE 0.8
#define DEFAULT_TEMPERATURE 37

#define DEFAULT_ECB 2700
#define DEFAULT_ECP 3300
#define DEFAULT_SRBC 500
#define DEFAULT_ISP 10000
#define DEFAULT_PLATELETS 600
#define DEFAULT_BODY_FLUID [2700, 3300, 500, 10000, 6000, 600]

#define DEFAULT_BLOOD_PRESSURE [80, 120]

#define LITERS_TO_ML 1000
#define ML_TO_LITERS 1000

// Airway
#define OXYGEN_PERCENTAGE_CRITICAL 85
#define OXYGEN_PERCENTAGE_ARREST 80
#define OXYGEN_PERCENTAGE_FATAL 75

// Breathing
#define VAR_SURFACE_AREA                QEGVAR(breathing,lungSurfaceArea)
#define GET_KAT_SURFACE_AREA(unit)      (unit getVariable [VAR_SURFACE_AREA, 400])

#define VAR_BLOOD_GAS                  QEGVAR(circulation,bloodGas)
#define VAR_BREATHING_RATE             QEGVAR(breathing,breathRate)

#define GET_BLOOD_GAS(unit)            (unit getVariable [VAR_BLOOD_GAS, DEFAULT_BLOOD_GAS])
#define GET_PAO2(unit)                 ((unit getVariable [VAR_BLOOD_GAS, DEFAULT_BLOOD_GAS]) select 1)
#define GET_KAT_SPO2(unit)             (((unit getVariable [VAR_BLOOD_GAS, DEFAULT_BLOOD_GAS]) select 2) * 100)
#define GET_PH(unit)                   ((unit getVariable [VAR_BLOOD_GAS, DEFAULT_BLOOD_GAS]) select 4)
#define GET_ETCO2(unit)                ((unit getVariable [VAR_BLOOD_GAS, DEFAULT_BLOOD_GAS]) select 5)
#define GET_BREATHING_RATE(unit)       (unit getVariable [VAR_BREATHING_RATE, 15])

#define VAR_RESPIRATORY_DEPTH           QEGVAR(vitals,respiratoryDepth)
#define GET_KAT_RESPIRATORY_DEPTH(unit)      (unit getVariable [QEGVAR(vitals,respiratoryDepth), 10])


// Circulation
#define VAR_INTERNAL_BLEEDING          QEGVAR(circulation,internalBleeding)
#define GET_INTERNAL_BLEEDING(unit)    (unit getVariable [VAR_INTERNAL_BLEEDING, 0])

#define VAR_BODY_FLUID                 QEGVAR(circulation,bodyFluid)
#define GET_BODY_FLUID(unit)           (unit getVariable [VAR_BODY_FLUID, DEFAULT_BODY_FLUID])
#define GET_BODY_FLUID_ECB(unit)       ((unit getVariable [VAR_BODY_FLUID, DEFAULT_BODY_FLUID]) select 0)
#define GET_BODY_FLUID_ECP(unit)       ((unit getVariable [VAR_BODY_FLUID, DEFAULT_BODY_FLUID]) select 1)
#define GET_BODY_FLUID_SRBC(unit)      ((unit getVariable [VAR_BODY_FLUID, DEFAULT_BODY_FLUID]) select 2)
#define GET_BODY_FLUID_ISP(unit)       ((unit getVariable [VAR_BODY_FLUID, DEFAULT_BODY_FLUID]) select 3)
#define GET_BODY_FLUID_PLATELETS(unit) ((unit getVariable [VAR_BODY_FLUID, DEFAULT_BODY_FLUID]) select 5)


#define GET_BLOOD_VOLUME_LITERS(unit)  ((GET_BODY_FLUID(unit) select 4) / 1000)
#define GET_BLOOD_VOLUME_ML(unit)      (GET_BODY_FLUID(unit) select 4)
#define GET_SIMPLE_BLOOD_VOLUME(unit)  (unit getVariable [VAR_BLOOD_VOL, DEFAULT_BLOOD_VOLUME])

#define REDUCE_TOTAL_BLOOD_VOLUME(unit,volume) (unit setVariable [VAR_BODY_FLUID, [(GET_BODY_FLUID(unit) select 0) - (volume / 2), (GET_BODY_FLUID(unit) select 1) - (volume / 2), (GET_BODY_FLUID(unit) select 2), (GET_BODY_FLUID(unit) select 3), ((GET_BODY_FLUID(unit) select 4) - volume), (GET_BODY_FLUID(unit) select 5)], true])

#undef GET_BLOOD_PRESSURE
#define GET_BLOOD_PRESSURE(unit)       ([unit] call EFUNC(circulation,getBloodPressure))
#define VAR_BLOODPRESSURE_CHANGE       QEGVAR(circulation,bloodPressureChange)
#define GET_BLOODPRESSURE_CHANGE(unit) (unit getVariable [VAR_BLOODPRESSURE_CHANGE, [0,0]])

// Conversion
#define UNIT_CONVERT                   QEGVAR(conversion,currentlyConverted)
#define GET_CONVERT_STATUS(unit)       (unit getVariable [UNIT_CONVERT, false])

// Pharma
#define VAR_VASOCONSTRICTION           QEGVAR(pharma,alphaAction)
#define GET_VASOCONSTRICTION(unit)     (unit getVariable [VAR_VASOCONSTRICTION, 1])

#define VAR_LOCAL_ANESTHESIA            QEGVAR(pharma,localAnesthesia)
#define GET_LOCAL_ANESTHESIA(unit,partindex)      ((unit getVariable [VAR_LOCAL_ANESTHESIA, DEFAULT_LOCAL_ANESTHESIA]) select _partindex)

#define VAR_FENT_PATCH                      QEGVAR(pharma,fentanylPatch)
#define GET_FENT_PATCH(unit,partindex)      ((unit getVariable [VAR_FENT_PATCH, [0,0,0,0,0,0,0,0,0,0,0,0]]) select _partindex)
#define HAS_FENT_PATCH(unit,partindex)      ((GET_FENT_PATCH(unit,partindex)) > 0 )

//Surgery
#define STRING_BODY_PARTS ["head", "neck", "chest", "body", "left arm", "upper left arm", "right arm", "upper right arm", "left leg", "upper leftleg", "right leg", "upper right leg"]
#define GET_REBOA_VOLUME(unit)         ([unit] call EFUNC(surgery,reboaVolume))

//Feedback
#define VAR_PP QEGVAR(feedback,ppEffect)
#define GET_PP(unit) (unit getVariable [VAR_PP, 0])

#define KAT_DEFAULT_HEART_RATE(unit) (_unit getVariable [QEGVAR(circulation,defaultHeartRate), 80])

//Ophthalmology
#define GET_DUST_INJURY(unit) ((unit getVariable [QEGVAR(ophthalmology,dustInjuryLight), 0]) + (unit getVariable [QEGVAR(ophthalmology,dustInjuryHeavy), 0]))
#define GET_EYE_INJURIES(unit) (unit getVariable [QEGVAR(ophthalmology,eyeInjuries), [1,1]])

//Hitpoints

#undef ALL_BODY_PARTS
#undef ALL_SELECTIONS
#undef ALL_HITPOINTS

#define ALL_BODY_PARTS ["head", "neck", "chest", "body", "leftarm", "upperleftarm", "rightarm", "upperrightarm", "leftleg", "upperleftleg", "rightleg", "upperrightleg"]
#define ALL_SELECTIONS ["head", "neck", "chest", "body", "hand_l", "uhand_l", "hand_r", "uhand_r", "leg_l", "uleg_l", "leg_r", "uleg_r"]
#define ALL_HITPOINTS ["HitHead", "HitNeck", "HitChest", "HitAbdomen", "HitLeftArm", "HitRightArm", "HitLeftLeg", "HitRightLeg" "HitUpperUpperLeftArm", "HitUpperRightArm", "HitUpperLeftLeg", "HitUpperRightLeg"]

#undef HITPOINT_INDEX_BODY
#undef HITPOINT_INDEX_LARM
#undef HITPOINT_INDEX_RARM
#undef HITPOINT_INDEX_LLEG
#undef HITPOINT_INDEX_RLEG

#undef DEFAULT_TOURNIQUET_VALUES
#undef DEFAULT_FRACTURE_VALUES
#undef DEFAULT_BODYPART_DAMAGE_VALUES

#define HITPOINT_INDEX_NECK 1
#define HITPOINT_INDEX_CHEST 2
#define HITPOINT_INDEX_BODY 3
#define HITPOINT_INDEX_LARM 4
#define HITPOINT_INDEX_ULARM 5
#define HITPOINT_INDEX_RARM 6
#define HITPOINT_INDEX_URARM 7
#define HITPOINT_INDEX_LLEG 8
#define HITPOINT_INDEX_ULLEG 9
#define HITPOINT_INDEX_RLEG 10
#define HITPOINT_INDEX_URLEG 11

// Body points
// 0 Head
// 1 Neck
// 2 Chest (Above Diaphragm)
// 3 Body (Below Diaphragm)
// 4 Left Arm
// 5 Upper Left Arm
// 6 Right Arm
// 7 Upper Right Arm
// 8 Left Leg
// 9 Upper Left Leg
// 10 Right Leg
// 11 Upper Right Leg

#define DEFAULT_APPLIEDPRESSURE_VALUES [0,0,0,0,0,0,0,0,0,0,0,0]
#define DEFAULT_TOURNIQUET_VALUES [0,0,0,0,0,0,0,0,0,0,0,0]
#define DEFAULT_FRACTURE_VALUES [0,0,0,0,0,0,0,0,0,0,0,0]
#define DEFAULT_BODYPART_DAMAGE_VALUES [0,0,0,0,0,0,0,0,0,0,0,0]
#define DEFAULT_BODY_BLEED_RATE_VALUES   [0,0,0,0,0,0,0,0,0,0,0,0]
// Joint points
// 0 Left Shoulder
// 1 Left Elbow
// 2 Left Wrist
// 3 Right Shoulder
// 4 Right Elbow
// 5 Right Wrist
// 6 Left Hip
// 7 Left Knee
// 8 Left Ankle
// 9 Right Hip
// 10 Right Knee
// 11 Right Ankle

// Joint Injury
// 0 No Injury
// 1 Inflamed Strain
// 2 Inflamed Sprain
// 3 Dislocation
// 4 Iced Strain
// 5 Iced Sprain
// 6 Stabilized Dislocation
// 7 Strain
// 8 Sprain
// 9 Reduced Dislocation
// 10 Wrapped Strain
// 11 Wrapped Sprain

#define DEFAULT_JOINT_VALUES [[0,0,0],[0,0,0],[0,0,0],[0,0,0]]

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define PATIENT_INFO_IGUI_BASE_X (safeZoneX + POS_W(2))
#define PATIENT_INFO_IGUI_BASE_Y (safeZoneY + POS_H(1))
#define PATIENT_INFO_IGUI_X (profilenamespace getVariable ['TRIPLES(IGUI,GVAR(patientInfo),X)', 0])
#define PATIENT_INFO_IGUI_Y (profilenamespace getVariable ['TRIPLES(IGUI,GVAR(patientInfo),Y)', 0])
#define PATIENT_INFO_IGUI_OFFSET_X (PATIENT_INFO_IGUI_X - PATIENT_INFO_IGUI_BASE_X)
#define PATIENT_INFO_IGUI_OFFSET_Y (PATIENT_INFO_IGUI_Y - PATIENT_INFO_IGUI_BASE_Y)

#undef BANDAGE_TIME_S
#undef BANDAGE_TIME_M
#undef BANDAGE_TIME_L
#undef BANDAGE_TIME_MOD_MEDIC
#undef BANDAGE_TIME_MOD_SELF

#define BANDAGE_TIME_S 4
#define BANDAGE_TIME_M 6
#define BANDAGE_TIME_L 8
#define BANDAGE_TIME_MOD_MEDIC 0.75
#define BANDAGE_TIME_MOD_SELF 1.25

#define VAR_APPLIEDPRESSURE   QEGVAR(hitpoints,appliedPressure)
#define GET_APPLIEDPRESSURE(unit)   (unit getVariable [VAR_APPLIEDPRESSURE, DEFAULT_APPLIEDPRESSURE_VALUES])
#define GET_APPLIEDPRESSURE_ON(unit,index) (GET_APPLIEDPRESSURE(unit) select index)
#define HAS_APPLIEDPRESSURE_ON(unit,index) ((GET_APPLIEDPRESSURE(unit) select index) > 0)

#define VAR_BODY_BLEED_RATE   QEGVAR(hitpoints,limbBleedRate)
#define GET_BODY_BLEED_RATE(unit)   (unit getVariable [VAR_BODY_BLEED_RATE, DEFAULT_BODY_BLEED_RATE_VALUES])
#define GET_BODY_PART_RATE(unit,index) (GET_BODY_BLEED_RATE(unit) select index)
#define HAS_LIMB_BLEEDING(unit,index) ((GET_BODY_BLEED_RATE(unit) select index) > 0)

#define GET_JOINTS(unit)   (unit getVariable [VAR_JOINTS, DEFAULT_JOINT_VALUES])
#define GET_LIMB_JOINT(unit,limbindex)   ((unit getVariable [VAR_JOINTS, DEFAULT_JOINT_VALUES]) select _limbindex)

#undef PRIORITY_HEAD
#undef PRIORITY_BODY
#undef PRIORITY_LEFT_ARM
#undef PRIORITY_RIGHT_ARM
#undef PRIORITY_LEFT_LEG
#undef PRIORITY_RIGHT_LEG

#define PRIORITY_HEAD       4
#define PRIORITY_NECK       3
#define PRIORITY_BODY       5
#define PRIORITY_CHEST      6
#define PRIORITY_LEFT_ARM   (1 + random 1)
#define PRIORITY_RIGHT_ARM  (1 + random 1)
#define PRIORITY_UPPER_LEFT_ARM   (1 + random 1)
#define PRIORITY_UPPER_RIGHT_ARM  (1 + random 1)
#define PRIORITY_LEFT_LEG   (1 + random 1)
#define PRIORITY_RIGHT_LEG  (1 + random 1)
#define PRIORITY_UPPER_LEFT_LEG   (1 + random 1)
#define PRIORITY_UPPER_RIGHT_LEG  (1 + random 1)

#undef ADD_ACE_HITPOINTS
#define ADD_ACE_HITPOINTS\
    class HitLeftArm: HitHands {\
        material = -1;\
        name = "LeftForeArm";\
        radius = 0.08;\
        visual = "injury_hands";\
        minimalHit = 0.01;\
    };\
    class HitRightArm: HitLeftArm {\
        name = "RightForeArm";\
    };\
    class HitUpperLeftArm: HitLeftArm {\
        name = "LeftArm";\
    };\
    class HitUpperRightArm: HitLeftArm {\
        name = "RightArm";\
    };\
    class HitUpperRollLeftArm: HitLeftArm {\
        name = "LeftArmRoll";\
    };\
    class HitUpperRollRightArm: HitLeftArm {\
        name = "RightArmRoll";\
    };\
    class HitLeftLeg: HitLegs {\
        material = -1;\
        name = "LeftLeg";\
        radius = 0.1;\
        visual = "injury_legs";\
        minimalHit = 0.01;\
    };\
    class HitRightLeg: HitLeftLeg {\
        name = "RightLeg";\
    };\
    class HitUpperLeftLeg: HitLeftLeg {\
        name = "L_Femur_hit";\
    };\
    class HitUpperRightLeg: HitLeftLeg {\
        name = "R_Femur_hit";\
    };\
    class HitLeftLegRoll: HitLeftLeg {\
        name = "LeftLegRoll";\
    };\
    class HitRightLegRoll: HitLeftLeg {\
        name = "RightLegRoll";\
    };\
    class HitLeftFoot: HitLeftLeg {\
        name = "LeftFoot";\
    };\
    class HitRightFoot: HitLeftLeg {\
        name = "RightFoot";\
    }
#undef FATAL_SUM_DAMAGE_WEIBULL_K
#undef FATAL_SUM_DAMAGE_WEIBULL_L
#define FATAL_SUM_DAMAGE_WEIBULL_K ACEGVAR(medical,const_fatalSumDamageWeibull_K)
#define FATAL_SUM_DAMAGE_WEIBULL_L ACEGVAR(medical,const_fatalSumDamageWeibull_L)

#undef BLOOD_LOSS_RED_THRESHOLD
#undef BLOOD_LOSS_TOTAL_COLORS
#define BLOOD_LOSS_RED_THRESHOLD 0.5
#define BLOOD_LOSS_TOTAL_COLORS 10

#define CONCAT(a,b) a##b
#define LSTR(module,name) CONCAT(STR_MIRA_AVM_,CONCAT(module,CONCAT(_,name)))
#define ICON_PATH(name) ADDON##\ui\##name##.paa

#define LOG_BASE(level,msg) diag_log text format[QUOTE(ADDON[level]: %1), msg]
#define LOG(msg) LOG_BASE(DEBUG, LOG_FILENUMBER(msg))
#define LOGF_1(msg,arg0) LOG(format[ARR_2(msg,arg0)])
#define LOGF_2(msg,arg0,arg1) LOG(format[ARR_3(msg,arg0,arg1)])
#define LOGF_3(msg,arg0,arg1,arg2) LOG(format[ARR_4(msg,arg0,arg1,arg2)])
#define LOG_ERROR(msg) LOG_BASE(ERR,LOG_FILENUMBER(msg))
#define LOG_ERRORF_1(msg,arg0) LOG_ERROR(format[ARR_2(msg,arg0)])
#define LOG_ERRORF_2(msg,arg0,arg1) LOG_ERROR(format[ARR_3(msg,arg0,arg1)])
#define LOG_FILENUMBER(msg) format [ARR_4('%1 at %2:%3',msg,__FILE__,__LINE__ + 1)]
#define NOTMEDIC_LOWHR_THRESHOLD 50
#define NOTMEDIC_LOWBP_THRESHOLD 90

#define HAS_AIRWAY(unit)  (unit call EFUNC(airway,airwayCheck))
