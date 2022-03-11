#include "script_component.hpp"

//Events
["kat_fnc_medicationLocal", {_this call kat_fnc_medicationLocal}] call CBA_fnc_addEventHandler;
["kat_fnc_gas", {_this call kat_fnc_gasCheck}] call CBA_fnc_addEventHandler;
["kat_fnc_gas_local", {_this spawn kat_fnc_gasCheckLocal}] call CBA_fnc_addEventHandler;
["kat_fnc_gas_ai", {_this spawn kat_fnc_gasAI}] call CBA_fnc_addEventHandler;


ppBlur_priority = 399;
[{
	ppBlur_priority = ppBlur_priority + 1;
	ppBlur = ppEffectCreate ["DynamicBlur", ppBlur_priority];
	ppBlur != -1
}, {
	ppBlur ppEffectEnable false;
	ppBlurAmount = 0;
	ppBluring = false;
}] call CBA_fnc_waitUntilAndExecute;