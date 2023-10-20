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
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

if !(local _unit) exitwith {};
private _config = configFile >> "Cfgammo" >> _ammo;
if (getNumber (_config >> "KAT_csGas") != 1) exitwith {};

private _fuzetimeBase = getNumber (_config >> "explosionTime");
private _fuzetime = _fuzetimeBase + random[-0.8, 0, 1.2];
private _currentime = CBA_missiontime;

[
    {
        params ["_currentime", "_fuzetime"];
        (CBA_missiontime - _currentime) > _fuzetime
    },
    {
        params ["_currentime", "_fuzetime", "_projectile"];
        [_projectile] call FUNC(csGrenadethrownFuze);
    },
    [_currentime, _fuzetime, _projectile]
] call CBA_fnc_waitUntilandExecute;
