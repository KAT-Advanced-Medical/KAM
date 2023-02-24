#include "script_component.hpp"
/*
 * Author: Katalam, modified by YetheSamartaka
 * Reports a blood type depending on the unit. If the unit is AI and it does not have bloodtype yet assigned
 * it will randomly assign it thus saving setting unnecesary variable.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget] call kat_circulation_fnc_bloodType;
 *
 * Public: No
 */

params ["_unit"];

if (_unit != player) then {
        if (isNil {_unit getVariable QGVAR(bloodtype)}) then {
        private _randomBloodType = selectRandomWeighted ["O",0.35,"O_N",0.13,"A",0.3,"A_N",0.08,"B",0.08,"B_N",0.02,"AB",0.02,"AB_N",0.01];
        _unit setVariable [QGVAR(bloodtype), _randomBloodType, true];
        _unit setVariable [QACEGVAR(dogtags,dogtagData), nil, true];
    };
};

_unit getVariable [QGVAR(bloodtype), "O_N"];
