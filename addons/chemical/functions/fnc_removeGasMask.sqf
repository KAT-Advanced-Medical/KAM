#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Takes the gas mask off a patient and gives it to the medic.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_chemical_fnc_removeGasMask;
 *
 * Public: No
*/

params ["_medic", "_patient"];

private _mask = goggles _patient;

if !(_mask in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) exitWith {};

// removeGoggles + addToInventory, so the mask isn't lost when the inventory has no room for it
removeGoggles _patient;
[_medic, _mask] call ACEFUNC(common,addToInventory);
