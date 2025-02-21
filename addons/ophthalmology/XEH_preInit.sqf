#include "script_component.hpp"
#include "initKeybinds.inc.sqf"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT LSTRING(cba_name)

#include "initKeybinds.inc.sqf"
#include "initSettings.inc.sqf"

ADDON = true;