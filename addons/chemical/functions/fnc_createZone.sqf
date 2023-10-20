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
params ["_pos", "_lifetime", "_radius", "_gasLvL"];

private _logic = "ACE_LogicDummy" createVehicle _pos;

private _gastype = "";
switch (_gasLvL) do {
    case 1: { //CS
        _gastype = "CS";
    };
    default { //toxic gas (standard)
        _gastype = "Toxic";
    };
};

if (_gastype isEqualTo "CS") then {[getPosASL _logic, _radius, _lifetime] call FUNC(spawnGasSmoke);};

[_logic, _pos, _radius, 0, _gastype] call FUNC(gasCheck);
private _currentTime = CBA_missionTime;

[{
    //condition
    params["_logic","_lifetime","_currentTime"];
    (CBA_missionTime - (_currentTime)) > _lifetime
},
{
    //code
    params["_logic"];
    _logic setVariable [QGVAR(gas_active), false, true];
    deleteVehicle _logic;
}, [_logic, _lifetime, _currentTime]] call CBA_fnc_waitUntilAndExecute;
