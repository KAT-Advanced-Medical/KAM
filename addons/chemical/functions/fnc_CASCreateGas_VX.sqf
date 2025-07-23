#include "..\script_component.hpp"
/*
* Author: DiGii
* Modified: kolmipilot
* Arguments:
* 0: Position <ARRAY>
*
* Return Value:
* NONE
*
* Example:
* [getPos player] call kat_chemical_fnc_CASCreateGas_VX;
*
* Public: No
*
* Gets position of droped bombs and creates a Gas zone there
*/

params ["_posX", "_posY", "_posZ"];

private _projectile = QGVAR(logic) createVehicle [_posX, _posY, _posZ];
private _particleEffects = missionNamespace getVariable [QGVAR(showParticles), true];
private _customColors = missionNamespace getVariable [QGVAR(customColors), true];

if (isServer) then {
    private _radius = 100;
    private _timeToLive = 240;
    private _gasLevel = 3;
    private _endTime = CBA_missionTime + _timeToLive;

    [{
        params ["_args", "_pfhID"];
        _args params ["_projectile", "_radius", "_gasLevel", "_endTime", "_particleEffects", "_customColors"];

        if (isNull _projectile) exitWith {
            [_pfhID] call CBA_fnc_removePerFrameHandler;
        };

        [QGVAR(addGasSource), [
            _projectile,
            _radius,
            _gasLevel,
            _projectile,
            {
                params ["_endTime", "_projectile"];
                if (isNull _projectile) exitWith { false };
                CBA_missionTime < _endTime
            },
            [_endTime, _projectile],
            false,
            _particleEffects,
            _customColors
        ]] call CBA_fnc_serverEvent;

        [_pfhID] call CBA_fnc_removePerFrameHandler;
    }, 0, [_projectile, _radius, _gasLevel, _endTime, _particleEffects, _customColors]] call CBA_fnc_addPerFrameHandler;
};
