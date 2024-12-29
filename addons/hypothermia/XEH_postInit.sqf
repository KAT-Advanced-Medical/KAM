#include "script_component.hpp"

[QGVAR(useHandWarmer), LINKFUNC(useHandWarmerLocal)] call CBA_fnc_addEventHandler;
[QGVAR(applyFluidWarmer), LINKFUNC(applyFluidWarmerLocal)] call CBA_fnc_addEventHandler;
[QGVAR(removeFluidWarmer), LINKFUNC(removeFluidWarmerLocal)] call CBA_fnc_addEventHandler;

[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;