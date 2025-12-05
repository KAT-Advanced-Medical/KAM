#include "script_component.hpp"

[QGVAR(handleAutoregulation), LINKFUNC(handleAutoregulation)] call CBA_fnc_addEventHandler;
[QGVAR(handleBrainActivity), LINKFUNC(handleBrainActivity)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical,woundReceived),LINKFUNC(concussion)] call CBA_fnc_addEventHandler;

[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;

GVAR(concussionRinging) = 0;
GVAR(concussionRingingPrior) = 0;
["CBA_settingsInitialized", {
    [LINKFUNC(handleEarRinging), 1, false] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;