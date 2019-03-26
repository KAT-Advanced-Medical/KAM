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
     ["kat_addIV_1", localize "STR_kat_aceMisc_Action_add_IV_Display", "", {[_target, _player, 1000] call kat_aceMisc_fnc_addIVbag}, {[_player, "ACE_salineIV"] call kat_aceMisc_fnc_conditionIVstand}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_empty_F", 0, ["ACE_MainActions"],
     ["kat_addIV_5", localize "STR_kat_aceMisc_Action_add_IV_Display_500", "", {[_target, _player, 500] call kat_aceMisc_fnc_addIVbag}, {[_player, "ACE_salineIV_500"] call kat_aceMisc_fnc_conditionIVstand}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_empty_F", 0, ["ACE_MainActions"],
     ["kat_addIV_2", localize "STR_kat_aceMisc_Action_add_IV_Display_250", "", {[_target, _player, 250] call kat_aceMisc_fnc_addIVbag}, {[_player, "ACE_salineIV_250"] call kat_aceMisc_fnc_conditionIVstand}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_1bag_F", 0, ["ACE_MainActions"],
     ["kat_addIV", localize "STR_kat_aceMisc_Action_add_IV_Display", "", {[_target, _player, 1000] call kat_aceMisc_fnc_addIVbag}, {[_player, "ACE_salineIV"] call kat_aceMisc_fnc_conditionIVstand}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_1bag_F", 0, ["ACE_MainActions"],
     ["kat_addIV_5", localize "STR_kat_aceMisc_Action_add_IV_Display_500", "", {[_target, _player, 500] call kat_aceMisc_fnc_addIVbag}, {[_player, "ACE_salineIV_500"] call kat_aceMisc_fnc_conditionIVstand}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_1bag_F", 0, ["ACE_MainActions"],
     ["kat_addIV_2", localize "STR_kat_aceMisc_Action_add_IV_Display_250", "", {[_target, _player, 250] call kat_aceMisc_fnc_addIVbag}, {[_player, "ACE_salineIV_250"] call kat_aceMisc_fnc_conditionIVstand}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;
