
#include "..\script_component.hpp"

params[
	"_patient",
	["_splintedOnly", false]
];

private _fractures = GET_FRACTURES(_patient);
private _numFractures = 0;
{
	private _fracture = _fractures select _x;
	switch (_fracture) do {
		case 0: { 
			// Do nothing, no fracture
		};
		case 1: {
			// Fractured, no splint
			if!(_splintedOnly) then {
				_numFractures = _numFractures + 1;
			};
		};
		case -1: {
			if(_splintedOnly) then {
				if(ace_medical_fractures in [2,3]) then {
					_numFractures = _numFractures + 1;
				}
				else {
					// Splinted, fracture healed automagically
				};
			};
		};
		case -2: {
			if(_splintedOnly) then {
				if(ace_medical_fractures in [2,3]) then {
					_numFractures = _numFractures + 1;
				}
				else {
					// Splinted, fracture healed automagically
				};
			};
		};
		case -3: {
			if(_splintedOnly) then {
				if(ace_medical_fractures in [2,3]) then {
					_numFractures = _numFractures + 1;
				}
				else {
					// Splinted, fracture healed automagically
				};
			};
		};
		default {
		};
	};
} forEach [ 
	HITPOINT_INDEX_LARM,
	HITPOINT_INDEX_ULARM,
	HITPOINT_INDEX_RARM,
	HITPOINT_INDEX_URARM,
	HITPOINT_INDEX_LLEG,
	HITPOINT_INDEX_ULLEG,
	HITPOINT_INDEX_RLEG,
	HITPOINT_INDEX_URLEG];
_numFractures