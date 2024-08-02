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

private _bloodGas = _entries select 0;
private _bloodGasArray = _bloodGas select 1;
private _patient = _entries select 1;

_patient setVariable [QGVAR(testedBloodGas), _bloodGasArray, true];

[(_entries select 3), (format ["KAT_bloodTest_%1",(_entries select 2)])] call CBA_fnc_removeItemCargo;