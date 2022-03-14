#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * 
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_throwGrenade;
 *
 * Public: No
*/
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];


private _config = configFile >> "CfgAmmo" >> _ammo;
if(getNumber (_config >> "KAT_csGas") != 1) exitWith {};
if!(local _unit) exitWith {};


private _fuzeTimeBase = getNumber (_config >> "explosionTime");

private _fuzeTime = _fuzeTimeBase + random[-0.8,0,1.2];
private _currenTime = CBA_missionTime;
waitUntil{(CBA_missionTime - _currenTime) > _fuzeTime};
[_projectile] call FUNC(csGrenadeThrownFuze);

