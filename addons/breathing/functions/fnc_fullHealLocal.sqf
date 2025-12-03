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
_patient setVariable [QGVAR(pneumothorax), [0, 0], true];
_patient setVariable [QGVAR(pneumothoraxSurfaceArea), [0, 0], true];
_patient setVariable [QGVAR(hemopneumothorax), [0, 0], true];
_patient setVariable [QGVAR(tensionpneumothorax), [false, false], true];
_patient setVariable [QGVAR(activeChestSeal), [false, false], true];
_patient setVariable [QGVAR(deepPenetratingInjury), [false, false], true];
_patient setVariable [QGVAR(etco2Monitor), [], true];
_patient setVariable [QGVAR(breathRate), 15, true];
_patient setVariable [QGVAR(nasalCannula), false, true];
_patient setVariable [QGVAR(lungSurfaceArea), 400];
_patient setVariable [QGVAR(chestTube), [0, 0], true];
_patient setVariable [QGVAR(attachedVent), false, true];
_patient setVariable [QGVAR(attachedVentGUI), false, true];
_patient setVariable [QGVAR(paralysis), 0, true];
_patient setVariable [QGVAR(ventRate), 2, true];
_patient setVariable [QGVAR(BVM_amount), 0, true];
_patient setVariable [QGVAR(BVM_provider), 0, true];
_patient setVariable [QGVAR(bronchospasm), 1, true];

if (ACEGVAR(advanced_fatigue,enabled)) then {
    ["kat_LSDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
};
