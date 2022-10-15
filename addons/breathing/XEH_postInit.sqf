#include "script_component.hpp"

[QGVAR(pulseoxLocal), LINKFUNC(treatmentAdvanced_pulseoximeterLocal)] call CBA_fnc_addEventHandler;
["treatmentChestSeal", {_this call FUNC(treatmentAdvanced_chestSealLocal)}] call CBA_fnc_addEventHandler;
["handleBreathing", {_this call FUNC(handleBreathing)}] call CBA_fnc_addEventHandler;
["treatmentHemopneumothorax", {_this call FUNC(treatmentAdvanced_hemopneumothoraxLocal)}] call CBA_fnc_addEventHandler;
["treatmentTensionpneumothorax", {_this call FUNC(treatmentAdvanced_tensionpneumothoraxLocal)}] call CBA_fnc_addEventHandler;
[QGVAR(cyanosisLocal), LINKFUNC(treatmentAdvanced_CyanosisLocal)] call CBA_fnc_addEventHandler;

["ace_medical_woundReceived",{_this call FUNC(handlePulmoHit);}] call CBA_fnc_addEventHandler;

