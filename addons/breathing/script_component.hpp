#define COMPONENT breathing
#define COMPONENT_BEAUTIFIED KAT - Breathing
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_BREATHING
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_BREATHING
    #define DEBUG_SETTINGS DEBUG_SETTINGS_BREATHING
#endif

#include "\x\kat\addons\main\script_macros.hpp"
#include "\z\ace\addons\medical_engine\script_macros_medical.hpp"

#define VAR_BLOODPRESSURE_CHANGE QEGVAR(circulation,BPChange)
#define GET_BLOODPRESSURE_CHANGE(unit) (unit getVariable [VAR_BLOODPRESSURE_CHANGE, [0,0]])