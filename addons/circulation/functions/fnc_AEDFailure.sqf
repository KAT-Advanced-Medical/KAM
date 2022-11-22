#include "script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Handles failure of the AED treatment.
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

_patient setVariable [QACEGVAR(medical,CPR_provider), objNull, true];
_patient setVariable [QGVAR(AEDinUse), false, true];
_patient setVariable [QGVAR(soundPlayed), false, true];
