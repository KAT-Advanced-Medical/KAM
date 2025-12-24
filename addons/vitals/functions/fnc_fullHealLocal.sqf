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
 * [player] call kat_vitals_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];

_patient setVariable [QGVAR(simpleMedical), false, true];
_patient setVariable [QGVAR(respiratoryDepth), DEFAULT_RESPIRATORY_DEPTH, true];
_patient setVariable [QGVAR(fatigueEnabled), (missionNamespace getVariable [QACEGVAR(advanced_fatigue,enabled), false]), true];
_patient setVariable [QGVAR(currentWeight), [_patient] call FUNC(generateDefaultWeight), true];
_patient setVariable [QGVAR(mapIntegral), 0, true];
_patient setVariable [QGVAR(svMemory), 0.0810542, true];
_patient setVariable [QGVAR(csCO2Memory), 40, true];
_patient setVariable [QGVAR(breathingState), 0, true];
_patient setVariable [QGVAR(biotTimer), 0, true];
_patient setVariable [QGVAR(biotState), "breath", true];
_patient setVariable [QGVAR(agonalTimer), 0, true];
_patient setVariable [QGVAR(rrMemory), 0, true];
_patient setVariable [QGVAR(shockClass), "NONE", true];
_patient setVariable [QGVAR(ataxicRate), 0, true];
_patient setVariable [QGVAR(ataxicDepth), 0, true];
_patient setVariable [QGVAR(ataxicTimer), 0, true];

_patient setVariable [QGVAR(pao2_prev), 90, true];
if (GVAR(enableSimpleMedical)) then {
    _patient setVariable [QGVAR(simpleMedical), true, true];
};
