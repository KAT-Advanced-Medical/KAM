#include "script_component.hpp"

["treatmentPulseoximeter", {_this call FUNC(treatmentAdvanced_pulseoximeterLocal)}] call CBA_fnc_addEventHandler;
["treatmentChestSeal", {_this call FUNC(treatmentAdvanced_chestSealLocal)}] call CBA_fnc_addEventHandler;
["handleBreathing", {_this call FUNC(handleBreathing)}] call CBA_fnc_addEventHandler;
