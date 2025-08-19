#include "function_macros.hpp"


params[
	"_patient"
];

private _ivs = _patient getVariable ["ace_medical_ivBags", nil];

if(isNil "_ivs") exitWith {
	0
};

private _sum = 0;
{
	_x params ["_volumeRemaining"];
	_sum = _sum + _volumeRemaining;
}forEach _ivs;
_sum = round _sum;
_sum