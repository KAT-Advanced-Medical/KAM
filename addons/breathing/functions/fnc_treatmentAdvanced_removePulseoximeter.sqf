#include "script_component.hpp"
/*
 * Author: Katalam
 * Removes a pulseoximeter for a patient and adds Item to the caller
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_breathing_fnc_treatmentAdvanced_removePulseoximeter;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

_patient setVariable [QGVAR(pulseoximeter), false, true];
_medic setVariable [QGVAR(PulseOximeter_Volume), _patient getVariable QGVAR(PulseOximeter_VolumePatient), true];

private _attachedPulseOximeter = _patient getVariable [QGVAR(PulseOximeter_Attached), [0,0]];
_attachedPulseOximeter set [(ALL_BODY_PARTS find toLower _bodyPart)-2,0];
_patient setVariable [QGVAR(PulseOximeter_Attached), _attachedPulseOximeter, true];

[_medic, "kat_Pulseoximeter", 1] call ACEFUNC(common,addToInventory);
