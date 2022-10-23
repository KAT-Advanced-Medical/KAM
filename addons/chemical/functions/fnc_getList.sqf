#include "script_component.hpp"
/*
 * Author: DiGii
 * This cant be called manualy!
 *
 * 
 * Arguments:
 * 0: Classname <STRING>
 * 1: ConfigName (CfgGlasses) <STRING>
 *
 * Return Value:
 * List <ARRAY>
 *
 * Example:
 * [] call kat_chemical_fnc_getList;
 *
 * Public: No
*/
params [
	"_str"
	,["_cfg","",[""]]
];
 
private _clipString = _str splitString ",""[]()'";
private _array = [];
{
	if (isClass(configFile >> _cfg >> _x) || _cfg isEqualTo "") then {
		_array pushBackUnique _x
	}; 
	nil
} count _clipString;

_array

