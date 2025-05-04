#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {
    private _sampleMap = createHashMap;
    missionNamespace setVariable [QGVAR(bloodSampleMap), _sampleMap];
    missionNamespace setVariable [QGVAR(sampleCounter), 0];
    
    private _resultSampleMap = createHashMap;
    missionNamespace setVariable [QGVAR(resultSampleMap), _resultSampleMap];
    missionNamespace setVariable [QGVAR(resultCounter), 0];
};

#define CBA_SETTINGS_CAT LSTRING(cba_name)
#include "initSettings.inc.sqf"

ADDON = true;