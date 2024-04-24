#include "..\script_component.hpp"
/*
 * Author: Blue
 * Convert bool array into ammo count
 *
 * Arguments:
 * 0: Bool Array <ARRAY>
 *
 * Return Value:
 * Ammo count <INT>
 *
 * Example:
 * [[true,true,true,true,false,false,false,false]] call kat_misc_fnc_FAK_arrayToAmmo;
 *
 * Public: No
 */

params ["_array"];

private _total = 0;
private _add = 1;

{
    if (_x) then {
        _total = _total + _add;
    };
    _add = _add * 2;
} forEach _array;

_total;