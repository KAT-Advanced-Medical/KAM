#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_breathing_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

_patient setVariable [QGVAR(airwayStatus), 100, true];
_patient setVariable [QGVAR(pneumothorax), 0, true];
_patient setVariable [QGVAR(hemopneumothorax), false, true];
_patient setVariable [QGVAR(tensionpneumothorax), false, true];
_patient setVariable [QGVAR(activeChestSeal), false, true];
_patient setVariable [QGVAR(deepPenetratingInjury), false, true];

if (ACEGVAR(advanced_fatigue,enabled)) then {
    ["kat_LSDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
};
