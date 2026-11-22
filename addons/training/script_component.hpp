#define COMPONENT training
#define COMPONENT_BEAUTIFIED Training
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_TRAINING
  #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_TRAINING
  #define DEBUG_SETTINGS DEBUG_SETTINGS_TRAINING
#endif

#include "\x\kat\addons\main\script_macros.hpp"

// Patient spots within this distance of a training computer belong to it
#define PATIENT_SPOT_RADIUS 25
