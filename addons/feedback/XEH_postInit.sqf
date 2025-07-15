#include "script_component.hpp"

[false] call FUNC(initEffects);
[true] call FUNC(handleEffects);
[LINKFUNC(handleEffects), 1, false] call CBA_fnc_addPerFrameHandler;

// Update effects for featureCamera (curator, arsenal, etc)
["featureCamera", {
    params ["_unit", "_newCamera"];

    [true] call FUNC(handleEffects);
}] call CBA_fnc_addPlayerEventHandler;
