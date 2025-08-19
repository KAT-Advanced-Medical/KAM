#include "function_macros.hpp"
params["_vehicle"];

private _code = {
	params["_vehicle"];
	{ !(alive _x) || _x call FUNC(isUnconscious) } count (crew _vehicle)
};

[QUOTE(GVAR(IncapacitatedCountCache)),[_vehicle],_code] call FUNC(cachedResult);