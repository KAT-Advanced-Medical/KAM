#include "function_macros.hpp"
params["_id", "_params", "_code"];

if(!(_id isEqualType "")) exitWith {
	LOG_ERRORF_1("Requested cache for id type %1, requires string", typeOf _id);
};
if(!(_params isEqualType [])) exitWith
{
	LOG_ERRORF_1("Params expected array found %1", typeOf _params);
};

[_params, _code, localNamespace, _id, GVAR(cacheInterval)] call ace_common_fnc_cachedCall;