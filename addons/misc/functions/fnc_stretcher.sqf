#include "..\script_component.hpp"
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

params [["_object", objNull, [objNull]]];

if !(_object isKindOf "kat_stretcher") exitWith {false};

[_object] call ACEFUNC(dragging,initObject);

[_object, 0, ["ACE_MainActions"],
    [QGVAR(disassemble), LLSTRING(disassemble_stretcher_display), "", {
        params [["_object", objNull, [objNull]]];
        "kat_stretcherBag" createVehicle (getPos _object); // TODO create at exact position
        deleteVehicle _object;
    }, {
        params [["_object", objNull, [objNull]]];
        if ((count crew _object > 0) || !(isNull attachedTo _object)) exitWith {false};
        true;
    }] call ACEFUNC(interact_menu,createAction)
] call ACEFUNC(interact_menu,addActionToObject);

[_object, 0, ["ACE_MainActions"],
    [QGVAR(attach), LLSTRING(disassemble_attach_display), "", {}, {true}, {[_target] call FUNC(attachStretcher)}] call ACEFUNC(interact_menu,createAction)
] call ACEFUNC(interact_menu,addActionToObject);

true
