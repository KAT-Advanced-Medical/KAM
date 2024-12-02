#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: PosX <NUMBER>
 * 1: PosY <NUMBER>
 * 2: PosZ <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [0,0,0] call kat_chemical_fnc_spawnSmoke;
 *
 * Public: No
 *
 *
*/
params ["_posX","_posY","_posZ"];

private _smoke = "KAT_GASTrip_SmokeEffect" createVehicle [_posX,_posY,_posZ];
hideObjectGlobal _smoke;
[_smoke, 0, ["ACE_MainActions", "ACTION"]] call ACEFUNC(interact_menu,removeActionFromObject);

if (isServer) then {
    private _timeToLive = 10;
    private _radius = 10;
    private _gasLevel = 1;

    [QGVAR(addGasSource), [_smoke, _radius, _gasLevel, _smoke, {
        params ["_endTime", "_smoke"];

        // If smoke no longer exists, exit
        if (isNull _smoke) exitWith {
            false // return
        };

        CBA_missionTime < _endTime // return
    }, [CBA_missionTime + _timeToLive, _smoke]]] call CBA_fnc_serverEvent;
};

