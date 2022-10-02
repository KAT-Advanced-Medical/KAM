#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Lorazepam sedating process
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_LorazepamLocal;
 *
 * Public: No
 */

params ["_patient"];

_patient setVariable [QGVAR(sedated), true, true];
[_patient, true] call ace_medical_fnc_setUnconscious;