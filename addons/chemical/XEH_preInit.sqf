#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT LSTRING(cba_name)
#include "initSettings.inc.sqf"

call FUNC(initGasRegistry);
call FUNC(initRadProfiles);

// Vehicle class / turret -> closed, filled lazily by FUNC(isRadSheltered)
GVAR(radSealedCache) = createHashMap;

ADDON = true;
