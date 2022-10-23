#include "script_component.hpp"

["treatmentFractureSelect", {_this call FUNC(fractureSelectLocal)}] call CBA_fnc_addEventHandler;
["treatmentClosedFracture", {_this call FUNC(closedFractureLocal)}] call CBA_fnc_addEventHandler;
["treatmentOpenFracture", {_this call FUNC(openFractureLocal)}] call CBA_fnc_addEventHandler;
["treatmentOpenFractureIncision", {_this call FUNC(openFractureIncisionLocal)}] call CBA_fnc_addEventHandler;
["treatmentOpenFractureProgress", {_this call FUNC(openFractureProgressLocal)}] call CBA_fnc_addEventHandler;
["treatmentDebridementClear", {_this call FUNC(debridementClearLocal)}] call CBA_fnc_addEventHandler;
["treatmentDebridementMinor", {_this call FUNC(debridementMinorLocal)}] call CBA_fnc_addEventHandler;