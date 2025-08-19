#include "..\script_component.hpp"


params[
	"_patient",
	["_splinted", false]
];

private _fractures = [_patient] call FUNC(getFractures);
private _hasFractures = false;
{
	if(_hasFractures) exitWith {};

	private _fracture = _fractures select _x;
	switch (_fracture) do {
		case 0: { 
			// Do nothing, no fracture
		};
		case 1: {
			// Fractured, no splint
			if!(_splinted) then {
				_hasFractures = true;
			};
		};
		case -1: {
			if(_splinted) then 
			{
				if(ace_medical_fractures in [2,3]) then {
					// Splinted, fracture isn't healed
					_hasFractures = true;
				}
				else
				{
					// Splinted, fracture healed automagically
				};
			};
		};
		default {
			LOG_ERRORF_1("Unknown Fracture State '%1'", _fracture);
		};
	};
} forEach [
	HITPOINT_INDEX_LLEG,
	HITPOINT_INDEX_RLEG];
_hasFractures