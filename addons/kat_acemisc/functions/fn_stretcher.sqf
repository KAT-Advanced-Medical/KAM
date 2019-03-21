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
 * [cursorTarget] call kat_aceMisc_fnc_stretcher;
 *
 * Public: No
 */

params [["_object", objNull, [objNull]]];

if !(_object isKindOf "kat_stretcher") exitWith {false};

[_object] call ace_dragging_fnc_initObject;

[_object, 0, ["ACE_MainActions"],
	["kat_aceMisc_disassemble", localize "STR_kat_aceMisc_disassemble_stretcher_display", "", {
		params [["_object", objNull, [objNull]]];
		"kat_stretcher_bag" createVehicle (getPos _object);
		deleteVehicle _object;
	}, {
		params [["_object", objNull, [objNull]]];
		if ((count crew _object > 0) || !(isNull attachedTo _object)) exitWith {false};
		true;
	}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[_object, 0, ["ACE_MainActions"],
	["kat_aceMisc_attach", localize "STR_kat_aceMisc_disassemble_attach_display", "", {}, {true}, {[_target] call kat_aceMisc_fnc_attachStretcher}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;


true
