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
#define VAR_WOUND_BLEEDING    QACEGVAR(medical,woundBleeding)
#define VAR_CRDC_ARRST        QACEGVAR(medical,inCardiacArrest)
#define VAR_HEART_RATE        QACEGVAR(medical,heartRate)
#define VAR_PAIN              QACEGVAR(medical,pain)
#define VAR_PAIN_SUPP         QACEGVAR(medical,painSuppress)
#define VAR_PERIPH_RES        QACEGVAR(medical,peripheralResistance)
#define VAR_OPEN_WOUNDS       QACEGVAR(medical,openWounds)
#define VAR_BANDAGED_WOUNDS   QACEGVAR(medical,bandagedWounds)
#define VAR_STITCHED_WOUNDS   QACEGVAR(medical,stitchedWounds)
// These variables track gradual adjustments (from medication, etc.)
#define VAR_MEDICATIONS       QACEGVAR(medical,medications)
// These variables track the current state of status values above
#define VAR_HEMORRHAGE        QACEGVAR(medical,hemorrhage)
#define VAR_IN_PAIN           QACEGVAR(medical,inPain)
#define VAR_TOURNIQUET        QACEGVAR(medical,tourniquets)
#define VAR_FRACTURES         QACEGVAR(medical,fractures)

// - Unit Functions ---------------------------------------------------
// Retrieval macros for common unit values
// Defined for easy consistency and speed
#undef GET_SM_STATE
#define GET_SM_STATE(_unit)         ([_unit, ACEGVAR(medical,STATE_MACHINE)] call CBA_statemachine_fnc_getCurrentState)

#define GET_OPIOID_FACTOR(unit)           (unit getVariable [QEGVAR(pharma,opioidFactor), 1])

#undef GET_DAMAGE_THRESHOLD
#define GET_DAMAGE_THRESHOLD(unit)  ((unit getVariable [QACEGVAR(medical,damageThreshold), [ACEGVAR(medical,AIDamageThreshold),ACEGVAR(medical,playerDamageThreshold)] select (isPlayer unit)]) * GET_OPIOID_FACTOR(unit))
#define GET_PAIN_PERCEIVED(unit)    (0 max (GET_PAIN(unit) - GET_PAIN_SUPPRESS(unit)) min 1)

#define DEFAULT_TOURNIQUET_VALUES   [0,0,0,0,0,0]
#define GET_TOURNIQUETS(unit)       (unit getVariable [VAR_TOURNIQUET, DEFAULT_TOURNIQUET_VALUES])
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

#define ALL_BODY_PARTS_PRIORITY ["body", "head", "leftarm", "rightarm", "leftleg", "rightleg"]

// Airway
#define VAR_SPO2                       QEGVAR(breathing,airwayStatus)
#define GET_SPO2(unit)                 (unit getVariable [VAR_SPO2, 100])

// Circulation
#define VAR_INTERNAL_BLEEDING          QEGVAR(circulation,internalBleeding)
#define GET_INTERNAL_BLEEDING(unit)    (unit getVariable [VAR_INTERNAL_BLEEDING, 0])

#undef GET_BLOOD_PRESSURE
#define GET_BLOOD_PRESSURE(unit)       ([unit] call EFUNC(circulation,getBloodPressure))
#define VAR_BLOODPRESSURE_CHANGE       QEGVAR(circulation,bloodPressureChange)
#define GET_BLOODPRESSURE_CHANGE(unit) (unit getVariable [VAR_BLOODPRESSURE_CHANGE, [0,0]])

// Pharmacy
#undef GET_BLOOD_LOSS
#define GET_BLOOD_LOSS(unit)           ([unit] call EFUNC(pharma,getBloodLoss))

//Surgery
#define STRING_BODY_PARTS ["head", "body", "left arm", "right arm", "left leg", "right leg"]
