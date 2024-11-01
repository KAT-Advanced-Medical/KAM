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

_patient setVariable [QGVAR(bodyFluid), DEFAULT_BODY_FLUID];

_patient setVariable [QGVAR(isPerformingCPR), false, true];
_patient setVariable [QGVAR(OxygenationPeriod), 0, true];

_patient setVariable [QGVAR(tourniquetTime), [0,0,0,0,0,0]];

// PaCO2, PaO2, O2 Sat, HCO3, pH, ETCO2
_patient setVariable [QGVAR(bloodGas), DEFAULT_BLOOD_GAS, true];
_patient setVariable [QGVAR(testedBloodGas), [0,0,0,0,0,0], true];

_patient setVariable [QGVAR(ABGmenuShow), false];

_patient setVariable [QGVAR(ht), [], true];
_patient setVariable [QGVAR(effusion), 0, true];

[_patient, true] call FUNC(updateInternalBleeding);

