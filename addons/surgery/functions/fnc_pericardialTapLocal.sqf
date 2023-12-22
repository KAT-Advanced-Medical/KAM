#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for running the Pericardial Tap.
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_ultraAssessmentLocal
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
_ht deleteAt (_ht find "tampo");
_patient setVariable [QEGVAR(circulation,ht), _ht, true];

_patient setVariable [QEGVAR(circulation,effusion), 0, true];
_patient setVariable [QGVAR(imaging), false, true];
