#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for set patient into recovery position.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>

 *
 * Return Value:
 * Successful treatment
 *
 * Example:
 * call kat_airway_fnc_RecoveryPositionLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QGVAR(recovery), true, true];
_patient setVariable [QGVAR(overstretch), true, true];
_patient setVariable ["KAT_medical_airwayOccluded", false, true];

private _output = localize LSTRING(Recovery_Info);
[_output, 2, _medic] call ace_common_fnc_displayTextStructured;

[_patient, "activity", LSTRING(RecoveryPosition_Log), [[_medic] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;

[{
    params ["_medic", "_patient"];
    (_patient call ace_medical_status_fnc_isBeingDragged) || (_patient call ace_medical_status_fnc_isBeingCarried) || !(isNull objectParent _patient);
}, {
    params ["_medic", "_patient"];
    _patient setVariable [QGVAR(recovery), false, true];
    _patient setVariable [QGVAR(overstretch), false, true];

    _output = localize LSTRING(Recovery_Cancel);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
}, [_medic, _patient], 3600, {
    params ["_medic","patient"];
    _patient setVariable [QGVAR(recovery), false, true];
    _patient setVariable [QGVAR(overstretch), false, true];
    
    _output = localize LSTRING(Recovery_Cancel);
    [_output, 1.5, _medic] call ace_common_fnc_displayTextStructured;
}] call CBA_fnc_waitUntilAndExecute;

true;