#include "..\script_component.hpp"
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
* Cant be called manualy.
*
* Public: No
*/

//IGNORE_PRIVATE_WARNING ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle", "_gunner", "_turret"];

private _config = configFile >> "CfgAmmo" >> _ammo;

if (getNumber (_config >> "KAT_csGas") != 1) exitWith {};

private _timeToLive = getNumber (_config >> "timeToLive");
private _fuzeTimeBase = getNumber (_config >> "explosionTime");
private _fuzeTime = _fuzeTimeBase + random [-0.8, 0, 1.2];
private _currentime = CBA_missiontime;

[FUNC(csGrenade), [_projectile, _timeToLive, side _unit], _fuzeTime] call CBA_fnc_waitAndExecute; // WE WANT THE OBJECTS SIDE HERE!
