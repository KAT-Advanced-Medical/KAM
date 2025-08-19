#include "function_macros.hpp"
#include "medical_macros.hpp"

params[
	"_patient", 
	["_isMedic", false, [false]],
	["_stable", true, [true]]
];

_threshold = GVAR(Stable_ThresholdLowBP);
if(!_stable) then {
	_threshold = GVAR(Unstable_ThresholdLowBP);
};

_bp = [_patient] call FUNC(getBloodPressure);
_highBP = round (_bp select 1);

if(_isMedic) exitWith {
	if(_highBP > _threshold) exitWith {
		false
	};
	true
};

if(_highBP > NOTMEDIC_LOWBP_THRESHOLD) exitWith {
	false
};
true