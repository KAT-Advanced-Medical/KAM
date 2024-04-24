#define COMPONENT gui
#define COMPONENT_BEAUTIFIED KAT GUI
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_GUI
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_GUI
    #define DEBUG_SETTINGS DEBUG_SETTINGS_GUI
#endif

#include "\x\kat\addons\main\script_macros.hpp"

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

#undef MED_LOG_VARNAME
#define MED_LOG_VARNAME(type) (format ["ace_medical_log_%1", type])

#include "gui_defines.hpp"
