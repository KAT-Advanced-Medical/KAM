#define COMPONENT medical_ai
#define COMPONENT_BEAUTIFIED Medical AI
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_ENABLED_MEDICAL_AI
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MEDICAL_AI
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MEDICAL_AI
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MEDICAL_AI
#endif

#include "\x\kat\addons\medical_engine\script_macros_medical.hpp"
#include "\x\kat\addons\main\script_macros.hpp"
