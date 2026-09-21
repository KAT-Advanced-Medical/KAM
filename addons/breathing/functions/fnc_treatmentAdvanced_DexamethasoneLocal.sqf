#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Dexamethasone effect on lung injury. A corticosteroid damps the inflammatory response
 * driving alveolar oedema, so it takes an immediate bite out of the injury and then speeds
 * its resolution for a while - it is a treatment, not a switch.
 *
 * Lives in breathing rather than chemical so that any future lung injury source (smoke
 * inhalation, blast lung) is treatable with the same drug and no chemical dependency.
 *
 * Runs local to the patient, raised by kat_pharma_fnc_medicationLocal.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body part (unused) <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "LeftArm"] call kat_breathing_fnc_treatmentAdvanced_DexamethasoneLocal;
 *
 * Public: No
 */

params ["_patient"];

// Stop the deterioration first, or the recovery below would be fighting an ongoing climb.
_patient setVariable [QGVAR(lungInjuryProgression), 0, true];

private _current = _patient getVariable [QGVAR(lungInjury), 0];

// Extend the accelerated-recovery window even with no injury present, so a prophylactic dose
// before entering a cloud still counts for something.
_patient setVariable [QGVAR(lungInjuryDexUntil), CBA_missionTime + GVAR(lungInjury_dexDuration), true];

if (_current <= 0) exitWith {};

private _new = (_current - GVAR(lungInjury_dexStepDown)) max 0;

_patient setVariable [QGVAR(lungInjury), _new, true];

// Pull the target down with it, otherwise the ramp would immediately undo the step-down.
_patient setVariable [QGVAR(lungInjuryTarget), ((_patient getVariable [QGVAR(lungInjuryTarget), 0]) min _new), true];

TRACE_3("Dexamethasone",_patient,_current,_new);
