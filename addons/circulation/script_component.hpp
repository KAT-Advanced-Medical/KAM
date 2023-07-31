#define COMPONENT circulation
#define COMPONENT_BEAUTIFIED KAT - Circulation
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_CIRCULATION
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CIRCULATION
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CIRCULATION
#endif

#include "\x\kat\addons\main\script_macros.hpp"
#include "\z\ace\addons\medical_engine\script_macros_medical.hpp"

// UI stuff
#define GUI_GRID_W (safezoneW * 0.55)
#define GUI_GRID_H (GUI_GRID_W * 4/3)
#define GUI_GRID_X (safezoneX + (safezoneW - GUI_GRID_W) / 2)
#define GUI_GRID_Y (safezoneY + (safezoneH - GUI_GRID_H) / 2)

#define pxToScreen_X(X) (X / 2048 * GUI_GRID_W + GUI_GRID_X)
#define pxToScreen_Y(X) (X / 2048 * GUI_GRID_H + GUI_GRID_Y)
#define pxToScreen_W(X) (X / 2048 * GUI_GRID_W)
#define pxToScreen_H(X) (X / 2048 * GUI_GRID_H)

#define GRID_H ((((safezoneW / safezoneH) min 1.2) / 1.2) / 22)

#define GET_BLOOD_PRESSURE(unit) ([unit] call EFUNC(circulation,getBloodPressure))

#define VAR_BLOODPRESSURE_CHANGE QGVAR(BPChange)
#define GET_BLOODPRESSURE_CHANGE(unit) (unit getVariable [VAR_BLOODPRESSURE_CHANGE, [0,0]])

