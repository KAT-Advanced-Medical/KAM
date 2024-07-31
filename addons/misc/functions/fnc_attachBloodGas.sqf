#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks patient temperature
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 * 4: Item User (not used) <OBJECT>
 * 5: Used Item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call kat_hypothermia_fnc_useHandWarmer;
 *
 * Public: No
 */
params ["_entries"];

private _bloodGas = _entries select 0;
private _bloodGasArray = _bloodGas select 1;
private _patient = _entries select 1;

_patient setVariable [QEGVAR(circulation,testedBloodGas), _bloodGasArray, true];

[(_entries select 3), (format ["KAT_bloodTest_%1",(_entries select 2)])] call CBA_fnc_removeItemCargo;