#include "script_component.hpp"

[QGVAR(handleTime), LINKFUNC(handleTime)] call CBA_fnc_addEventHandler;

call FUNC(initKeybinds);

GVAR(ppEffectPrioriry) = 399;
[{
    GVAR(ppEffectPrioriry) = GVAR(ppEffectPrioriry) + 1;
    GVAR(ppBlur) = ppEffectCreate ["DynamicBlur", GVAR(ppEffectPrioriry)];
    GVAR(ppBlur) != -1
}, {
    GVAR(ppBlur) ppEffectEnable false;
}] call CBA_fnc_waitUntilAndExecute;
