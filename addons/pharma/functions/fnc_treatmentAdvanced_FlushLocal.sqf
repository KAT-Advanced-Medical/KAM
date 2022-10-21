#include "script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Locates and Removes 1x Morphine after the administration of Naloxone.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Medication <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "Naloxone"] call aceP_circulation_fnc_treatmentAdvanced_NaloxoneLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;
private _IVarray = _patient getVariable [QGVAR(IV), [0,0,0,0,0,0]];
private _IVactual = _IVarray select _partIndex;

_IVarray set [_partIndex, 4];
_patient setVariable [QGVAR(IV), _IVarray, true];

[_patient, "activity", LLSTRING(flush_log), [[_medic] call ace_common_fnc_getName, [_patient] call ace_common_fnc_getName]] call ace_medical_treatment_fnc_addToLog;