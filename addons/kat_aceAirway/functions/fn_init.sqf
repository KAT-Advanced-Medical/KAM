/*
 * Author: Katalam
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call kat_aceAirway_fnc_init
 *
 * Public: No
 */

params ["_unit"];

//ace_medical_airwayCollapsed
//ace_medical_airwayOccluded
_unit setVariable ["kat_aceAirway_airway", false];
_unit setVariable ["kat_aceAirway_airway_item", ""];
_unit setVariable ["kat_aceAirway_overstretch", false];

/*
["spine","spine1","spine2","spine3","head","leftshoulder","leftarm","leftarmroll","leftforearm","leftforearmroll","lefthand",
"rightshoulder","rightarm","rightarmroll","rightforearm","rightforearmroll","righthand","pelvis","leftupleg","leftuplegroll",
"leftleg","leftlegroll","leftfoot","lefttoebase","rightupleg","rightuplegroll","rightleg","rightlegroll","rightfoot","righttoebase",
"weapon","proxy:\a3\characters_f\proxies\weapon.001","proxy:\a3\characters_f\proxies\pistol.001","proxy:\a3\characters_f\proxies\binoculars.001",
"proxy:\a3\characters_f\proxies\launcher.001","launcher","nvg","proxy:\a3\characters_f\proxies\nvg.001","proxy:\a3\characters_f\proxies\flag.001",
"proxy:\a3\characters_f\proxies\equipment.001","proxy:\a3\characters_f\proxies\backpack.001","proxy:\a3\characters_f\proxies\pistol_holstered.001",
"proxy:\a3\characters_f\proxies\head_male.001","proxy:\a3\characters_f\proxies\glasses.001","proxy:\a3\characters_f\proxies\headgear.001",
"proxy:\a3\characters_f\proxies\hair.001","proxy:\a3\characters_f\proxies\backpack2.001","proxy:\a3\characters_f\proxies\radio.001","body_proxy",
"head_proxy","proxy:\a3\characters_f\heads\bysta.001","lefthandindex1","lefthandindex2","lefthandindex3","lefthandmiddle1","lefthandmiddle2","lefthandmiddle3",
"lefthandring","lefthandpinky1","lefthandpinky2","lefthandpinky3","lefthandring1","lefthandring2","lefthandring3","lefthandthumb1","lefthandthumb2",
"lefthandthumb3","righthandindex1","righthandindex2","righthandindex3","righthandmiddle1","righthandmiddle2","righthandmiddle3","righthandring",
"righthandpinky1","righthandpinky2","righthandpinky3","righthandring1","righthandring2","righthandring3","righthandthumb1","righthandthumb2",
"righthandthumb3","injury_body","hl","neck","proxy:\a3\characters_f\proxies\hmd.001","injury_hands","injury_legs","camo","camo2","insignia","clan"]
*/
