#include "..\script_component.hpp"
params["_vehicle", "_medic", ["_conditionCode", {true}], ["_force", false]];

if(!(_conditionCode isEqualType {})) exitWith {
};
private _passengers = crew _vehicle;
{
	if(_medic != _x) then {
		if([_x] call _conditionCode) then {
			[_x, _medic, _force] call FUNC(unloadPatient);
		}
		else
		{
		};
	};
}forEach _passengers;