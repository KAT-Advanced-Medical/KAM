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
    private _bloodArray = ["O","O","O","O","A","A","A","B","B","AB"];
    private _randomBloodType = selectRandom _bloodArray;
    _target setVariable [QGVAR(bloodtype), _randomBloodType, true];
    _target setVariable ["ace_dogtags_dogtagData", nil, true];
    };
};

_target getVariable [QGVAR(bloodtype), "O"];
