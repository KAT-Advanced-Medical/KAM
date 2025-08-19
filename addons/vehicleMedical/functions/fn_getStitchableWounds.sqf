
#include "..\script_component.hpp"

params [
	"_patient"
];

if(GVAR(aceAfter_316)) exitWith {
	GET_BANDAGED_WOUNDS(_patient)
};

[_patient] call ace_medical_treatment_fnc_getStitchableWounds