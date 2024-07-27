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

//if (!(isPlayer _unit)) then { _patient setVariable [QGVAR(simpleMedical), true, true] };

_patient setVariable [QGVAR(simpleMedical), false, true];

_patient setVariable [QGVAR(cprCount), 2, true];
_patient setVariable [QGVAR(heartRestart), false, true];
_patient setVariable [QGVAR(cardiacArrestType), 0, true];

_patient setVariable [VAR_BLOODPRESSURE_CHANGE, nil, true];

_patient setVariable [QGVAR(ISP), 10000, true];
_patient setVariable [QGVAR(SRBC), 500, true];
_patient setVariable [QGVAR(ECP), 3300, true];
_patient setVariable [QGVAR(ECB), 2700, true];

_patient setVariable [QGVAR(isPerformingCPR), false, true];
_patient setVariable [QGVAR(OxygenationPeriod), 0, true];

// PaCO2, PaO2, O2 Sat, HCO3, pH
_patient setVariable [QGVAR(bloodGas), [40.00, 90.00, 0.9600, 24.00, 7.400, 37]];

_patient setVariable [QGVAR(ht), [], true];
_patient setVariable [QGVAR(effusion), 0, true];

_patient setVariable [QGVAR(temperature), 37, true];

[_patient, true] call FUNC(updateInternalBleeding);

