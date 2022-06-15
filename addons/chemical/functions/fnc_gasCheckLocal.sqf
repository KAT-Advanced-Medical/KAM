#include "script_component.hpp"
//////////////////////////

//////////////////////////

params ["_unit","_logic","_pos","_radius_max","_radius_min","_gastype"];

[
	{
		params["_args","_handler"];
		_args params ["_logic","_unit","_pos"];
		private _posString = toString(_logic getVariable ["kat_pos",[0,0,0]]);
		private _logicPos = toString(getpos _logic);
		if!(_logic getVariable["kat_chemical_gas_active",false]) then {
			if(_unit getVariable["kat_medical_enteredPoisen",false]) then {
				_unit setVariable["kat_medical_enteredPoisen",false,true];
				[_handler] call CBA_fnc_removePerFrameHandler;
			};
		};
	},
	3,
	[_logic,_unit,_pos]
]call CBA_fnc_addPerFrameHandler;
 

while{_logic getVariable ["kat_chemical_gas_active", false] && !(isNull _logic) && _unit in (_logic getVariable ["kat_gas_playerArr",[]])} do {

	_pos = _logic getVariable ["kat_pos",[0,0,0]];
	if(_unit distance _pos <= _radius_max && !(_unit getVariable["kat_medical_enteredPoisen",false]) && !(_unit getVariable ["ACE_isUnconscious",false])) then {


		_unit setVariable ["kat_medical_enteredPoisen", true, true];
		_unit setVariable ["kat_medical_Poisen_logic",_logic,true];
		private _timeEntered = CBA_missionTime;
		

		_fnc_kat_afterwait = {
			params["_unit","_timeEntered","_logic","_gastype","_radius_max"];
			 
			if(goggles _unit in KAT_AVAIL_GASMASK) then {

				private _maskTime = missionNamespace getVariable["kat_medical_gasmask_durability",900];
				private _isinGas = true; 
				while {_isinGas} do {
						private _timeleft = _unit getVariable["kat_gasmask_durability",10];
						_pos = _logic getVariable ["kat_pos",[0,0,0]];
						if ( _unit distance _pos > _radius_max || !(_logic getVariable["kat_chemical_gas_active",false]) || isNull _logic ) exitWith {
							_unit setVariable["kat_medical_enteredPoisen",false,true];
							_isinGas = false;
						};

						if !(goggles _unit in KAT_AVAIL_GASMASK && _timeleft > 0) then {
							_unit setVariable ["kat_medical_poisenType",_gastype,true];
							if(_gastype == "Toxic") then {_unit setVariable ["kat_chemical_airPoisend",true,true];};
							if(_gastype == "CS") then {_unit setVariable ["kat_chemical_CS",true,true]; [_logic,_radius_max] spawn FUNC(handleCSGas);};

							_isinGas = false;
						};

						if(_timeleft <= 0 && _unit getVariable ["kat_medical_enteredPoisen",false]) then {
							_unit setVariable ["kat_medical_poisenType",_gastype,true];
							if(_gastype == "Toxic") then {_unit setVariable ["kat_chemical_airPoisend",true,true];};
							if(_gastype == "CS") then {_unit setVariable ["kat_chemical_CS",true,true]; [_logic,_radius_max] spawn FUNC(handleCSGas);};
							_isinGas = false;
						};

						if (!(_unit getVariable ["kat_medical_enteredPoisen",false]) || !(_logic getVariable["kat_chemical_gas_active",false])) then {
							
							_isinGas = false;
							_unit setVariable ["kat_medical_enteredPoisen",false];
						};
						uiSleep 1;
				};

			} else {
				if(_unit getVariable ["kat_medical_enteredPoisen",false]) then {
					_unit setVariable ["kat_medical_poisenType",_gastype,true];
					if(_gastype == "Toxic") then {_unit setVariable ["kat_chemical_airPoisend",true,true];};
					if(_gastype == "CS") then {_unit setVariable ["kat_chemical_CS",true,true]; [_logic,_radius_max] spawn FUNC(handleCSGas);};
				};
			};
		};
		//time in gas before something happens (todo: move to addonoptions)
		

			private _prozent = 1;
			for "_i" from 0 to 1 step 0 do {
				_pos = _logic getVariable ["kat_pos",[0,0,0]];
				private _distance = _unit distance _pos;
				private _min_to_max = _radius_max - _radius_min;
				private _dis_to_min = _distance - _radius_min;
				if(_distance > _radius_min) then {
					_prozent = 1-(_dis_to_min/_min_to_max);
					if(_prozent > 1) then {_prozent = 1};
				} else {
					_prozent = 1;
				};
				_unitTime = _unit getVariable ["kat_gas_timeleft",60];
				_unitTime = _unitTime - _prozent;
				_unit setVariable ["kat_gas_timeleft",_unitTime];
				_unit setVariable ["kat_gas_percente",_prozent];
				if(_unitTime <= 0) exitWith {
					[_unit,_timeEntered,_logic,_gastype,_radius_max] spawn _fnc_kat_afterwait;
					_unit setVariable ["kat_gas_timeleft",0];
					_i = 2;
				};

					
				if ( _unit distance _pos > _radius_max || !(_logic getVariable["kat_chemical_gas_active",false]) || isNull _logic ) exitWith {
					_unit setVariable["kat_medical_enteredPoisen",false,true];
					_i = 2;
				};

				if(_gastype == "CS") exitWith {
					_i = 2;
					[_unit,_timeEntered,_logic,_gastype,_radius_max] spawn _fnc_kat_afterwait;
				};
				uiSleep 1;
			};

	};
};