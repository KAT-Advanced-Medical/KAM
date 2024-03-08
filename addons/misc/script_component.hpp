#define COMPONENT misc
#define COMPONENT_BEAUTIFIED KAT - MISC
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MISC
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MISC
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MISC
#endif

#include "\x\kat\addons\main\script_macros.hpp"

#define MEDICAL_TREATMENT_ITEMS (call (uiNamespace getVariable [QACEGVAR(medical_treatment,treatmentItems), {[]}]))

#define DAMAGED_MIN_THRESHOLD 0.45
#define LIMPING_MIN_DAMAGE 0.5