/*
 * Author: Katalam
 * CBA Events function
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceMisc_fnc_events;
 *
 * Public: No
 */

//["", {_this call kat_aceMisc_fnc_}] call CBA_fnc_addEventHandler;


["Land_IntravenStand_01_empty_F", 0, ["ACE_MainActions"],
 	["kat_addIV", localize "STR_kat_aceMisc_Action_add_IV_Display", "", {[_target, _player] call kat_aceMisc_fnc_addIVbag}, {[_player] call kat_aceMisc_fnc_conditionIVstand}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_1bag_F", 0, ["ACE_MainActions"],
 	["kat_addIV", localize "STR_kat_aceMisc_Action_add_IV_Display", "", {[_target, _player] call kat_aceMisc_fnc_addIVbag}, {[_player] call kat_aceMisc_fnc_conditionIVstand}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;
