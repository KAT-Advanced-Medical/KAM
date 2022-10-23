#define COMPONENT surgery
#define COMPONENT_BEAUTIFIED KAT - Surgery
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_SURGERY
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_SURGERY
    #define DEBUG_SETTINGS DEBUG_SETTINGS_SURGERY
#endif

#include "\x\kat\addons\main\script_macros.hpp"
#include "\z\ace\addons\medical_engine\script_macros_medical.hpp"

// Returns a text config entry as compiled code or variable from missionNamespace
#define GET_FUNCTION(var,cfg) \
    private var = getText (cfg); \
    if (isNil var) then { \
        var = compile var; \
    } else { \
        var = missionNamespace getVariable var; \
    }

// Returns a number config entry with default value of 0
// If entry is a string, will get the variable from missionNamespace
#define GET_NUMBER_ENTRY(cfg) \
    if (isText (cfg)) then { \
        missionNamespace getVariable [getText (cfg), 0]; \
    } else { \
        getNumber (cfg); \
    }
