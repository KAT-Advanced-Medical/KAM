#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Handles starting the AED treatment.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_circulation_fnc_AEDStart
 *
 * Public: No
 */

params ["_medic", "_patient"];

_patient setVariable [QACEGVAR(medical,CPR_provider), _medic, true];
_patient setVariable [QGVAR(AEDinUse), true, true];
