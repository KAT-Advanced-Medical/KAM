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
 * [player] call kat_aceMisc_fnc_removeIVbag;
 *
 * Public: No
 */

params ["_player"];

// get some paramaters
private _object = nearestObjects [_player, ['Land_IntravenStand_01_1bag_F', 'Land_IntravenStand_01_2bags_F'], 10, false];
if (_object isEqualType []) then {
	_object = _object select 0;
};
private _className = typeOf _object;
private _newObjectClass = "";
if (_className isEqualTo "Land_IntravenStand_01_2bags_F") then {
	_newObjectClass = "Land_IntravenStand_01_1bag_F";
} else {
	_newObjectClass = "Land_IntravenStand_01_empty_F";
};

// creates new object at [0,0,0]
private _newObject = createVehicle [_newObjectClass, [0,0,0], [], 0, "CAN_COLLIDE"];

// replace the old with the new object
private _oldPos = getPos _object;
private _oldDir = getDir _object;
_object setPos [1,1,1];
_newObject setPos _oldPos;
_newObject setDir _oldDir;
deleteVehicle _object;
