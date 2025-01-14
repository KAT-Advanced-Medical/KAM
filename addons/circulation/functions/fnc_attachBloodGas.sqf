#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Attaches ABG test to patient
 *
 * Arguments:
 * 0: Array <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[[40,90,0.96,24,7.4,37], "Patient"], patient] call kat_circulation_fnc_attachBloodGas;
 *
 * Public: No
 */
params ["_entries"];
_entries params ["_bloodGas", "_patient", "_idNumber", "_player"];

_patient setVariable [QGVAR(testedBloodGas), _bloodGas, true];

_player removeItem (format ["KAT_bloodResult_%1",_idNumber]);