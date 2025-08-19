#include "function_macros.hpp"
#include "medical_macros.hpp"

params[
	"_patient", 
	["_isMedic", false, [false]]
];

_bp = [_patient] call FUNC(getBloodPressure);
_bp params ["_bpLow", "_bpHigh"];
if(_isMedic) exitWith {
	format["%1/%2", (round _bpHigh), (round _bpLow)]
};
[LSTRING(Shared,Not_Medic_Blood_Pressure_Low)] call FUNC(cachedLocalisationCall)