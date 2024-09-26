#define COMPONENT stretcher
#define COMPONENT_BEAUTIFIED KAT - STRETCHER
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_STRETCHER
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_STRETCHER
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MISC
#endif

#ifdef FAST_PROGRESSBARS
    #define TIME_PROGRESSBAR(X) ((X) * 0.075)
#else
    #define TIME_PROGRESSBAR(X) ((X) * ACEGVAR(csw,progressBarTimeCoefficent))
#endif


#include "\x\kat\addons\main\script_macros.hpp"