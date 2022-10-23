#include "script_component.hpp"
/*
 * Author: MiszczuZPolski, Mazinski.H
 * Starts ph treatment
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: PH <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "RightArm", "Flumazenil", objNull, "kat_flumazenil"] call kat_pharma_fnc_treatmentAdvanced_Amiodaron;
 *
 * Public: No
 */

params ["_patient", "_ph", "_coagulation"];

[QGVAR(fluidLocal),[ _patient, _ph, _coagulation], _patient] call CBA_fnc_targetEvent;