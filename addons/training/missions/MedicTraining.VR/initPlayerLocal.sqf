#include "script_component.hpp"

#define WELCOME_DELAY 5

[{
    [LLSTRING(Tutorial_Welcome_Title), LLSTRING(Tutorial_Welcome_Text)] call FUNC(showTutorialHint);
}, [], WELCOME_DELAY] call CBA_fnc_waitAndExecute;
