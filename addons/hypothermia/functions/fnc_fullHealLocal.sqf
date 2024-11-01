#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_hypothermia_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

_patient setVariable [QGVAR(unitTemperature), 37, true];
_patient setVariable [QGVAR(warmingImpact), 0, true];
_patient setVariable [QGVAR(handWarmers), [0,0,0,0,0,0], true];
_patient setVariable [QGVAR(fluidWarmer), [0,0,0,0,0,0], true];