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

	if (_patient getVariable QGVAR(portableOxygenTankConnected)) then {
		if([_medic, ["kat_oxygenTank_300","kat_oxygenTank_150"]] call ACEFUNC(common,hasItem)) then {
			private _carriedOxygenAmount = _medic getVariable [QGVAR(carriedOxygen), -1];

			if !(_carriedOxygenAmount <= 0) then {
				_medic setVariable [QGVAR(carriedOxygen), _carriedOxygenAmount - 0.75, true];
			} else {
				if (_carriedOxygenAmount == -1) then {
					_patient setVariable [QGVAR(providedOxygen), false, true];
					if ([_medic, ["kat_oxygenTank_300"]] call ACEFUNC(common,hasItem)) then {
						_medic RemoveItem "kat_oxygenTank_300";
					} else {
						_medic RemoveItem "kat_oxygenTank_150";
					};
				};
			};
		} else {
			private _classNameObjects = [];
			{
    			if (typeOf _x in ["kat_oxygenTank_300", "kat_oxygenTank_150"]) then {
    			    _className = typeOf _x; 
    			    _classNameObjects pushBack _className;
    			};
			} forEach nearestObjects [position _patient, [], 3];

			if (!(_classNameObjects isEqualTo [])) then {

			};
		};
	};

}, 3, [_medic,_patient]] call CBA_fnc_addPerFrameHandler;