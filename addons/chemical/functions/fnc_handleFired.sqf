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
if (_vehicle distance ACE_player > 8000) exitwith {
    false
};

if !(_ammo in KAT_ProjectileCache) exitwith {};

private _configClass = (configFile >> "CfgAmmo" >> _ammo);

private _lifetime = [_configClass, "KAT_lifetime", 60] call BIS_fnc_returnConfigEntry;
private _radius = [_configClass, "KAT_radius", 10] call BIS_fnc_returnConfigEntry;
private _gasLvL = [_configClass, "KAT_toxicLvL", 1] call BIS_fnc_returnConfigEntry;

[{
    params["_args", "_handler"];
    _args params ["_projectile", "_posarr", "_gasinfo"];
    _gasinfo params ["_lifetime", "_radius", "_gasLvL"];
    if (!isNull _projectile) exitwith {
        _args set [1, getPos _projectile];
    };

    [_posarr, _lifetime, _radius, _gasLvL] call FUNC(createZone);

    [_handler] call CBA_fnc_removePerFrameHandler;
}, 0, [_projectile, [0, 0, 0], [_lifetime, _radius, _gasLvL]]] call CBA_fnc_addPerFrameHandler;
