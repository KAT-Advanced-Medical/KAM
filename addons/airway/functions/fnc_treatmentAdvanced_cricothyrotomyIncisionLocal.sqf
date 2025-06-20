#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local call to start the surgical process for a chest tube
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Side <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, 1] call kat_breathing_treatmentAdvanced_cricothyrotomyIncisionLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _cricothyrotomy = _patient getVariable [QGVAR(cricothyrotomy), 0];

_cricothyrotomy = _cricothyrotomy + 0.1;
_patient setVariable [QGVAR(cricothyrotomy), _cricothyrotomy, true];




[_patient, false] call ACEFUNC(dragging,setCarryable);
[_patient, false] call ACEFUNC(dragging,setDraggable);

[_patient, "quick_view", LSTRING(incision_log), [[_medic] call ACEFUNC(common,getName), STRING_BODY_PARTS select 1]] call ACEFUNC(medical_treatment,addToLog);


