#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Handles increasing/decreasing intercranial pressure.
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

	private _icp = _unit getVariable [QGVAR(icp),15];
	private _pr =_unit getVariable [QACEGVAR(medical,heartRate),0];
	private _bp = _unit getVariable [QGVAR(StoredBloodPressure), [0,0]];

	private _concussion = _unit getVariable [QGVAR(concussion),0];

	//check for lethal ICP 
	if ((_icp > 35) && !(_unit getVariable [QACEGVAR(medical,deathblocked), false])) exitWith {
		[_unit, "terminal_icp_death"] call ACEFUNC(medical_status,setDead);
        _unit setVariable [QGVAR(handleICP), false];
        [_handle] call CBA_fnc_removePerFrameHandler;
	};

	private _icpChange = 0;
	if (_concussion isEqualTo 0) then { // no concussion
		if (bp >= 80 && bp <= 160) then { //bp between 80 and 160
			_icpChange = -0.1;
		};
	};
	if (_concussion isEqualTo 1) then { //mild concussion
		if (bp >= 80 && bp <= 160) then { //bp between 80 and 160
			_icpChange = 0.05;
		} else {
			_icpChange = 0.1;
		};
	};
	if (_concussion isEqualTo 2) then { //severe concussion
		if (bp >= 80 && bp <= 160) then { //bp between 80 and 160
			_icpChange = 0.1;
		} else {
			_icpChange = 0.15;
		};
	};

	//todo multipliers

	private _output = _icp + _icpChange;
	_output = 15 max _output;

	_unit setVariable [QGVAR(icp), _output, true];
}, 3, [_unit]] call CBA_fnc_addPerFrameHandler;