#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Takes the oxygen mask off a patient and gives it to the medic.
 * Stops the oxygen supply and returns the remaining tank to the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_breathing_fnc_removeOxygenMask;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _mask = goggles _patient;

if !(_mask in (missionNamespace getVariable [QGVAR(availOxyMaskList), []])) exitWith {};

// removeGoggles + addToInventory, so the mask isn't lost when the inventory has no room for it
removeGoggles _patient;
[_medic, _mask] call ACEFUNC(common,addToInventory);

// Stop the oxygen supply, unless other oxygen equipment (e.g. an oxygen helmet) still counts as a mask
if (_patient getVariable [QGVAR(oxygenMaskActive), false] && {!(_patient call FUNC(checkOxygenMask))}) then {
    _patient call FUNC(detachPersonalOxygen);
};
