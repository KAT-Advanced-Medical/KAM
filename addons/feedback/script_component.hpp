#define COMPONENT feedback
#define COMPONENT_BEAUTIFIED KAT - Feedback
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_FEEDBACK
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_FEEDBACK
    #define DEBUG_SETTINGS DEBUG_SETTINGS_FEEDBACK
#endif

#include "\x\kat\addons\main\script_macros.hpp"

#define FX_OPIOD_FADE_IN   0.3
#define FX_OPIOD_FADE_OUT  0.7

#define FX_SPO2_FADE_IN   0.7
#define FX_SPO2_FADE_OUT  1.6

#define FX_COUGH_FADE_IN   0.3
#define FX_COUGH_FADE_OUT  0.7
