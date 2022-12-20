#include "script_component.hpp"

//Events
[QGVAR(gasCheck), {_this call FUNC(gasCheck)}] call CBA_fnc_addEventHandler;
[QGVAR(gasCheck_local), {_this call FUNC(gasCheckLocal)}] call CBA_fnc_addEventHandler;
[QGVAR(gasCheck_ai), {_this call FUNC(gasAI)}] call CBA_fnc_addEventHandler;

//Mortar Events
["Mortar_01_base_F", "fired", {call FUNC(handleFired)}] call CBA_fnc_addClassEventHandler;
KAT_ProjectileChache = ("([_x, 'KAT_porjectile', 0] call BIS_fnc_returnConfigEntry) != 0" configClasses (configFile >> "cfgAmmo")) apply {configName _x};
[] call FUNC(addLoadAction);

//Grenade Events
["ace_firedPlayer", {_this call FUNC(throwGrenade)}] call CBA_fnc_addEventHandler;
["ace_firedPlayerNonLocal", {_this call FUNC(throwGrenade)}] call CBA_fnc_addEventHandler;
["ace_firedNonPlayer", {_this call FUNC(throwGrenade)}] call CBA_fnc_addEventHandler;

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