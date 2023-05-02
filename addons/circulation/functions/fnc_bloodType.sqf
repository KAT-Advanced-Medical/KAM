#include "script_component.hpp"
/*
 * Author: Katalam, modified by YetheSamartaka, Blue
 * Reports a blood type depending on the unit. If the unit is AI and it does not have blood type yet assigned
 * it will randomly assign it thus saving setting unnecessary variable.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Blood type <STRING>
 *
 * Example:
 * [cursorTarget] call kat_circulation_fnc_bloodType;
 *
 * Public: No
 */

params ["_unit"];

if (isNil {_unit getVariable QGVAR(bloodtype)}) then {
    if (!(isPlayer _unit)) then {
        private _randomBloodType = selectRandomWeighted ["A", 0.3, "A_N", 0.08, "B", 0.09, "B_N", 0.02, "AB", 0.02, "AB_N", 0.01, "O", 0.35, "O_N", 0.13];
        _unit setVariable [QGVAR(bloodtype), _randomBloodType, true];
        _unit setVariable [QACEGVAR(dogtags,dogtagData), nil, true];
    } else {
        _unit setVariable [QGVAR(bloodtype), [_unit, objNull] call FUNC(generateBloodType), true];
    };
};

_unit getVariable [QGVAR(bloodtype), "O_N"];
