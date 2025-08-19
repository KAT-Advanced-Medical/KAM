#include "function_macros.hpp"

params[
	"_patient"
];


if(GVAR(aceAfter_313)) exitWith {
	[_patient] call ace_medical_gui_fnc_openMenu;
};

[_patient] call ace_medical_menu_fnc_openMenu;