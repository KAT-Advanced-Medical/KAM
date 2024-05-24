#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Handles increasing/decreasing intracranial pressure.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_brain_fnc_handleICP
 *
 * Public: No
 */

// concussion 0: no concussion
// concussion 1: grade 1 concussion, no loss of consciousness
// concussion 2: grade 2 concussion, immediate or delayed LOC
// concussion 3: grade 3 concussion, extended and seizures

 params ["_unit"];

if ((_unit getVariable [QGVAR(icpHandler), false]) || !(GVAR(enable))) exitWith {};
_unit setVariable [QGVAR(icpHandler),true];

if (!local _unit) then {
	[QGVAR(handleICP), [_unit], _unit] call CBA_fnc_targetEvent;
};

[{
	params ["_args","_handle"];
	_args params ["_unit"];
	if !(alive _unit) exitWith {
		_unit setVariable [QGVAR(icpHandler),false];
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

	//todo post processing

	private _icp = _unit getVariable [QGVAR(icp),0];
	private _pr =_unit getVariable [QACEGVAR(medical,heartRate),0];

	private _concussion = _unit getVariable [QGVAR(concussion),0];

	//check for lethal ICP 
	if ((_icp >= 1000) && !(_unit getVariable [QACEGVAR(medical,deathblocked), false])) exitWith {
		[_unit, "terminal_icp_death"] call ACEFUNC(medical_status,setDead);
        _unit setVariable [QGVAR(handleICP), false];
        [_handle] call CBA_fnc_removePerFrameHandler;
	};

	private _icpChange = 0;
	private _output = 0;
	switch _concussion do {
		case 0: {
			// returning to original vitals
			_output = 0 max _output;
		};
		case 1: {
			// mild concussion starts 100 and rises to ~350
			// todo faster rising ICP for higher blood pressure
			_output = 100 max _output; // if ICP is below 100 then it'll be brought up
		};
		case 2: {
			// grade 2 concussion starts 200 and rises to 400-600
		};
		case 3: {
			// severe concussion starts 350 and rises to 1000 
		};
	};

	//todo value floors (prevent decreasing further without proper treatment)

	//todo multipliers

	_unit setVariable [QGVAR(icp), _output, true];
}, 15, [_unit]] call CBA_fnc_addPerFrameHandler; //todo make a setting