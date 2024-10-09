#include "script_component.hpp"

if (!hasInterface) exitWith {};

call FUNC(initKeybinds);


["CBA_settingsInitialized", {
    if (!GVAR(enable) && !GVAR(enableManualBlinking)) exitWith {};

    GVAR(ppEffectPriority) = 341;

    // dust injury
    [{
        GVAR(ppEffectPriority) = GVAR(ppEffectPriority) + 1;
        GVAR(ppBlurDustInjury) = ppEffectCreate ["DynamicBlur", GVAR(ppEffectPriority)];
        GVAR(ppBlurDustInjury) != -1
    }, {
        GVAR(ppBlurDustInjury) ppEffectEnable false;
    }] call CBA_fnc_waitUntilAndExecute;

    // blink effect
    GVAR(ppEffectPriority) = 1111;
    [{
        GVAR(ppEffectPriority) = GVAR(ppEffectPriority) + 1;
        GVAR(ppBlurBlink) = ppEffectCreate ["DynamicBlur", GVAR(ppEffectPriority)];
        GVAR(ppBlurBlink) != -1
    }, {
        GVAR(ppBlurBlink) ppEffectEnable false;
    }] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;

[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;
[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;

//placeholder event for testing, needs implementation in ace
[QACEGVAR(goggles,eyeInjury), LINKFUNC(handleDustInjury)] call CBA_fnc_addEventHandler;
