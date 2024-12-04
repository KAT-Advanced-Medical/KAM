#define COMPONENT vitals
#define COMPONENT_BEAUTIFIED KAT - Vitals
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_VITALS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_VITALS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_VITALS
#endif

#include "\x\kat\addons\main\script_macros.hpp"

#define POISON_DECREASE 1
