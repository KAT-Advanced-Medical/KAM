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
#include "\z\ace\addons\medical_engine\script_macros_medical.hpp"

#define DEFAULT_TOURNIQUET_VALUES   [0,0,0,0,0,0]
#define VAR_TOURNIQUET              "ACE_medical_tourniquets"
#define GET_TOURNIQUETS(unit)       (unit getVariable [VAR_TOURNIQUET, DEFAULT_TOURNIQUET_VALUES])
#define HAS_TOURNIQUET_APPLIED_ON(unit,index) ((GET_TOURNIQUETS(unit) select index) > 0)
