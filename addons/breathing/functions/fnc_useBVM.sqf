#include "script_component.hpp"
/*
 * Author: Blue
 * Handles BVM usage.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_useBVM;
 *
 * Public: No
 */

params ["_medic", "_patient"];

[{
    params ["_args", "_idPFH"];
    _args params ["_medic","_patient"];
    if !(_patient getVariable [QGVAR(BVMInUse), false]) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };

	if (_patient getVariable [QGVAR(portableOxygenTankConnected),false]) then {
		if([_medic, "kat_oxygenTank_300"] call ACEFUNC(common,hasMagazine)) then {
			[_medic, "kat_oxygenTank_300"] call EFUNC(pharma,removeItemfromMag);
		} else {
			if([_medic, "kat_oxygenTank_150"] call ACEFUNC(common,hasMagazine)) then {
				[_medic, "kat_oxygenTank_150"] call EFUNC(pharma,removeItemfromMag); 
			} else {
				_patient setVariable [QGVAR(portableOxygenTankConnected),false,false];
			};
		};
	};

}, 3, [_medic,_patient]] call CBA_fnc_addPerFrameHandler;