#include "function_macros.hpp"


params[
	"_patient"
];

_amountToBandage = 0;
{
	_x params ["_classId", "_bodyPartN", "_amountOf", "_bloodloss", "_damage"];
	if(_amountOf > 0 && _bloodloss > 0) then {
		_amountToBandage = _amountToBandage + _amountOf;
	};
} forEach GET_OPEN_WOUNDS(_patient);

_amountToBandage