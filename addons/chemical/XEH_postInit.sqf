#include "script_component.hpp"

//Events
[QGVAR(gasCheck), LINKFUNC(gasCheck)] call CBA_fnc_addEventHandler;
[QGVAR(gasCheck_local), LINKFUNC(gasCheckLocal)] call CBA_fnc_addEventHandler;
[QGVAR(gasCheck_ai), LINKFUNC(gasAI)] call CBA_fnc_addEventHandler;
[QGVAR(afterWait), LINKFUNC(afterWait)] call CBA_fnc_addEventHandler;
[QGVAR(enteredPoisonEvent), LINKFUNC(chemDetector)] call CBA_fnc_addEventHandler;

//Mortar Events
["Mortar_01_base_F", "fired", {call FUNC(handleFired)}] call CBA_fnc_addClassEventHandler;
KAT_ProjectileCache = ("([_x, 'KAT_projectile', 0] call BIS_fnc_returnConfigEntry) != 0" configClasses (configFile >> "cfgAmmo")) apply {configName _x};
[] call FUNC(addLoadAction);

//Grenade Events
["ace_firedPlayer", LINKFUNC(throwGrenade)] call CBA_fnc_addEventHandler;
["ace_firedPlayerNonLocal", LINKFUNC(throwGrenade)] call CBA_fnc_addEventHandler;
["ace_firedNonPlayer", LINKFUNC(throwGrenade)] call CBA_fnc_addEventHandler;

if (hasInterface) then {
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
};

private _items = missionNamespace getVariable [QGVAR(availGasmask), "'G_AirPurifyingRespirator_01_F'"];
private _array = [_items, "CfgGlasses"] call FUNC(getList);
missionNamespace setVariable [QGVAR(availGasmaskList), _array, true];