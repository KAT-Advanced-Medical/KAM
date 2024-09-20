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

private _bomb = QGVAR(logic) createVehicle [_posX,_posY,_posZ];

if (isServer) then {
    private _radius = 15;
    private _timeToLive = 240;
    private _gasLevel = 1;

    [QGVAR(addGasSource), [_bomb, _radius, _gasLevel, _bomb, {
        params ["_endTime", "_bomb"];

        // If projectile no longer exists, exit
        if (isNull _bomb) exitWith {
            false // return
        };

        CBA_missionTime < _endTime // return
    }, [CBA_missionTime + _timeToLive, _bomb]]] call CBA_fnc_serverEvent;
};
