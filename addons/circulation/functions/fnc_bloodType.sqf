#include "script_component.hpp"
/*
 * Author: Katalam, modified by YetheSamartaka
 * Reports a blood type depending on the unit. If the unit is AI and it does not have bloodtype yet assigned
 * it will randomly assign it thus saving setting unnecesary variable.
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * 0: Blood type <STRING>
 *
 * Example:
 * [cursorTarget] call kat_circulation_fnc_bloodType;
 *
 * Public: No
 */

params ["_target"];

if (_target != player) then {
	if (isNil {_target getVariable QGVAR(bloodtype)}) then {
	private _randomBloodType = selectRandomWeighted ["O+",0.35,"O-",0.13,"A+",0.3,"A-",0.08,"B+",0.08,"B-",0.02,"AB+",0.02,"AB-",0.01];
	_target setVariable [QGVAR(bloodtype), _randomBloodType, true];
    _target setVariable ["ace_dogtags_dogtagData", nil, true];
	};
};

_target getVariable [QGVAR(bloodtype), "O"];
