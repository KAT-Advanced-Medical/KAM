#include "function_macros.hpp"
params["_patient", "_medic", ["_force", false]];

if(_force) exitWith {
	private _name = [_patient] call ace_common_fnc_getName;
	[format["Forcing out %1", _name], false, 4, 1] call ACE_common_fnc_displayText;
	[QUOTE(GVAR(UnloadPatientForce)), [_patient, _medic], _patient] call CBA_fnc_targetEvent;
	["ace_unloadPersonEvent", [_patient, vehicle _patient, _medic], _patient] call CBA_fnc_targetEvent;
};

["ace_unloadPersonEvent", [_patient, vehicle _patient, _medic], _patient] call CBA_fnc_targetEvent;