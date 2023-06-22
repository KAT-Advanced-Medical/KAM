#include "script_component.hpp"

["Land_IntravenStand_01_empty_F", 0, ["ACE_MainActions"],
    [QGVAR(addIV_1), LLSTRING(Action_add_IV_Display), "", {[_target, _player, 1000] call FUNC(addIVbag)}, {[_player, "ACE_salineIV"] call FUNC(conditionIVstand)}] call ACEFUNC(interact_menu,createAction)
] call ACEFUNC(interact_menu,addActionToClass);

["Land_IntravenStand_01_empty_F", 0, ["ACE_MainActions"],
    [QGVAR(addIV_5), LLSTRING(Action_add_IV_Display_500), "", {[_target, _player, 500] call FUNC(addIVbag)}, {[_player, "ACE_salineIV_500"] call FUNC(conditionIVstand)}] call ACEFUNC(interact_menu,createAction)
] call ACEFUNC(interact_menu,addActionToClass);

["Land_IntravenStand_01_empty_F", 0, ["ACE_MainActions"],
    [QGVAR(addIV_2), LLSTRING(Action_add_IV_Display_250), "", {[_target, _player, 250] call FUNC(addIVbag)}, {[_player, "ACE_salineIV_250"] call FUNC(conditionIVstand)}] call ACEFUNC(interact_menu,createAction)
] call ACEFUNC(interact_menu,addActionToClass);

["Land_IntravenStand_01_1bag_F", 0, ["ACE_MainActions"],
    [QGVAR(addIV), LLSTRING(Action_add_IV_Display), "", {[_target, _player, 1000] call FUNC(addIVbag)}, {[_player, "ACE_salineIV"] call FUNC(conditionIVstand)}] call ACEFUNC(interact_menu,createAction)
] call ACEFUNC(interact_menu,addActionToClass);

["Land_IntravenStand_01_1bag_F", 0, ["ACE_MainActions"],
    [QGVAR(addIV_5), LLSTRING(Action_add_IV_Display_500), "", {[_target, _player, 500] call FUNC(addIVbag)}, {[_player, "ACE_salineIV_500"] call FUNC(conditionIVstand)}] call ACEFUNC(interact_menu,createAction)
] call ACEFUNC(interact_menu,addActionToClass);

["Land_IntravenStand_01_1bag_F", 0, ["ACE_MainActions"],
    [QGVAR(addIV_2), LLSTRING(Action_add_IV_Display_250), "", {[_target, _player, 250] call FUNC(addIVbag)}, {[_player, "ACE_salineIV_250"] call FUNC(conditionIVstand)}] call ACEFUNC(interact_menu,createAction)
] call ACEFUNC(interact_menu,addActionToClass);

["Attachable_Helistretcher", ["CONTAINER","CLOTHES"], [LLSTRING(helistretcher_attach)], [], "", [{true},{params ["_unit", "_container", "_item", "_slot", "_params"];_unit == vehicle _unit}], {
    params ["_unit", "_container", "_item", "_slot", "_params"];
    [_unit,_item] call kat_misc_fnc_heliStretcherAttach;
},true] call CBA_fnc_addItemContextMenuOption;

if (GVAR(incompatibilityWarning)) then {
    call FUNC(incompatibilityWarning);
};

[QGVAR(headTourniquetLocal), LINKFUNC(headTourniquetLocal)] call CBA_fnc_addEventHandler;

["kat_Armband_Red_Cross_Item", "kat_armband_red_cross"] call ACEFUNC(common,registerItemReplacement);
["kat_Armband_Medic_Item", "kat_armband_medic"] call ACEFUNC(common,registerItemReplacement);
["kat_Armband_Doctor_Item", "kat_armband_doctor"] call ACEFUNC(common,registerItemReplacement);
["kat_Armband_Kat_Item", "kat_armband_kat"] call ACEFUNC(common,registerItemReplacement);