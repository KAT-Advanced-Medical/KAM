#include "..\script_component.hpp"
/*
 * Author: Glowbal, Brett Mayson
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_treatment_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];
TRACE_1("fullHealLocal kat chemical",_patient);

_patient setVariable [QGVAR(enteredPoison), false, true];
_patient setVariable [QGVAR(timeleft), missionNamespace getVariable [QGVAR(infectionTime),60], true];
_patient setVariable [QGVAR(poisonType), "", true];
_patient setVariable [QGVAR(airPoisoning), false, true];
_patient setVariable [QGVAR(CS), false, true];
_patient setVariable [QGVAR(gasmask_durability), 10, true];
if (_patient getVariable [QGVAR(painEffect),0] != 0) then {
    KAT_PAIN_EFFECT ppEffectEnable false;
};
