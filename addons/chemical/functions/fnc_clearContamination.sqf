#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Clears skin contamination on a patient (mustard or VX) and zeroes the
 * mustard delayed-effect deadlines so the watcher PFH stops firing them.
 *
 * Shared by the self-action progress-bar callback and by the
 * Decontaminate treatment action's callbackSuccess.
 *
 * Arguments:
 * 0: Caller / Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["", "_patient"];

_patient setVariable [QGVAR(chemicalContamination), "", true];
_patient setVariable [QGVAR(mustardDeadline_eye), 0, true];
_patient setVariable [QGVAR(mustardDeadline_burn), 0, true];
_patient setVariable [QGVAR(mustardBurnActive), false, true];

_patient setVariable [QGVAR(radExternalContam), 0, true];
[QGVAR(serverRemoveContamSource), [_patient]] call CBA_fnc_serverEvent;
