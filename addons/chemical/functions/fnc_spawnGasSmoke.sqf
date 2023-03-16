/*
 * Author: DiGii
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

params ["_position", "_radius", "_lifetime"];

private _fnc_getEllipsoidArea = {
    params ["_a", "_b", "_c"];
    
    (4 * pi * (((((_a * _b) ^ 1.6) + ((_a * _c) ^ 1.6) + ((_c * _b) ^ 1.6)) / 3) ^ (1/1.6)));
};

//An easy little polar coordinate function
private _fnc_getSpherePolarCoordinates = {
    params ["_theta", "_phi", "_distance", "_vert"];
    [_distance * (cos _theta) * (sin _phi), _distance * (sin _theta) * (sin _phi), _vert * (cos _phi) * 0.33];
};

for "_i" from 1 to floor ((([_radius, _radius, 2] call _fnc_getEllipsoidArea) / 10) * 1) do {
    private _particleSource = "#particlesource" createVehicle _position;
    
    //Particle options
    _particleSource setParticleParams [
        ["\A3\data_f\cl_basic",1,0,1], // File,Ntieth,Index,Count,Loop
        "", //Animation name
        "Billboard", //Type
        0.1 + random 5, //Timer Period (We do this to spread the updates out and reduce overhead)
        _lifetime - random 2, //Lifetime
        [random 360, random 360, _radius * sqrt (random 1), 2] call _fnc_getSpherePolarCoordinates,//) + [-2 - (random _verticleSpread)], //Position relative to the particle source (Don't mind da maffs)
        [0,0,(-0.003 - random 0.5)], //Move velocity
        5 + random 10, //Rotation velocity
        10, //Weight
        7.843, //Volume
        0.05 + random 0.05, //Rubbing
        [5,5,5], //Size
        [[0.9294,0.9843,1] + [0.001], [0.9294,0.9843,1] + [0.1], [1,1,1,0]], //Color
        [0,0], //Animation speed
        0, //Random direction period
        0, //Random direction intensity
        "",
        "", //Before destroy script
        _particleSource //This
    ];
    _particleSource setDropInterval 100;
    
    [{deleteVehicle _this}, _particleSource, 0.5] call CBA_fnc_waitAndExecute;
};