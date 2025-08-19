#include "function_macros.hpp"
#include "medical_macros.hpp"

params[
	"_patient", 
	["_isMedic", false, [false]]
];

_hr = [_patient] call FUNC(getHeartRate);
if(_hr == 0) exitWith {
	[LSTRING(Shared,Heart_Rate_None)] call FUNC(cachedLocalisationCall)
};

if(_isMedic) exitWith {
	round _hr
};

[LSTRING(Shared,Not_Medic_Heart_Rate_Low)] call FUNC(cachedLocalisationCall)