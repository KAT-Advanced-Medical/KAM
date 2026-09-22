#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Blood sample / result slots are server-authoritative (see fnc_serverDrawSample,
// fnc_serverTestSample, fnc_serverApplyResult); every machine still needs a local,
// always-HashMap-typed copy to build the vehicle/patient interact menus without a
// network round trip, so both maps are kept public from the moment they're created.
if (isServer) then {
    missionNamespace setVariable [QGVAR(bloodSampleMap), createHashMap, true];
    missionNamespace setVariable [QGVAR(resultSampleMap), createHashMap, true];
};

#define CBA_SETTINGS_CAT LSTRING(cba_name)
#include "initSettings.inc.sqf"

ADDON = true;
