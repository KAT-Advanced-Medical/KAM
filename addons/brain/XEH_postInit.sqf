#include "script_component.hpp"

[QGVAR(handleAutoregulation), LINKFUNC(handleAutoregulation)] call CBA_fnc_addEventHandler;
[QGVAR(handleBrainActivity), LINKFUNC(handleBrainActivity)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical,woundReceived),LINKFUNC(concussion)] call CBA_fnc_addEventHandler;

[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;
