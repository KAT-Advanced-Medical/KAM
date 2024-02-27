#include "..\script_component.hpp"
/*
 * Author: 2LT.Mazinski
 * Locally changes a patient's PH value
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: pH value <NUMBER>
 * 2: Coagulation factors value <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 500, 10] call kat_pharma_fnc_fluidLocal;
 *
 * Public: No
 */

params ["_patient", "_ph", "_coagulation"];

private _current = _patient getVariable [QGVAR(pH), 1500];
private _final = (_current + _ph) max 0;
_final min 1500;
_patient setVariable [QGVAR(pH), (_final), true];

private _coagFactorMax = missionNamespace getVariable [QGVAR(coagulation_factor_limit), 30];
private _factor = _patient getVariable [QGVAR(coagulationFactor), 10];
private _final2 = (_factor + _coagulation) min _coagFactorMax;
_patient setVariable [QGVAR(coagulationFactor), (_final2), true];
