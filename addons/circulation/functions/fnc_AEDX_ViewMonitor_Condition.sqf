#include "..\script_component.hpp"
/*
 * Author: Blue
 * Checks if monitor can be viewed on patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Can view monitor <BOOL>
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_AEDX_ViewMonitor_Condition
 *
 * Public: No
 */

params ["_medic", "_patient"];

(_patient getVariable [QGVAR(DefibrillatorPads_Connected), false]) && (_patient getVariable [QGVAR(Defibrillator_Provider), nil]) select 2 isEqualTo "kat_X_AED";
