#include "..\script_component.hpp"
/*
* Author: DiGii
* This cant be called manualy!
*
* Arguments:
* 0: Logic <LOGIC>
* 1: Affected Units (not used) <ARRAY>
* 2: Activated <BOOL>
*
* Return Value:
* NONE
*
* Example:
* [] call kat_chemical_fnc_gasmodule;
*
* Public: No
*/
params ["_logic", "_units", "_activated"];

private _radius = _logic getVariable ["Radius", 20];
private _gasLevel = _logic getVariable ["GAS_type", 0];
private _isSealable = _logic getVariable ["IsSealable", false];

if (!_activated) exitWith {};
if (isServer) then {

    [{
        params ["_logic", "_radius", "_gasLevel"];

        [QGVAR(addGasSource), [_logic, _radius, _gasLevel, _logic, {
            params ["_endTime", "_logic"];

            // If logic no longer exists, exit
            if (isNull _logic) exitWith {
                false // return
            };

            CBA_missionTime < _endTime // return
        }, [CBA_missionTime + 1e10, _logic]]] call CBA_fnc_serverEvent;

    }, [_logic, _radius, _gasLevel], 1] call CBA_fnc_waitAndExecute;

};
