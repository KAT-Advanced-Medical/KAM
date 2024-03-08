#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Removes a IV bag for the medicine IV stands.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 500] call kat_misc_fnc_removeIVbag;
 *
 * Public: No
 */

params ["_player", "_oldML"];

// get some paramaters
private _object = nearestObjects [_player, ['Land_IntravenStand_01_1bag_F', 'Land_IntravenStand_01_2bags_F'], 10, false];
_object = _object select {_oldML in (_x getVariable [QGVAR(stand), []])};
_object = _object select 0;
private _value = _object getVariable [QGVAR(stand), []];
private _className = typeOf _object;
private _newObjectClass = "";
if (_className isEqualTo "Land_IntravenStand_01_2bags_F") then {
    _newObjectClass = "Land_IntravenStand_01_1bag_F";
    if (_value select 0 == _value select 1) then {
        _value = [_value select 0];
    } else {
        _value = _value select {_x != _oldML};
    };
} else {
    _newObjectClass = "Land_IntravenStand_01_empty_F";
};

// creates new object at [0,0,0]
private _newObject = createVehicle [_newObjectClass, [0,0,0], [], 0, "CAN_COLLIDE"];
_newObject setVariable [QGVAR(stand), _value, true];

// replace the old with the new object
private _oldPos = getPos _object;
private _oldDir = getDir _object;
_object setPos [1,1,1];
_newObject setPos _oldPos;
_newObject setDir _oldDir;
deleteVehicle _object;
