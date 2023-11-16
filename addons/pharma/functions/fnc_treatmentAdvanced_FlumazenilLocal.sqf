#include "..\script_component.hpp"
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
 * [player] call kat_pharma_fnc_treatmentAdvanced_FlumazenilLocal;
 *
 * Public: No
 */

params ["_patient"];

_patient setVariable [QEGVAR(surgery,sedated), false, true];
