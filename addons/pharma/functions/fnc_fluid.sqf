#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski, Mazinski.H
 * Starts ph treatment
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
 * [player, 500, 10] call kat_pharma_fnc_fluid;
 *
 * Public: No
 */

params ["_patient", "_ph", "_coagulation"];

[QGVAR(fluidLocal),[ _patient, _ph, _coagulation], _patient] call CBA_fnc_targetEvent;
