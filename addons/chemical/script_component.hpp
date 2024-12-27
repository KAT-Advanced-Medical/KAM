#define COMPONENT chemical
#define COMPONENT_BEAUTIFIED KAT - Chemical
#include "\x\kat\addons\main\script_mod.hpp"
#include "\x\kat\addons\gui\gui_defines.hpp"

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

// UI grid
#define SIZEX ((safeZoneW / safeZoneH) min 1.2)
#define SIZEY (SIZEX / 1.2)
#define W_PART(num) (num * (SIZEX / 40))
#define H_PART(num) (num * (SIZEY / 25))
#define X_PART(num) (W_PART(num) + (safeZoneX + (safeZoneW - SIZEX) / 2))
#define Y_PART(num) (H_PART(num) + (safeZoneY + (safeZoneH - SIZEY) / 2))

#define GAS_MANAGER_PFH_DELAY 1
