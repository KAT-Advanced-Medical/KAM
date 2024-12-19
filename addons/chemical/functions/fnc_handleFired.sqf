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

// Large enough distance to not simulate any wind deflection
if (_vehicle distance ACE_player > 8000) exitWith {};

if !(_ammo in KAT_ProjectileCache) exitWith {};

private _configClass = (configFile >> "CfgAmmo" >> _ammo);

private _lifetime = [_configClass, "KAT_lifetime", 60] call BIS_fnc_returnConfigEntry;
private _radius = [_configClass, "KAT_radius", 10] call BIS_fnc_returnConfigEntry;
private _gasLevel = [_configClass, "KAT_toxicLvL", 1] call BIS_fnc_returnConfigEntry;

[{
    params ["_args", "_handler"];
    _args params ["_projectile", "_gasInfo"];
    _gasInfo params ["_lifetime", "_radius", "_gasLeveL"];

    if (isNull _projectile || {!alive _projectile}) exitWith {
        [_handler] call CBA_fnc_removePerFrameHandler;
    };

    [QGVAR(addGasSource), [_projectile, _radius, _gasLevel, _projectile, {
        params ["_endTime"];

        CBA_missionTime < _endTime // return
    }, [CBA_missionTime + _lifetime]]] call CBA_fnc_serverEvent;

}, 0, [_projectile, [_lifetime, _radius, _gasLevel]]] call CBA_fnc_addPerFrameHandler;
