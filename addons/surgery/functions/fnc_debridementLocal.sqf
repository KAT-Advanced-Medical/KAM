#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Local call for clearing all open wounds on a patient
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_debridementLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart2"];

private _debridement = _patient getVariable [QGVAR(debridement), [0,0,0,0,0,0]];
private _compare = ALL_BODY_PARTS find toLower _bodyPart2;

_debridement set [_compare, 1];
_patient setVariable [QGVAR(debridement), _debridement, true];

{
    _x params ["_id", "_bodyPart", "_amount"];

    if (_bodyPart == _compare) then {
        [QACEGVAR(medical_treatment,bandageLocal), [_patient, _bodyPart2, "Dressing"], _patient] call CBA_fnc_targetEvent;
    };

} forEach GET_OPEN_WOUNDS(_patient);

{
    _x params ["_id", "_bodyPart", "_amount"];

    if (_bodyPart == _compare) then {
        [QACEGVAR(medical_treatment,bandageLocal), [_patient, _bodyPart2, "Dressing"], _patient] call CBA_fnc_targetEvent;
    };

} forEach GET_BANDAGED_WOUNDS(_patient);

[_patient] call ACEFUNC(medical_engine,updateDamageEffects);
[_patient] call ACEFUNC(medical_engine,updateWoundBleedLoss);

