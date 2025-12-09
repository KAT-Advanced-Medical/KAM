#include "..\script_component.hpp"

params[
	"_patient", 
	["_isMedic", false, [false]]
];

_hr = GET_HEART_RATE(_patient);
if(_hr == 0) exitWith {
	[LOC(Shared,Heart_Rate_None)] call FUNC(cachedLocalisationCall)
};

if(_isMedic) exitWith {
	round _hr
};

[LOC(Shared,Not_Medic_Heart_Rate_Low)] call FUNC(cachedLocalisationCall)