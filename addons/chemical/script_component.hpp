#define COMPONENT chemical
#define COMPONENT_BEAUTIFIED Chemical
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
#define RAD_MANAGER_PFH_DELAY 1

// Radiation body parts (matches ALL_BODY_PARTS index order used for per-limb dose)
#define RAD_BODY_PARTS ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"]

// Radiation types (canonical index order for per-type strength/rate arrays)
#define RAD_TYPES ["alpha", "beta", "gamma", "neutron"]
