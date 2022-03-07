#include "script_component.hpp"

["Land_IntravenStand_01_empty_F", 0, ["ACE_MainActions"],
     [QGVAR(addIV_1), localize LSTRING(Action_add_IV_Display), "", {[_target, _player, 1000] call FUNC(addIVbag)}, {[_player, "ACE_salineIV"] call FUNC(conditionIVstand)}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_empty_F", 0, ["ACE_MainActions"],
     [QGVAR(addIV_5), localize LSTRING(Action_add_IV_Display_500), "", {[_target, _player, 500] call FUNC(addIVbag)}, {[_player, "ACE_salineIV_500"] call FUNC(conditionIVstand)}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_empty_F", 0, ["ACE_MainActions"],
     [QGVAR(addIV_2), localize LSTRING(Action_add_IV_Display_250), "", {[_target, _player, 250] call FUNC(addIVbag)}, {[_player, "ACE_salineIV_250"] call FUNC(conditionIVstand)}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_1bag_F", 0, ["ACE_MainActions"],
     [QGVAR(addIV), localize LSTRING(Action_add_IV_Display), "", {[_target, _player, 1000] call FUNC(addIVbag)}, {[_player, "ACE_salineIV"] call FUNC(conditionIVstand)}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_1bag_F", 0, ["ACE_MainActions"],
     [QGVAR(addIV_5), localize LSTRING(Action_add_IV_Display_500), "", {[_target, _player, 500] call FUNC(addIVbag)}, {[_player, "ACE_salineIV_500"] call FUNC(conditionIVstand)}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;

["Land_IntravenStand_01_1bag_F", 0, ["ACE_MainActions"],
     [QGVAR(addIV_2), localize LSTRING(Action_add_IV_Display_250), "", {[_target, _player, 250] call FUNC(addIVbag)}, {[_player, "ACE_salineIV_250"] call FUNC(conditionIVstand)}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;
