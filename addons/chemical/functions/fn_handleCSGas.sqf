#include "script_component.hpp"
////////////////////////////////

////////////////////////////////
params ["_logic","_radius"];
[{
	params["_params","_handler"];
	_params params["_unit"];
	if(_unit getVariable["kat_medical_enteredPoisen",false]) then {
		if (_unit getVariable ["ace_medical_pain", -1] < 0.25) then {_unit setVariable ["ace_medical_pain", 0.41]};
		if(goggles _unit in KAT_AVAIL_GASMASK) then {_unit setVariable["kat_medical_enteredPoisen",false,true]};
		_unit setVariable ["kat_medical_CS",true,true];
		_unit say3D "cough_1";
		private _rndBlur = selectRandom[5,6,7,8];
		ppBlur ppEffectAdjust [_rndBlur]; 
		ppBlur ppEffectEnable true;  
		ppBlur ppEffectCommit 5;
	} else {
		ppBlur ppEffectAdjust [0]; 
		ppBlur ppEffectEnable true; 
		ppBlur ppEffectCommit 20;
		_unit setVariable ["kat_medical_CS",false,true];
		[_handler] call CBA_fnc_removePerFrameHandler;
		
	};
}, 5, [player]] call CBA_fnc_addPerFrameHandler;

//Pos Check
[{
	params ["_param","_handler"];
	_param params ["_logic","_radius","_unit"];
	private _pos = _logic getVariable ["kat_pos",[0,0,0]];
	if ( _unit distance _pos > _radius || !(_logic getVariable["kat_gas_active",false]) || isNull _logic ) exitWith {
		_unit setVariable["kat_medical_enteredPoisen",false,true];
		[_handler] call CBA_fnc_removePerFrameHandler;
	};
},2,[_logic,_radius,player]] call CBA_fnc_addPerFrameHandler;