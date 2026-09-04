#include "..\script_component.hpp"
/*
* Author: DiGii
*
* Arguments:
* 0: Object <Object>
* 1: None
* 2: None
* 3: None
* 4: ammo <Cfgammo>
* 5: Magazine <CfgMagazine>
* 6: Projectile <Cfgammo>
*
* Return Value:
* NONE
*
* Example:
* [player, "", "", "", ammo, magazine, projectile] call kat_chemical_fnc_handlefired;
*
* Public: No
*
* See handlefires Eventhandler in BI-WIKI
*/

params ["_vehicle", "", "", "", "_ammo", "_magazine", "_projectile"];

if !(_ammo in KAT_ProjectileCache) exitWith {};

private _configClass = (configFile >> "CfgAmmo" >> _ammo);

private _lifetime = [_configClass, "KAT_lifetime", 60] call BIS_fnc_returnConfigEntry;
private _radius = [_configClass, "KAT_radius", 10] call BIS_fnc_returnConfigEntry;
private _gasLevel = [_configClass, "KAT_toxicLvL", 1] call BIS_fnc_returnConfigEntry;

// VX is persistent
if (_gasLevel == 5) then {
    _lifetime = missionNamespace getVariable [QGVAR(vx_cloudLifetime), _lifetime];
};

// Track the round until it detonates, then register the cloud once at the impact point.
[{
    params ["_args", "_handler"];
    _args params ["_projectile", "_gasInfo", "_impactPos", "_key"];

    if (!isNull _projectile && {alive _projectile}) exitWith {
        _args set [2, getPosASL _projectile];
    };

    [_handler] call CBA_fnc_removePerFrameHandler;

    _gasInfo params ["_lifetime", "_radius", "_gasLevel"];

    [QGVAR(addGasSource), [_impactPos, _radius, _gasLevel, _key, {
        params ["_endTime"];

        CBA_missionTime < _endTime // return
    }, [CBA_missionTime + _lifetime]]] call CBA_fnc_serverEvent;

}, 0, [
    _projectile,
    [_lifetime, _radius, _gasLevel],
    getPosASL _projectile,
    format ["%1_%2_%3", QGVAR(gasRound), _projectile, CBA_missionTime] // built while the round still exists, so every round gets its own cloud instead of evicting the previous one
]] call CBA_fnc_addPerFrameHandler;
