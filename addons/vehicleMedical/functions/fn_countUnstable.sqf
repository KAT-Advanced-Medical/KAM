#include "function_macros.hpp"
params["_vehicle"];

private _code = {
	params["_vehicle"];
	{ _x call FUNC(isUnstable) } count (crew _vehicle)
};

[QUOTE(GVAR(UnstableCountCache)),[_vehicle],_code] call FUNC(cachedResult);