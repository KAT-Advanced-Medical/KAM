#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Callback to wrap a splint on a bodypart
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>

 * Return Value:
 * None
 *
 * Example:
 * [player, "rightleg"] call kat_hitpoints_fnc_wrapJoint
 *
 * Public: No
 */
params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find _bodyPart;
private _jointArray = GET_JOINTS(_patient);
private _jointGroupIndex = switch (true) do {
case (_partIndex in [4, 5]): { 0 };
case (_partIndex in [6, 7]): { 1 };
case (_partIndex in [8, 9]): { 2 };
case (_partIndex in [10, 11]): { 3 };
default { -1 };
};

private _limbJointStatus = _jointArray select _jointGroupIndex;
private _selectedJointIndexes = if (["upper", _bodyPart] call BIS_fnc_inString) then {
    [0, 1]
} else {
    [1, 2]
};
{
    private _jointInjury = _limbJointStatus select _x;
    if (_jointInjury in [7, 8]) exitWith {
        _limbJointStatus set [_x, _jointInjury + 3];
        [_patient] call EFUNC(misc,updateDamageEffects);
        private _delay = random [300, 450, 600];
        [{
            params ["_x", "_patient", "_limbJointStatus"];
            _limbJointStatus set [_x, 0];
            [_patient] call EFUNC(misc,updateDamageEffects);
        }, [_x, _patient, _limbJointStatus], _delay] call CBA_fnc_waitAndExecute;
    };
} forEach _selectedJointIndexes;
    
