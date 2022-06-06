#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Opens an IV/IO on a patient and changes the patient's flow variable
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment (not used) <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "", objNull, "kat_IV_20"] call kat_circulation_fnc_fractureCheck;
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
        ["ace_medical_treatment_bandageLocal", [_patient, _bodyPart2, "Dressing"], _patient] call CBA_fnc_targetEvent;
    };

} forEach GET_OPEN_WOUNDS(_patient);

{
    _x params ["_id", "_bodyPart", "_amount"];

    if (_bodyPart == _compare) then {
        ["ace_medical_treatment_bandageLocal", [_patient, _bodyPart2, "Dressing"], _patient] call CBA_fnc_targetEvent;
    };

} forEach GET_BANDAGED_WOUNDS(_patient);
