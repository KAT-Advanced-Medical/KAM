/*
 * Author: Katalam
 * Handle the X Series Defi for the patient.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_aceCirculation_fnc_interactionX;
 *
 * Public: No
 */

params ["_player", "_target"];

// name, shown name, icon, statement, condition, insert children, arguments, position

// _player getVariable ["kat_aceCirculation_use", false];

[_target, 0, [],
	["KAT_X_codeParent0", "0", "", {}, {true}, {}, [], [0, 0.2, 1.5]] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[_target, 0, ["KAT_X_codeParent0"],
	["KAT_X_codeAction0", "0", "", {true}, {true}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[_target, 0, [],
	["KAT_X_codeParent1", "1", "", {}, {true}, {}, [], [-0.1, 0.2, 1.3]] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[_target, 0, ["KAT_X_codeParent1"],
	["KAT_X_codeAction1", "1", "", {true}, {true}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[_target, 0, [],
	["KAT_X_codeParent2", "2", "", {}, {true}, {}, [], [-0.15, 0.2, 1.3]] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;

[_target, 0, ["KAT_X_codeParent2"],
	["KAT_X_codeAction2", "2", "", {true}, {true}] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToObject;



private _cargo1 = defi;
private _cargo2 = abcd;
private _helper1 = "B_G_Boat_Transport_01_F" createVehicle position _cargo2;
_cargo1 enableRopeAttach true;
_helper1 attachTo [_cargo2, [0, 0.2, 1.5]];
ropeCreate [_helper1, [0,-0.2,0], _cargo1, [0,0,0]];

private _helper3 = "B_G_Boat_Transport_01_F" createVehicle position _cargo2;
_helper3 attachTo [_cargo2, [-0.1, 0.2, 1.3]];
ropeCreate [_helper3, [0,-0.2,0], _cargo1, [0,0,0]];

private _helper4 = "B_G_Boat_Transport_01_F" createVehicle position _cargo2;
_helper4 attachTo [_cargo2, [-0.15, 0.2, 1.3]];
ropeCreate [_helper4, [0,-0.2,0], _cargo1, [0,0,0]];

hideObject _helper1;
hideObject _helper3;
hideObject _helper4;
[_helper1] remoteExec ["hideObjectGlobal", [0, 2] select isDedicated];
[_helper3] remoteExec ["hideObjectGlobal", [0, 2] select isDedicated];
[_helper4] remoteExec ["hideObjectGlobal", [0, 2] select isDedicated];

//[_helper2, [0,0,0], [0,0,-1]] ropeAttachTo _rope;

/*
["spine","spine1","spine2","spine3","head","leftshoulder","leftarm","leftarmroll","leftforearm","leftforearmroll","lefthand","rightshoulder","rightarm","rightarmroll",
"rightforearm","rightforearmroll","righthand","pelvis","leftupleg","leftuplegroll","leftleg","leftlegroll","leftfoot","lefttoebase","rightupleg","rightuplegroll","rightleg",
"rightlegroll","rightfoot","righttoebase","weapon","proxy:\a3\characters_f\proxies\weapon.001","proxy:\a3\characters_f\proxies\pistol.001",
"proxy:\a3\characters_f\proxies\binoculars.001","proxy:\a3\characters_f\proxies\launcher.001","launcher","nvg","proxy:\a3\characters_f\proxies\nvg.001",
"proxy:\a3\characters_f\proxies\flag.001","proxy:\a3\characters_f\proxies\equipment.001","proxy:\a3\characters_f\proxies\backpack.001",
"proxy:\a3\characters_f\proxies\pistol_holstered.001","proxy:\a3\characters_f\proxies\head_male.001","proxy:\a3\characters_f\proxies\glasses.001",
"proxy:\a3\characters_f\proxies\headgear.001","proxy:\a3\characters_f\proxies\hair.001","proxy:\a3\characters_f\proxies\backpack2.001",
"proxy:\a3\characters_f\proxies\radio.001","body_proxy","head_proxy","proxy:\a3\characters_f\heads\bysta.001","lefthandindex1","lefthandindex2",
"lefthandindex3","lefthandmiddle1","lefthandmiddle2","lefthandmiddle3","lefthandring","lefthandpinky1","lefthandpinky2","lefthandpinky3","lefthandring1",
"lefthandring2","lefthandring3","lefthandthumb1","lefthandthumb2","lefthandthumb3","righthandindex1","righthandindex2","righthandindex3","righthandmiddle1",
"righthandmiddle2","righthandmiddle3","righthandring","righthandpinky1","righthandpinky2","righthandpinky3","righthandring1","righthandring2","righthandring3",
"righthandthumb1","righthandthumb2","righthandthumb3","injury_body","hl","neck","proxy:\a3\characters_f\proxies\hmd.001","injury_hands","injury_legs","camo",
"camo2","insignia","clan"] */
