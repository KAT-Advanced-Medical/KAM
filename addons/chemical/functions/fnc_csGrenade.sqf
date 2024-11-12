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

#define PARTICLE_LIFE_TIME 2
#define PARTICLE_DENSITY 20
#define PARTICLE_SIZE 1
#define PARTICLE_SPEED 1

#define PARTICLE_SMOKE_LIFE_TIME 5
#define PARTICLE_SMOKE_DENSITY 5
#define PARTICLE_SMOKE_SIZE 0.5
#define PARTICLE_SMOKE_SPEED 1
#define PARTICLE_SMOKE_LIFTING 1
#define PARTICLE_SMOKE_WIND_EFFECT 1

#define EXPANSION 1

#define EFFECT_SIZE 1

params ["_projectile", "_timeToLive", "_center"];

private _position = position _projectile;

// Alert nearby hostile AI
{
    if (local _x && {[_center, side group _x] call BIS_fnc_sideIsEnemy} && {behaviour _x in ["SAFE", "AWARE"]}) then { // WE WANT THE OBJECT'S SIDE HERE!
        _x setBehaviour "COMBAT";
    };
} forEach ([_position, ALERT_NEAR_ENEMY_RANGE, ALERT_NEAR_ENEMY_RANGE, 0, false] nearEntities [["CAManBase"], false, true, true]);

private _particleSource = "#particlesource" createVehicleLocal _position;

//Particle options
_particleSource setParticleParams [
    ["\A3\data_f\cl_basic",1,0,1], // File,Ntieth,Index,Count,Loop
    "", //Animation name
    "Billboard", //Type
    1, //Timer Period (We do this to spread the updates out and reduce overhead)
    PARTICLE_SMOKE_LIFE_TIME, //Lifetime
    [0,0,0],
    [0, 0, PARTICLE_SMOKE_SPEED], //Move velocity
    5 + random 10, //Rotation velocity
    0.05, //Weight
    0.04 * PARTICLE_SMOKE_LIFTING, //Volume
    0.05 * PARTICLE_SMOKE_WIND_EFFECT, //Rubbing
    [1 * PARTICLE_SMOKE_SIZE + 1, 1.8 * PARTICLE_SMOKE_SIZE + 15], //Size
    [[0.9294,0.9843,1] + [0.001], [0.9294,0.9843,1] + [0.1], [1,1,1,0]], //Color
    [0,0], //Animation speed
    0.1, //Random direction period
    0.08 * EXPANSION, //Random direction intensity
    "",
    "", //Before destroy script
    _projectile //This
];

_particleSource setParticleRandom [PARTICLE_SMOKE_LIFE_TIME / 2, [0.5 * EFFECT_SIZE, 0.5 * EFFECT_SIZE, 0.2 * EFFECT_SIZE], [0.3,0.3,0.5], 1, 0, [0,0,0,0.06], 0, 0];
_particleSource setDropInterval (1 / PARTICLE_SMOKE_DENSITY);

if (isServer) then {
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

[{deleteVehicle _this}, _particleSource, _timeToLive] call CBA_fnc_waitAndExecute;
