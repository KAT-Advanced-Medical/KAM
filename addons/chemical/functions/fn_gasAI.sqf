#include "script_component.hpp"
/////////////////////

/////////////////////

params ["_unit","_logic","_pos","_radius_max","_gastype"];
private _unitt = _unit;
[
	{
		params["_args","_handler"];
		_args params ["_logic","_unit","_unitt"];
		if(!(_logic getVariable["kat_gas_active",false]) || !(alive _unit) || isNull _unit) then {
			_unit setVariable["kat_medical_enteredPoisen",false,true];
			[_handler] call CBA_fnc_removePerFrameHandler;
		};
	},
	3,
	[_logic,_unit,_unitt]
]call CBA_fnc_addPerFrameHandler;
private _skill = _unit skill "aimingAccuracy";
while{_logic getVariable ["kat_gas_active", false] && !(isNull _logic) && alive _unit && !(_unit getVariable ["ACE_isUnconscious",false])} do { 
	_pos = _logic getVariable ["kat_pos",[0,0,0]];
	if((_unit distance _pos) <= _radius_max && !(_unit getVariable["kat_medical_enteredPoisen",false])) then {
		_unit setVariable["kat_medical_enteredPoisen",true,true];
		private _fnc_afterwait = {
			params["_unit","_gastype","_pos","_skill"];
			if !(goggles _unit in KAT_AVAIL_GASMASK) exitWith {
				if(_gastype == "CS") then {
					while{_unit distance _pos < 10 && _unit getVariable["kat_medical_enteredPoisen",false]} do {
						_unit say3D "cough_1";
						_unit setSkill ["aimingAccuracy",0.001];
						uiSleep 2;
						_unit setSkill ["aimingAccuracy",_skill];
					};
				}else{
					if(ace_medical_statemachine_AIUnconsciousness) then {
						for "_i" from 0 to 10 step 1 do {
							[_unit, "RightArm", "PoisenBP"] call FUNC(medicationLocal);
							uiSleep 5;
						};
					} else {
						[{private _unit = _this select 0;  _unit setDamage 1;},[_unit], 20]call CBA_fnc_waitAndExecute;
					};
				};
			};
		};
		private _timeleft = 30;
		for "_i" from 0 to 1 step 0 do {
			_timeleft = _timeleft - 1;
			if(_timeleft <= 0) exitWith {
				[_unit,_gastype,_pos,_skill] spawn _fnc_afterwait;
				_i = 2;
			};
			if(_gastype == "CS") exitWith {
				[_unit,_gastype,_pos,_skill] spawn _fnc_afterwait;
				_i = 2;
			};
			_pos = _logic getVariable ["kat_pos",[0,0,0]];
			if ( _unit distance _pos > _radius_max || !(_logic getVariable["kat_gas_active",false]) || isNull _logic ) exitWith {
				_unit setVariable["kat_medical_enteredPoisen",false,true];
				_i = 2;
			};
			uiSleep 1;
		};
	};


	uiSleep 5;
};