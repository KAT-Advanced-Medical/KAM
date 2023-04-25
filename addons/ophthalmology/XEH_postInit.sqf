#include "script_component.hpp"

[QGVAR(handleTime), LINKFUNC(handleTime)] call CBA_fnc_addEventHandler;

call FUNC(initKeybinds);

// blur effect if not blinked
GVAR(ppEffectPriority) = 341;
[{
    GVAR(ppEffectPriority) = GVAR(ppEffectPriority) + 1;
    GVAR(ppBlur) = ppEffectCreate ["DynamicBlur", GVAR(ppEffectPriority)];
    GVAR(ppBlur) != -1
}, {
    GVAR(ppBlur) ppEffectEnable false;
}] call CBA_fnc_waitUntilAndExecute;

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

["KAT_EyewasherItem", "KAT_Eyewasher"] call ACEFUNC(common,registerItemReplacement);
