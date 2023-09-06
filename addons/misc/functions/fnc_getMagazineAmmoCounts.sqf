#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Returns ammo count of each provided magazine.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: String
 *
 * Return Value:
 * <ARRAY>
 *
 * Example:
 * [player, "kat_IFAK_Magazine"] call kat_misc_fnc_getMagazineAmmoCounts;
 *
 * Public: No
 */

params ["_unit", "_mag"];

private _targetMag = magazinesAmmo _unit select {_x select 0 == _mag};
private _magAmmo = [];
private _return = _magAmmo;

{
	_magAmmo pushBack (_x select 1);
} forEach _targetMag;

_return