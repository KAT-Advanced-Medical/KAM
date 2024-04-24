#include "..\script_component.hpp"
/*
 * Author: Blue
 * Convert ammo count to bool array
 *
 * Arguments:
 * 0: Ammocount <INT>
 * 1: FAK Type <INT>
 *
 * Return Value:
 * Array of states <ARRAY>
 *
 * Example:
 * [255, 0] call kat_misc_fnc_FAK_ammoToArray;
 *
 * Public: No
 */


params ["_count", "_type"];

private _array = [false,false,false,false,false,false,false,false];
private _start = 0;
private _divider = 128;

switch (_type) do {
    case 0: { // IFAK
        _start = 4;
        _divider = 8;
    }; 
    case 1: { // AFAK
        _start = 2;
        _divider = 32;
    }; 
    default {}; // MFAK
};

for "_i" from _start to 7 do {
    if ((_count % _divider) != _count) then {
        _count = _count - _divider;
        _array set [_i, true];
    };
    _divider = _divider / 2;
};

reverse _array;
_array;