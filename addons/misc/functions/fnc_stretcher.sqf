#include "script_component.hpp"
/*
 * Author: Katalam
 * Init function for stretcher
 *
 * Arguments:
 * 0: Stretcher <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_misc_fnc_stretcher;
 *
 * Public: No
 */

(_this select 0) params ["_object"];

if !(_object isKindOf "kat_stretcher") exitWith {false};

[_object] call ace_dragging_fnc_initObject;

[_object, 0, ["ACE_MainActions"],
    [QGVAR(disassemble), localize LSTRING(disassemble_stretcher_display), "", {
        params [["_object", objNull, [objNull]]];
        "kat_stretcherBag" createVehicle (getPos _object); // TODO create at exact position
        deleteVehicle _object;
    }, {
        params [["_object", objNull, [objNull]]];
        if ((count crew _object > 0) || !(isNull attachedTo _object)) exitWith {false};
        true;
    }] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[_object, 0, ["ACE_MainActions"],
    [QGVAR(attach), localize LSTRING(disassemble_attach_display), "", {}, {true}, {[_target] call FUNC(attachStretcher)}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

true
