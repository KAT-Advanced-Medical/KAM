#define COMPONENT circulation
#define COMPONENT_BEAUTIFIED Circulation
#include "\x\kat\addons\main\script_mod.hpp"
#include "\x\kat\addons\gui\gui_defines.hpp"

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

// Number of pre-defined KAT_bloodSample_N / KAT_bloodResult_N item classes in CfgWeapons.hpp
// (Arma can't create config classes at runtime, so the sample/result slot pools are capped at this)
#define MAX_SAMPLE_SLOTS 20
