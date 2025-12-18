#include "script_component.hpp"

[QGVAR(handleAutoregulation), LINKFUNC(handleAutoregulation)] call CBA_fnc_addEventHandler;
[QGVAR(handleBrainActivity), LINKFUNC(handleBrainActivity)] call CBA_fnc_addEventHandler;

[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;
[QGVAR(icpAssessment), LINKFUNC(icpAssessmentLocal)] call CBA_fnc_addEventHandler;

GVAR(concussionRinging) = 0;
GVAR(concussionRingingPrior) = 0;
["CBA_settingsInitialized", {
    [LINKFUNC(handleEarRinging), 1, false] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;

["multiplier", {
    if (ACE_player getVariable [QGVAR(concussion), 0] > 0) then {
        1 max (1 + ((ACE_player getVariable [QGVAR(concussion), 0]) * 2))
    } else {1};
}, QUOTE(ADDON)] call ACEFUNC(common,addSwayFactor);