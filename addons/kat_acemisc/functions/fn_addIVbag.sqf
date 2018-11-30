/*
 * Author: Katalam
 * Adds a IV bag for the medicine IV stands.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, player] call kat_aceMisc_fnc_addIVbag;
 *
 * Public: No
 */

params ["_target", "_player"];

[3, [_target, _player],
	{
		params ["_args"];
		_args params ["_target", "_player"];

		// get some paramaters
		private _className = typeOf _target;

		// exit if _target isn't a valid IV stand
		if !([_className, 0, 17] call BIS_fnc_trimString isEqualTo "Land_IntravenStand") exitWith {};

		// get some parameters
		private _newObjectClass = "";
		if (_className isEqualTo "Land_IntravenStand_01_empty_F") then {
			_newObjectClass = "Land_IntravenStand_01_1bag_F";
		} else {
			_newObjectClass = "Land_IntravenStand_01_2bags_F";
		};

		// creates new object at [0,0,0]
		private _newObject = createVehicle [_newObjectClass, [0,0,0], [], 0, "CAN_COLLIDE"];

		// replace the old with the new object
		private _oldPos = getPos _target;
		private _oldDir = getDir _target;
		_target setPos [1,1,1];
		_newObject setPos _oldPos;
		_newObject setDir _oldDir;
		deleteVehicle _target;

		// use item
		[_player, _player, "ACE_salineIV"] call ace_medical_fnc_useItem;
	}, {}, localize "STR_kat_aceMisc_Action_add_IV"] call ace_common_fnc_progressBar;
