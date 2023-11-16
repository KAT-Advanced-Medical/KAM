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

private _logic = param [0, objNull, [objNull]];
private _activated = param [2, true, [true]];
private _radius_max = _logic getVariable ["Radius_Max", 20];
private _radius_min = _logic getVariable ["Radius_Min", 10];
private _gastype = _logic getVariable ["GAS_type", "Toxic"];
private _isSealable = _logic getVariable ["IsSealable", false];

if (_activated) then {
    if (count synchronizedObjects _logic > 0) then {
        private _object = (synchronizedObjects _logic) select 0;
        private _pos = getPos _object;
        if (_isSealable) then {
            [_object] call FUNC(createSealaction);
        };

        [_object, _pos, _radius_max, _radius_min, _gastype] spawn FUNC(gasCheck);
    } else {
        private _pos = getPos _logic;
        [_logic, _pos, _radius_max, _radius_min, _gastype] spawn FUNC(gasCheck);
    };
};
