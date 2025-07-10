#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Local callback for fully healing a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_conversion_fnc_fullHealLocal
 *
 * Public: No
 */

params ["_patient"];

if (hasInterface && GVAR(enable)) then {
    _patient setVariable [QGVAR(convert), true, true];
};

_patient setVariable [QGVAR(currentConverted), false, true];
_patient setVariable [QGVAR(associatedPlayer), player, true];