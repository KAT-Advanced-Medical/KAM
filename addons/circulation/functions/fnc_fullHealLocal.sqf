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
 * [player] call kat_circulation_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal",_patient);

_patient setVariable [QGVAR(cprCount), 2, true];
_patient setVariable [QGVAR(heartRestart), false, true];
_patient setVariable [QGVAR(cardiacArrestType), 0, true];

_patient setVariable [VAR_BLOODPRESSURE_CHANGE, nil, true];

_patient setVariable [QGVAR(isPerformingCPR), false, true];
_patient setVariable [QGVAR(OxygenationPeriod), 0, true];

[_patient] call FUNC(updateInternalBleeding);
