#include "function_macros.hpp"

params[
	"_patient"
];

if(GVAR(aceAfter_313)) exitWith {
	_patient call ace_medical_treatment_fnc_isMedic
};

_patient call ace_medical_fnc_isMedic;