#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Position (position)
 * 1: Lifetime (number)
 * 2: Radius (number)
 * 3: GasLevel (int of gas)
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [pos player, 60, 100, 0] call kat_chemical_fnc_createZone;
 *
 * Public: No
 *
*/
params ["_position", "_lifetime", "_radius", "_gasType"];

private _logic = "ACE_LogicDummy" createVehicle _position;

[_logic, _position, _radius, 0, _gasType] call FUNC(gasCheck);
private _currentTime = CBA_missionTime;

[{
    params ["_logic","_lifetime","_currentTime"];

    (CBA_missionTime - (_currentTime)) > _lifetime
},
{
    params ["_logic"];
    _logic setVariable [QGVAR(gas_active), false, true];
    deleteVehicle _logic;
}, [_logic, _lifetime, _currentTime]] call CBA_fnc_waitUntilAndExecute;
