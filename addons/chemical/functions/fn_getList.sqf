#include "script_component.hpp"

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

