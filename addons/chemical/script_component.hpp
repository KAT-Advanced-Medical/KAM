#define COMPONENT chemical
#define COMPONENT_BEAUTIFIED KAT - Chemical
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_CHEMICAL
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CHEMICAL
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CHEMICAL
#endif

#include "\x\kat\addons\main\script_macros.hpp"
#include "\z\ace\addons\medical_engine\script_macros_medical.hpp"

#include "\a3\ui_f\hpp\defineResincl.inc"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineCommonColors.inc"

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


// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2


#define IDC_INJURIES 1410

#define VAR_WOUND_BLEEDING          "ace_medical_woundBleeding"
#define GET_WOUND_BLEEDING(unit)    (unit getVariable [VAR_WOUND_BLEEDING, 0])
#define IS_BLEEDING(unit)           (GET_WOUND_BLEEDING(unit) > 0)


#define VAR_HEMORRHAGE              "ace_medical_hemorrhage"
#define GET_HEMORRHAGE(unit)        (unit getVariable [VAR_HEMORRHAGE, 0])


#define DEFAULT_TOURNIQUET_VALUES   [0,0,0,0,0,0]
#define VAR_TOURNIQUET              "ace_medical_tourniquets"
#define GET_TOURNIQUETS(unit)       (unit getVariable [VAR_TOURNIQUET, DEFAULT_TOURNIQUET_VALUES])
#define HAS_TOURNIQUET_APPLIED_ON(unit,index) ((GET_TOURNIQUETS(unit) select index) > 0)


#define DEFAULT_FRACTURE_VALUES [0,0,0,0,0,0]
#define VAR_FRACTURES               "ace_medical_fractures"
#define GET_FRACTURES(unit)         (unit getVariable [VAR_FRACTURES, DEFAULT_FRACTURE_VALUES])


#define VAR_PAIN                    "ace_medical_pain"
#define VAR_PAIN_SUPP               "ace_medical_painSuppress"
#define GET_PAIN(unit)              (unit getVariable [VAR_PAIN, 0])
#define GET_PAIN_SUPPRESS(unit)     (unit getVariable [VAR_PAIN_SUPP, 0])
#define GET_PAIN_PERCEIVED(unit)    (0 max (GET_PAIN(unit) - GET_PAIN_SUPPRESS(unit)) min 1)
#define VAR_IN_PAIN                 "ace_medical_inPain"


#define VAR_OPEN_WOUNDS             "ace_medical_openWounds"
#define GET_OPEN_WOUNDS(unit)       (unit getVariable [VAR_OPEN_WOUNDS, []])
#define VAR_BANDAGED_WOUNDS         "ace_medical_bandagedWounds"
#define GET_BANDAGED_WOUNDS(unit)   (unit getVariable [VAR_BANDAGED_WOUNDS, []])
#define VAR_STITCHED_WOUNDS         "ace_medical_stitchedWounds"
#define GET_STITCHED_WOUNDS(unit)   (unit getVariable [VAR_STITCHED_WOUNDS, []])

#define DEFAULT_BLOOD_VOLUME        6.0 // in liters
#define DEFAULT_HEART_RATE          80
#define DEFAULT_PERIPH_RES          100
#define VAR_MEDICATIONS             "ace_medical_medications"
#define VAR_BLOOD_PRESS             "ace_medical_bloodPressure"
#define VAR_BLOOD_VOL               "ace_medical_bloodVolume"
#define VAR_HEART_RATE              "ace_medical_heartRate"
#define VAR_PERIPH_RES              "ace_medical_peripheralResistance"

#define VAR_UNCON                   "ACE_isUnconscious"
#define IS_UNCONSCIOUS(unit)        (unit getVariable [VAR_UNCON, false])


#define IDD_MEDICAL_MENU 38580

#define IDC_BODY_GROUP      6000
#define IDC_BODY_HEAD       6005
#define IDC_BODY_TORSO      6010
#define IDC_BODY_TORSO_I    6011
#define IDC_BODY_ARMLEFT    6015
#define IDC_BODY_ARMRIGHT   6020
#define IDC_BODY_LEGLEFT    6025
#define IDC_BODY_LEGRIGHT   6030
#define IDC_BODY_ARMLEFT_T  6035
#define IDC_BODY_ARMRIGHT_T 6040
#define IDC_BODY_LEGLEFT_T  6045
#define IDC_BODY_LEGRIGHT_T 6050
#define IDC_BODY_ARMLEFT_B  6055
#define IDC_BODY_ARMRIGHT_B 6060
#define IDC_BODY_LEGLEFT_B  6065
#define IDC_BODY_LEGRIGHT_B 6070

#define IDC_TRIAGE_STATUS 7000
#define IDC_TRIAGE_SELECT 7100

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)
#define PATIENT_INFO_IGUI_BASE_X (safeZoneX + POS_W(2))
#define PATIENT_INFO_IGUI_BASE_Y (safeZoneY + POS_H(1))



#define SIZEX ((safeZoneW / safeZoneH) min 1.2)
#define SIZEY (SIZEX / 1.2)
#define W_PART(num) (num * (SIZEX / 40))
#define H_PART(num) (num * (SIZEY / 25))
#define X_PART(num) (W_PART(num) + (safeZoneX + (safeZoneW - SIZEX) / 2))
#define Y_PART(num) (H_PART(num) + (safeZoneY + (safeZoneH - SIZEY) / 2))

#define CAN_CREATE_NONE    -1
#define CAN_CREATE_ADMIN    0
#define CAN_CREATE_CONSOLE  1
#define CAN_CREATE_ALL      2

// weapon types
#define TYPE_WEAPON_PRIMARY 1
#define TYPE_WEAPON_HANDGUN 2
#define TYPE_WEAPON_SECONDARY 4
// magazine types
#define TYPE_MAGAZINE_HANDGUN_AND_GL 16 // mainly
#define TYPE_MAGAZINE_PRIMARY_AND_THROW 256
#define TYPE_MAGAZINE_SECONDARY_AND_PUT 512 // mainly
#define TYPE_MAGAZINE_MISSILE 768
// more types
#define TYPE_BINOCULAR_AND_NVG 4096
#define TYPE_WEAPON_VEHICLE 65536
#define TYPE_ITEM 131072
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

#define ACE_isHC (!hasInterface && !isDedicated)

#define IDC_STAMINA_BAR 193

#define ACE_DEPRECATED(arg1,arg2,arg3) WARNING_3("%1 is deprecated. Support will be dropped in version %2. Replaced by: %3",arg1,arg2,arg3)

#define PFORMAT_10(MESSAGE,A,B,C,D,E,F,G,H,I,J) \
    format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8, H=%9, I=%10 J=%11', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G), RETNIL(H), RETNIL(I), RETNIL(J)]
#ifdef DEBUG_MODE_FULL
#define TRACE_10(MESSAGE,A,B,C,D,E,F,G,H,I,J) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_10(str diag_frameNo + ' ' + (MESSAGE),A,B,C,D,E,F,G,H,I,J))
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

#define ZEUS_ACTION_CONDITION ([_target, {QUOTE(QUOTE(ADDON)) in curatorAddons _this}, missionNamespace, QUOTE(QGVAR(zeusCheck)), 1E11, 'ace_interactMenuClosed'] call EFUNC(common,cachedCall))




#define GET_POISONING(unit)  (unit getVariable [VAR_poisoning, 0])


#define ANIMATION_SPEED_MIN_COEFFICIENT 0.5

// Animations that would be played faster than this are instead skipped. (= Progress bar too quick for animation).
#define ANIMATION_SPEED_MAX_COEFFICIENT 2.5
