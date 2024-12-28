#include "script_component.hpp"

if (!hasInterface) exitWith {};

call FUNC(initKeybinds);

["CBA_settingsInitialized", {
    //If not enabled, dont't add
    if (!GVAR(enable)) exitWith {};

    GVAR(ppBlurBlink) = ppEffectCreate ["DynamicBlur", 213706];

    [QACEGVAR(goggles,effect), LINKFUNC(handleDustInjury)] call CBA_fnc_addEventHandler;

    //Add Explosion XEH
    ["CAManBase", "explosion", LINKFUNC(handleExplosion)] call CBA_fnc_addClassEventHandler;

}] call CBA_fnc_addEventHandler;


[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;
[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;


