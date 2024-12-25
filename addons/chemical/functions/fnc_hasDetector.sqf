#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * Bool
 *
 * Example:
 * [player, cursorTarget] call kat_chemical_fnc_hasGasmask;
 *
 * Public: No
*/

params ["_unit"];

if ("KAT_ChemicalDetector" in assignedItems _unit) exitWith {
    true
};

false