#include "function_macros.hpp"
params["_vehicle", "_medic", ["_conditionCode", {true}], ["_force", false]];

if(!(_conditionCode isEqualType {})) exitWith {
	LOGF_1("Provided condition is not code: %1", _conditionCode);
};
private _passengers = crew _vehicle;
{
	if(_medic != _x) then {
		if([_x] call _conditionCode) then {
			[_x, _medic, _force] call FUNC(unloadPatient);
		}
		else
		{
			LOGF_1("Unable to unload %1", _x);
		};
	};
}forEach _passengers;