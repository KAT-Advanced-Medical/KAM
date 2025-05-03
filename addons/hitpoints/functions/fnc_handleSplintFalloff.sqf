#include "..\script_component.hpp"
/*
 * Author: PabstMirror
 * Local callback for applying a splint to a patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call ace_medical_treatment_fnc_splintLocal
 *
 * Public: No
 */

params ["_unit", "_bodyPart"];
[{
    params ["_unit", "_bodyPart"];

    private _partIndex = ALL_BODY_PARTS find toLowerANSI _bodyPart;
    private _fractures = GET_FRACTURES(_unit);
    if (_fractures select _partIndex == -1) then {
        _fractures set [_partIndex, 1];
        _unit setVariable [VAR_FRACTURES, _fractures, true];
    }
}, [_unit, _bodyPart], 180] call CBA_fnc_waitAndExecute;


