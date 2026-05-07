#include "..\script_component.hpp"
/*
 * Author: DiGii, MiszczuPolski
 * Spawns Patricles for the Gas zone
 *
 * Arguments:
 * 0: Postiton <VECTOR3>
 * 1: Radius <Number>
 * 2: Lifetime <Number>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [getPosASL player, 25, 60] call kat_chemical_fnc_spawnGasSmoke;
 *
 * Public: No
*/

#define ALERT_NEAR_ENEMY_RANGE 60

params ["_projectile", "_timeToLive", "_center"];

private _position = position _projectile;

// Alert nearby hostile AI
{
    if (local _x && {[_center, side group _x] call BIS_fnc_sideIsEnemy} && {behaviour _x in ["SAFE", "AWARE"]}) then { // WE WANT THE OBJECT'S SIDE HERE!
        _x setBehaviour "COMBAT";
    };
} forEach ([_position, ALERT_NEAR_ENEMY_RANGE, ALERT_NEAR_ENEMY_RANGE, 0, false] nearEntities [["CAManBase"], false, true, true]);

if (isServer) then {
    // Broadcast CS smoke to all machines (each creates its own local particle)
    [QGVAR(csGrenadeEffect), [_projectile, _timeToLive]] call CBA_fnc_globalEvent;

    private _radius = 6;
    private _gasLevel = 0;

    [QGVAR(addGasSource), [_projectile, _radius, _gasLevel, _projectile, {
        params ["_endTime", "_projectile"];

        // If incendiary no longer exists, exit
        if (isNull _projectile) exitWith {
            false // return
        };

        // Need to get the position every time, as grenade might have been moved
        private _position = position _projectile;

        CBA_missionTime < _endTime // return
    }, [CBA_missionTime + _timeToLive, _projectile]]] call CBA_fnc_serverEvent;
};
