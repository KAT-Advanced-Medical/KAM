#define COMPONENT zeus
#define COMPONENT_BEAUTIFIED KAT - ZEUS
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_ZEUS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ZEUS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ZEUS
#endif

#include "\x\kat\addons\main\script_macros.hpp"

// UI grid
#define SIZEX ((safeZoneW / safeZoneH) min 1.2)
#define SIZEY (SIZEX / 1.2)
#define W_PART(num) (num * (SIZEX / 40))
#define H_PART(num) (num * (SIZEY / 25))
#define X_PART(num) (W_PART(num) + (safeZoneX + (safeZoneW - SIZEX) / 2))
#define Y_PART(num) (H_PART(num) + (safeZoneY + (safeZoneH - SIZEY) / 2))

#define MED_LOG_VARNAME(type) (format ["ace_medical_log_%1", type])

#define IDC_BODY_GROUP      6000
#define IDC_BODY_HEAD       6005
#define IDC_BODY_TORSO      6010
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

#define IDD_MEDICAL_MENU 38580

#define IDC_TITLE 1200
#define IDC_TRIAGE 1300
#define IDC_EXAMINE 1310
#define IDC_BANDAGE 1320
#define IDC_MEDICATION 1330
#define IDC_AIRWAY 1340
#define IDC_ADVANCED 1350
#define IDC_DRAG 1360
#define IDC_TOGGLE 1370
#define IDC_SURGERY 1380

#define IDC_TRIAGE_CARD 1400
#define IDC_INJURIES 1410
#define IDC_ACTIVITY 1420
#define IDC_QUICKVIEW 1430

#define IDC_ACTION_1 1500
#define IDC_ACTION_2 1510
#define IDC_ACTION_3 1520
#define IDC_ACTION_4 1530
#define IDC_ACTION_5 1540
#define IDC_ACTION_6 1550
#define IDC_ACTION_7 1560
#define IDC_ACTION_8 1570
#define IDC_ACTION_9 1580
#define IDC_ACTION_10 1590
#define IDC_ACTION_11 1600
