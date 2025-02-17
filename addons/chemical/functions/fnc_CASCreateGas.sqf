#include "..\script_component.hpp"
/*
* Author: DiGii
*
* Arguments:
* 0: Position <ARRAY>
*
* Return Value:
* NONE
*
* Example:
* [getPos player] call kat_chemical_fnc_CASCreateGas;
*
* Public: No
*
* Gets position of droped bombs and creates a Gas zone there
*/

params ["_posX", "_posY", "_posZ"];

private _projectile = QGVAR(logic) createVehicle [_posX,_posY,_posZ];

if (isServer) then {
    private _radius = 15;
    private _timeToLive = 240;
    private _gasLevel = 1;

    [QGVAR(addGasSource), [_projectile, _radius, _gasLevel, _projectile, {
        params ["_endTime", "_projectile"];

        // If projectile no longer exists, exit
        if (isNull _projectile) exitWith {
            false // return
        };

        CBA_missionTime < _endTime // return
    }, [CBA_missionTime + _timeToLive, _projectile]]] call CBA_fnc_serverEvent;
};
