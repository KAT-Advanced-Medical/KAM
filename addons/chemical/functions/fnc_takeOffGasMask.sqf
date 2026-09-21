#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Takes the gas mask off a unit and puts it into the inventory of the medic.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient, defaults to the medic <OBJECT> (default: objNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_chemical_fnc_takeOffGasMask;
 *
 * Public: No
*/

params ["_medic", ["_patient", objNull]];

if (isNull _patient) then {
    _patient = _medic;
};

private _mask = goggles _patient;

if !(_mask in (missionNamespace getVariable [QGVAR(availGasmaskList), []])) exitWith {};

// unassignItem loses the mask when the inventory has no room for it
// Remove it and add it back, addToInventory puts it on the ground if it doesn't fit
removeGoggles _patient;
[_medic, _mask] call ACEFUNC(common,addToInventory);
