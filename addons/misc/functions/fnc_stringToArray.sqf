#include "script_component.hpp"
/*
 * Author: Digii
 * Splits an string into an array. (that can be used by CBA settings)
 *
 * Arguments:
 * 0: String <STRING>
 * 1: Split string <STRING> (https://community.bistudio.com/wiki/splitString)
 * 2: Return as Number <BOOL>
 *
 * Return Value:
 * array <ARRAY>
 *
 * Example:
 * ["-0.228, -0.087, -0.45", ","" ", true] call kat_misc_fnc_stringToArray;
 *
 * Public: No
 */

params ["_str", "_spliter", "_returnNumber"];

private _clipstring = _str splitstring _spliter;
private _array = [];

if (_returnNumber) exitWith
{
    {
        private _i = parseNumber _x;
        _array pushBack _i;
    } forEach _clipstring;

    _array
};

_clipstring