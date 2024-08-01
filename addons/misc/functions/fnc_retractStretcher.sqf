#include "..\script_component.hpp"

/*
 * Author: Battlekeeper, modified by YetheSamartaka and Tomcat
 * Handles the behaviour of Helistretcher - attaching it and using it.
 *
 *
 * Example:
 * [_unit,_item] call kat_misc_fnc_heliStretcherAttach;
 *
 * Public: No
 */

params ["_player","_target"];

private _stretcher = _target getVariable [QGVAR(stretcher), objNull];
private _ropes = _target getVariable [QGVAR(ropes), []];

{
	private _rope = _x;
	if (!isNull _rope) then {
		ropeUnwind [_rope, 2, -(ropeLength _rope), true];
	};
} forEach _ropes;


// [{
// 	params ["_target", "_stretcher", "_ropes"];

// 	private _crew = crew _stretcher;
// 	if (count _crew > 0) then {
// 		{
// 			_x leaveVehicle _stretcher;
// 			moveOut _x;

// 			_x assignAsCargo _target;
//     		_x moveInCargo _target;
// 		} forEach _crew;
// 	};

// 	{
// 		if (!isNull _x) then {
// 			ropeDestroy _x;
// 		};
// 	} forEach _ropes;

// 	deleteVehicle _stretcher;

// 	private _stretcher = createVehicle ["kat_stretcher", (_target modelToWorld [0,0,-5])];
// 	_stretcher attachTo [_target, [0,0,-.1], "slingload0"];
// 	_target setVariable [QGVAR(isStretcherAttached), true, true];
// 	_target setVariable [QGVAR(stretcher), _stretcher, true];
// 	_target setVariable [QGVAR(stretcherDeployed), false, true];

// }, [_target, _stretcher, _ropes], 10] call CBA_fnc_waitAndExecute;

[{
	params ["_target", "_stretcher", "_ropes"];

	private _rope = _ropes select 0;
	ropeUnwound _rope;
}, 
{
    params ["_target", "_stretcher", "_ropes"];

	private _crew = crew _stretcher;
	if (count _crew > 0) then {
		{
			_x leaveVehicle _stretcher;
			moveOut _x;

			_x assignAsCargo _target;
    		_x moveInCargo _target;
		} forEach _crew;
	};

	{
		if (!isNull _x) then {
			ropeDestroy _x;
		};
	} forEach _ropes;

	deleteVehicle _stretcher;

	private _stretcher = createVehicle ["kat_stretcher", (_target modelToWorld [0,0,-5])];
	_stretcher attachTo [_target, [0,0,-.1], "slingload0"];
	_target setVariable [QGVAR(isStretcherAttached), true, true];
	_target setVariable [QGVAR(stretcher), _stretcher, true];
	_target setVariable [QGVAR(stretcherDeployed), false, true];

}, [_target, _stretcher, _ropes]] call CBA_fnc_waitUntilAndExecute;
