#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Initializes placed Module
 *
 * Arguments:
 * 0: Logic <MODULE>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [logic] call kat_chemical_fnc_initModule;
 *
 * Public: No
*/

params ["_logic"];

if (isServer) then {
    [{
        params ["_logic"];

        private _category = getText (configOf _logic >> "category");
        private _logicMain = missionNamespace getVariable ["bis_functions_mainscope", objNull];
        private _group = missionNamespace getVariable [format ["bis_fnc_initModules_%1", _category], group _logicMain];
        [_logic] joinSilent _group;
    }, _logic] call CBA_fnc_execNextFrame;
};

private _function = getText (configOf _logic >> "function");
if (_function isEqualTo "") exitWith {};


if (isNil _function) then {
    _function = compile _function;
} else {
    _function = missionNamespace getVariable _function;
};

[_function, _logic] call CBA_fnc_execNextFrame;
