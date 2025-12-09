#include "..\script_component.hpp"
params["_vehicle"];

private _code = {
	params["_vehicle"];
	{ !(alive _x) || IS_UNCONSCIOUS(_x) } count (crew _vehicle)
};

[QUOTE(GVAR(IncapacitatedCountCache)),[_vehicle],_code] call FUNC(cachedResult);