#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Flumazenil unsedating process
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_TXALocal;
 *
 * Public: No
 */

params ["_patient"];

_target setVariable [QGVAR(sedated), false, true];