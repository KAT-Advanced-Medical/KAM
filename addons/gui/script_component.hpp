#define COMPONENT gui
#define COMPONENT_BEAUTIFIED GUI
#include "\x\kat\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_GUI
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_GUI
    #define DEBUG_SETTINGS DEBUG_SETTINGS_GUI
#endif

#include "\x\kat\addons\main\script_macros.hpp"

#undef MED_LOG_VARNAME
#define MED_LOG_VARNAME(type) (format ["ace_medical_log_%1", type])

#include "gui_defines.hpp"
