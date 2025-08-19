#include "function_macros.hpp"
params["_vehicle"];

private _code = {
	params["_vehicle"];
	{ _x call FUNC(isStable) } count (crew _vehicle)
};

[QUOTE(GVAR(StableCountCache)),[_vehicle],_code] call FUNC(cachedResult);