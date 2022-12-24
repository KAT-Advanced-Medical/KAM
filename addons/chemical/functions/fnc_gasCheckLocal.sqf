#include "script_component.hpp"
/*
 * Author: DiGii
 * This cant be called manualy!
 * Handles the Gas effect for the Player
 * 
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Module <Logic>
 * 2: Position <Position>
 * 3: Max_Radius <NUMBER>
 * 4: Min_Radius <NUMBER>
 * 5: GasType <STRING>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player, logic, getpos player, 50, 20, 1] call kat_chemical_fnc_gasCheckLocal;
 *
 * Public: No
*/

params ["_unit","_logic","_pos","_radius_max","_radius_min","_gastype"];

[
	{
		params["_args","_handler"];
		_args params ["_logic","_unit","_pos"];
		private _posString = toString(_logic getVariable [QGVAR(gas_pos),[0,0,0]]);
		private _logicPos = toString(getpos _logic);
		if!(_logic getVariable[QGVAR(gas_active),false]) then {
			if(_unit getVariable[QGVAR(enteredPoisen),false]) then {
				_unit setVariable[QGVAR(enteredPoisen),false,true];
				[_handler] call CBA_fnc_removePerFrameHandler;
			};
		};
	},
	3,
	[_logic,_unit,_pos]
]call CBA_fnc_addPerFrameHandler;
 

while{_logic getVariable [QGVAR(gas_active), false] && !(isNull _logic) && _unit in (_logic getVariable [QGVAR(gas_playerArr),[]])} do {

	_pos = _logic getVariable [QGVAR(gas_pos),[0,0,0]];
	if(_unit distance _pos <= _radius_max && !(_unit getVariable[QGVAR(enteredPoisen),false]) && !(_unit getVariable ["ACE_isUnconscious",false])) then {


		_unit setVariable [QGVAR(enteredPoisen), true, true];
		_unit setVariable [QGVAR(Poisen_logic),_logic,true];
		private _timeEntered = CBA_missionTime;
		

		_fnc_kat_afterwait = {
			params["_unit","_timeEntered","_logic","_gastype","_radius_max"];
			 
			if(goggles _unit in GVAR(availGasmaskList)) then {

				private _maskTime = missionNamespace getVariable[QGVAR(gasmask_durability),900];
				private _isinGas = true; 
				while {_isinGas} do {
					[
						{
							params["_unit","_timeEntered","_logic","_gastype","_radius_max"];
							private _timeleft = _unit getVariable[QGVAR(gasmask_durability),10];
							_pos = _logic getVariable [QGVAR(gas_pos),[0,0,0]];
							if ( _unit distance _pos > _radius_max || !(_logic getVariable[QGVAR(gas_active),false]) || isNull _logic ) exitWith {
								_unit setVariable[QGVAR(enteredPoisen),false,true];
								_isinGas = false;
							};

							if !(goggles _unit in GVAR(availGasmaskList) && _timeleft > 0) then {
								_unit setVariable [QGVAR(poisenType),_gastype,true];
								if(_gastype isEqualTo "Toxic") then {_unit setVariable [QGVAR(airPoisend),true,true];};
								if(_gastype isEqualTo "CS") then {_unit setVariable [QGVAR(CS),true,true]; [_logic,_radius_max] spawn FUNC(handleCSGas);};
								[_unit] call KAT_breathing_fnc_handleBreathing;
								_isinGas = false;
							};

							if(_timeleft <= 0 && _unit getVariable [QGVAR(enteredPoisen),false]) then {
								_unit setVariable [QGVAR(poisenType),_gastype,true];
								if(_gastype isEqualTo "Toxic") then {_unit setVariable [QGVAR(airPoisend),true,true];};
								if(_gastype isEqualTo "CS") then {_unit setVariable [QGVAR(CS),true,true]; [_logic,_radius_max] spawn FUNC(handleCSGas);};
								[_unit] call KAT_breathing_fnc_handleBreathing;
								_isinGas = false;
							};

							if (!(_unit getVariable [QGVAR(enteredPoisen),false]) || !(_logic getVariable[QGVAR(gas_active),false])) then {
								
								_isinGas = false;
								_unit setVariable [QGVAR(enteredPoisen),false];
							};
						},
						[_unit,_timeEntered,_logic,_gastype,_radius_max],
						1
					] call CBA_fnc_waitAndExecute;
				};

			} else {
				if(_unit getVariable [QGVAR(enteredPoisen),false]) then {
					_unit setVariable [QGVAR(poisenType),_gastype,true];
					if(_gastype isEqualTo "Toxic") then {_unit setVariable [QGVAR(airPoisend),true,true];};
					if(_gastype isEqualTo "CS") then {_unit setVariable [QGVAR(CS),true,true]; [_logic,_radius_max] spawn FUNC(handleCSGas);};
					[_unit] call KAT_breathing_fnc_handleBreathing;
				};
			};
		};
		

			private _prozent = 1;
			for "_i" from 0 to 1 step 0 do {
				[
					{
						params["_prozent","_radius_max","_radius_min","_unit","_timeEntered","_logic","_gastype"];
						_pos = _logic getVariable [QGVAR(gas_pos),[0,0,0]];
						private _distance = _unit distance _pos;
						private _min_to_max = _radius_max - _radius_min;
						private _dis_to_min = _distance - _radius_min;
						if(_distance > _radius_min) then {
							_prozent = 1-(_dis_to_min/_min_to_max);
							if(_prozent > 1) then {_prozent = 1};
						} else {
							_prozent = 1;
						};
						_unitTime = _unit getVariable [QGVAR(timeleft),60];
						_unitTime = _unitTime - _prozent;
						_unit setVariable [QGVAR(timeleft),_unitTime];
						_unit setVariable [QGVAR(gasPercentage),_prozent];
						if(_unitTime <= 0) exitWith {
							[_unit,_timeEntered,_logic,_gastype,_radius_max] spawn _fnc_kat_afterwait;
							_unit setVariable [QGVAR(timeleft),0];
							_i = 2;
						};
							
						if ( _unit distance _pos > _radius_max || !(_logic getVariable[QGVAR(gas_active),false]) || isNull _logic ) exitWith {
							_unit setVariable[QGVAR(enteredPoisen),false,true];
							_i = 2;
						};

						if(_gastype isEqualTo "CS") exitWith {
							_i = 2;
							[_unit,_timeEntered,_logic,_gastype,_radius_max] spawn _fnc_kat_afterwait;
						};
					},
					[_prozent,_radius_max,_radius_min,_unit,_timeEntered,_logic,_gastype],
					1
				] call CBA_fnc_waitAndExecute;
				
			};

	};
};