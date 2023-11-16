#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Children action for attaching stretcher
 *
 * Arguments:
 * 0: Stretcher <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_misc_fnc_attachStretcher;
 *
 * Public: No
 */

params [["_target", objNull, [objNull]]];

if !(isNull attachedTo _target) exitWith {};
private _vehicles = nearestObjects [_target, ["Car", "Helicopter"], 20];
private _actions = [];

{
    private _type = typeOf _x;
    private _name = getText (configFile >> "CfgVehicles" >> _type >> "displayName");
    private _uniqueName = format ["kat_misc_%1", _type];
    if (isArray (configFile >> "CfgVehicles" >> _type >> "stretcherPos")) then {
        _actions pushBack [
            [
                _uniqueName,
                _name,
                "",
                {
                    params ["_target", "", "_parameter"];
                    private _pos = getArray (configFile >> "CfgVehicles" >> typeOf (_parameter select 0) >> "stretcherPos");
                    private _vector = getArray (configFile >> "CfgVehicles" >> typeOf (_parameter select 0) >> "stretcherVector");
                    _target attachTo [(_parameter select 0), _pos];
                    _target setVectorDirAndUp _vector;
                },
                {true},
                {},
                [_x]
            ] call ACEFUNC(interact_menu,createAction),
            [],
            _target
        ];
        true;
    } else {
        false;
    };
} count _vehicles;

_actions;
