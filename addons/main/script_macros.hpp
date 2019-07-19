#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2

#define DGVAR(varName)    if(isNil "KAM_DEBUG_NAMESPACE") then { KAM_DEBUG_NAMESPACE = []; }; if(!(QUOTE(GVAR(varName)) in KAM_DEBUG_NAMESPACE)) then { PUSH(KAM_DEBUG_NAMESPACE, QUOTE(GVAR(varName))); }; GVAR(varName)
#define DVAR(varName)     if(isNil "KAM_DEBUG_NAMESPACE") then { KAM_DEBUG_NAMESPACE = []; }; if(!(QUOTE(varName) in KAM_DEBUG_NAMESPACE)) then { PUSH(KAM_DEBUG_NAMESPACE, QUOTE(varName)); }; varName
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

#define KAM_isHC (!hasInterface && !isDedicated)

#define IDC_STAMINA_BAR 193

#define KAM_DEPRECATED(arg1,arg2,arg3) WARNING_3("%1 is deprecated. Support will be dropped in version %2. Replaced by: %3",arg1,arg2,arg3)

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

// medical things
#define BLOOD_TYPE(unit) (unit getVariable [QEGVAR(circulation,bloodtype),"O"])

#define LINKFUNC(var1) {_this call FUNC(var1)}

#include "script_debug.hpp"

#define DEFAULT_BLOOD_VOLUME 6.0 // in liters
#define DEFAULT_HEART_RATE 80
#define DEFAULT_PERIPH_RES 100
#define DEFAULT_TOURNIQUET_VALUES [0,0,0,0,0,0]
#define DEFAULT_FRACTURE_VALUES [0,0,0,0,0,0]

// - Unit Variables ----------------------------------------------------
// These variables get stored in object space and used across components
// Defined here for easy consistency with GETVAR/SETVAR (also a list for reference)
#define VAR_BLOOD_PRESS       "ace_medical_bloodPressure"
#define VAR_BLOOD_VOL         "ace_medical_bloodVolume"
#define VAR_WOUND_BLEEDING    "ace_medical_woundBleeding"
#define VAR_CRDC_ARRST        "ace_medical_inCardiacArrest"
#define VAR_HEART_RATE        "ace_medical_heartRate"
#define VAR_PAIN              "ace_medical_pain"
#define VAR_PAIN_SUPP         "ace_medical_painSuppress"
#define VAR_PERIPH_RES        "ace_medical_peripheralResistance"
#define VAR_UNCON             "ACE_isUnconscious"
#define VAR_OPEN_WOUNDS       "ace_medical_openWounds"
#define VAR_BANDAGED_WOUNDS   "ace_medical_bandagedWounds"
#define VAR_STITCHED_WOUNDS   "ace_medical_stitchedWounds"
// These variables track gradual adjustments (from medication, etc.)
#define VAR_MEDICATIONS       "ace_medical_medications"
// These variables track the current state of status values above
#define VAR_HEMORRHAGE        "ace_medical_hemorrhage"
#define VAR_IN_PAIN           "ace_medical_inPain"
#define VAR_TOURNIQUET        "ace_medical_tourniquets"
#define VAR_FRACTURES         "ace_medical_fractures"

// - Unit Functions ---------------------------------------------------
// Retrieval macros for common unit values
// Defined for easy consistency and speed
#define GET_BLOOD_VOLUME(unit)      (unit getVariable [VAR_BLOOD_VOL, DEFAULT_BLOOD_VOLUME])
#define GET_WOUND_BLEEDING(unit)    (unit getVariable [VAR_WOUND_BLEEDING, 0])
#define GET_HEART_RATE(unit)        (unit getVariable [VAR_HEART_RATE, DEFAULT_HEART_RATE])
#define GET_HEMORRHAGE(unit)        (unit getVariable [VAR_HEMORRHAGE, 0])
#define GET_PAIN(unit)              (unit getVariable [VAR_PAIN, 0])
#define GET_PAIN_SUPPRESS(unit)     (unit getVariable [VAR_PAIN_SUPP, 0])
#define GET_TOURNIQUETS(unit)       (unit getVariable [VAR_TOURNIQUET, DEFAULT_TOURNIQUET_VALUES])
#define GET_FRACTURES(unit)         (unit getVariable [VAR_FRACTURES, DEFAULT_FRACTURE_VALUES])
#define IN_CRDC_ARRST(unit)         (unit getVariable [VAR_CRDC_ARRST, false])
#define IS_BLEEDING(unit)           (GET_WOUND_BLEEDING(unit) > 0)
#define IS_IN_PAIN(unit)            (unit getVariable [VAR_IN_PAIN, false])
#define IS_UNCONSCIOUS(unit)        (unit getVariable [VAR_UNCON, false])
#define GET_OPEN_WOUNDS(unit)       (unit getVariable [VAR_OPEN_WOUNDS, []])
#define GET_BANDAGED_WOUNDS(unit)   (unit getVariable [VAR_BANDAGED_WOUNDS, []])
#define GET_STITCHED_WOUNDS(unit)   (unit getVariable [VAR_STITCHED_WOUNDS, []])

// The following function calls are defined here just for consistency
#define GET_BLOOD_LOSS(unit)        ([unit] call EFUNC(medical_status,getBloodLoss))
#define GET_BLOOD_PRESSURE(unit)    ([unit] call EFUNC(medical_status,getBloodPressure))

// Derivative unit values commonly used
#define GET_PAIN_PERCEIVED(unit)    (0 max (GET_PAIN(unit) - GET_PAIN_SUPPRESS(unit)) min 1)

#define HAS_TOURNIQUET_APPLIED_ON(unit,index) ((GET_TOURNIQUETS(unit) select index) > 0)
