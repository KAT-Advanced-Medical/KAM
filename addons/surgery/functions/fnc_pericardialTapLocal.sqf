#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call for running the Pericardial Tap.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_pericardialTapLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _ht = _patient getVariable [QEGVAR(circulation,ht), []];
_ht deleteAt (_ht find "tamponade");
_patient setVariable [QEGVAR(circulation,ht), _ht, true];

_patient setVariable [QEGVAR(circulation,effusion), 0, true];
_patient setVariable [QGVAR(imaging), false, true];
