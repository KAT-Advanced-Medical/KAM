#include "..\script_component.hpp"
params["_id", "_params", "_code"];

if(!(_id isEqualType "")) exitWith {};
if(!(_params isEqualType [])) exitWith
{};

[_params, _code, localNamespace, _id, GVAR(cacheInterval)] call ace_common_fnc_cachedCall;