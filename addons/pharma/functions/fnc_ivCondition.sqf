#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks if an IV is present and medication can be pushed
 * Note: Patient may not be local
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Check IV Condition <BOOLEAN>
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_pharma_fnc_ivCondition;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _removeIV = [_medic, _patient, _bodyPart] call FUNC(removeIV);
private _ivType = [_medic, _patient, _bodyPart] call FUNC(checkIVType); 
private _return = false;

if (_removeIV == true && _ivType != 3) then {
    _return = true;
} else {
    _return = false;
};

_return