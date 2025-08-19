#include "function_macros.hpp"
#include "medical_macros.hpp"

params[
	"_patient", 
	["_isMedic", false, [false]], 
	["_stable", true, [true]]
];

_threshold = GVAR(Stable_ThresholdLowHR);
if(!_stable) then {
	_threshold = GVAR(Unstable_ThresholdLowHR);
};

_hr = [_patient] call FUNC(getHeartRate);

if(_isMedic) exitWith {
	if(_hr > _threshold) exitWith {
		false
	};
	true
};

if(_hr > NOTMEDIC_LOWHR_THRESHOLD) exitWith {
	false
};
true