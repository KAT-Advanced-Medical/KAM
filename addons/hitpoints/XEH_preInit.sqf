#include "script_component.hpp"

ADDON = false;
ACEGVAR(medical_engine,customHitpoints) = ["hitleftarm", "hitrightarm", "hitupperleftarm", "hitupperrightarm", "hitupperrollleftarm", "hitupperrollrightarm", "hitleftleg", "hitrightleg", "hitupperleftleg", "hitupperrightleg", "hitleftlegroll", "hitrightlegroll", "hitleftfoot", "hitrightfoot"];
PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT LSTRING(cba_name)
#include "initSettings.inc.sqf"

ADDON = true;
