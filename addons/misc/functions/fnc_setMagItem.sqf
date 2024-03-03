#include "..\script_component.hpp"
/*
 * Author: Katalam, Blue
 * Set ammocount of magazine.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Magazine Classname <STRING>
 * 2: Remove From Mag <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 'kat_Painkiller', true] call kat_misc_fnc_setMagItem;
 *
 * Public: No
 */

params ["_unit", "_magClassname", ["_remove", true]];

private _adjust = [1,-1] select _remove;

private _magazinesArray = [];

{
    if (_x select 0 == _magClassname && !(_x select 2)) then {
        _magazinesArray pushBack [(_x select 0), (_x select 1), (_x select 4)];

        if ((_x select 1) < _lowestAmmoCount) then {
            _targetIndex = ((count _magazinesArray) - 1);
            _lowestAmmoCount = (_x select 1);
        };
    };

} forEach (magazinesAmmoFull _unit);

if (_magazinesArray isEqualTo []) exitWith {0};

private _lowestAmmoCount = 999;
private _targetIndex = 0;

_unit removeMagazines _magClassname;

(_magazinesArray select _targetIndex) params ["_previousMagClassname", "_previousMagCount", "_previousMagLocation"];

_magazinesArray set [_targetIndex, [_previousMagClassname, (_previousMagCount + _adjust), _previousMagLocation]];

{
    if ((_x select 1) > 0) then {
        [_unit, (_x select 0), (_x select 2), (_x select 1)] call ACEFUNC(common,addToInventory);
    };
} forEach _magazinesArray;

if ((_previousMagCount + _adjust) < 1) then {
    [format [LLSTRING(MagItem_Empty), getText (configFile >> "CfgMagazines" >> _magClassname >> "displayName")], 2.5, _unit] call ACEFUNC(common,displayTextStructured);
};
