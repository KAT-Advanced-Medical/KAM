#define COMPONENT hitpoints
#define COMPONENT_BEAUTIFIED KAT - Hitpoints
#include "\x\kat\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MAIN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MAIN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#endif

#include "\x\kat\addons\main\script_macros.hpp"

#undef HITPOINT_INDEX_BODY
#undef HITPOINT_INDEX_LARM
#undef HITPOINT_INDEX_RARM
#undef HITPOINT_INDEX_LLEG
#undef HITPOINT_INDEX_RLEG

#undef ALL_BODY_PARTS
#undef ALL_SELECTIONS
#undef ALL_HITPOINTS

#undef DEFAULT_TOURNIQUET_VALUES
#undef DEFAULT_FRACTURE_VALUES
#undef DEFAULT_BODYPART_DAMAGE_VALUES


#define ALL_BODY_PARTS ["head", "neck", "chest", "body", "leftarm", "upperleftarm", "rightarm", "upperrightarm", "leftleg", "upperleftleg", "rightleg", "upperrightleg"]
#define ALL_SELECTIONS ["head", "neck", "chest", "body", "hand_l", "uhand_l", "hand_r", "uhand_r", "leg_l", "uleg_l", "leg_r", "uleg_r"]
#define ALL_HITPOINTS ["HitHead", "HitNeck", "HitChest", "HitAbdomen", "HitLeftArm", "HitRightArm", "HitLeftLeg", "HitRightLeg"]


#define PRIORITY_NECK       3
#define PRIORITY_CHEST      4
#define HITPOINT_INDEX_NECK 1
#define HITPOINT_INDEX_CHEST 2
#define HITPOINT_INDEX_BODY 3
#define HITPOINT_INDEX_LARM 4
#define HITPOINT_INDEX_ULARM 5
#define HITPOINT_INDEX_RARM 6
#define HITPOINT_INDEX_URARM 7
#define HITPOINT_INDEX_LLEG 8
#define HITPOINT_INDEX_ULLEG 9
#define HITPOINT_INDEX_RLEG 10
#define HITPOINT_INDEX_URLEG 11

#define DEFAULT_TOURNIQUET_VALUES [0,0,0,0,0,0,0,0,0,0,0,0]
#define DEFAULT_FRACTURE_VALUES [0,0,0,0,0,0,0,0,0,0,0,0]
#define DEFAULT_BODYPART_DAMAGE_VALUES [0,0,0,0,0,0,0,0,0,0,0,0]