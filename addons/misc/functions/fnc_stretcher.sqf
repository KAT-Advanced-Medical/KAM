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
 * [cursorTarget] call KAM_misc_fnc_stretcher;
 *
 * Public: No
 */

(_this select 0) params ["_object"];

if !(_object isKindOf "KAM_stretcher") exitWith {false};

[_object] call ace_dragging_fnc_initObject;

[_object, 0, ["ACE_MainActions"],
    [QGVAR(disassemble), localize LSTRING(stretcher_disassemble), "", {
        params [["_object", objNull, [objNull]]];
        private _weaponHolder = createVehicle ["GroundWeaponHolder_Scripted", getPos _object, [], 0, "CAN_COLLIDE"];
        _weaponHolder addItemCargoGlobal ["KAM_stretcher", 1];
        deleteVehicle _object;
    }, {
        params [["_object", objNull, [objNull]]];
        !((count crew _object > 0) || !(isNull attachedTo _object))
    }] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[_object, 0, ["ACE_MainActions"],
    [QGVAR(attach), localize LSTRING(stretcher_attach), "", {}, {true}, {[_target] call FUNC(attachStretcher)}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

true
