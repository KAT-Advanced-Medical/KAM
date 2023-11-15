#include "..\script_component.hpp"
/*
* Author: DiGii
* This cant be called manualy!
*
*
* Arguments:
* 0: classname <strinG>
* 1: configname (CfgGlasses) <strinG>
*
* Return Value:
* List <ARRAY>
*
* Example:
* [backpack player, "Cfgweapons"] call kat_chemical_fnc_getlist;
*
* Public: No
*/
params ["_str", ["_cfg", "", [""]]];

private _clipstring = _str splitstring ", ""[]()'";
private _array = [];
{
    if (isClass(configFile >> _cfg >> _x) || _cfg isEqualto "") then {
        _array pushBackUnique _x
    };
    nil
} count _clipstring;

_array
