#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Returns ammo count of each provided magazine.
 * Optional: returns container alongside ammo count.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: String
 * 2: Bool (optional)
 *
 * Return Value:
 * <ARRAY>
 *
 * Example:
 * [player, "kat_IFAK_Magazine"] call kat_misc_fnc_getMagazineAmmoCounts;
 *
 * Public: No
 */

params ["_unit", "_mag", "_returnLocation"];

private _magAmmo = [];
private _return = _magAmmo;
private	_targetMag = magazinesAmmoFull _unit select {_x select 0 == _mag};

if (_returnLocation == true) exitWith {
	
	{
		_magAmmo pushBack [(_x select 1),(_x select 4)];
	} forEach _targetMag;

	_return
};

{
	_magAmmo pushBack (_x select 1);
} forEach _targetMag;

_return
