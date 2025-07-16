#include "..\script_component.hpp"
/*
 * Author: DiGii
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Bool
 *
 * Example:
 * [player] call kat_chemical_fnc_hasDetector;
 *
 * Public: No
*/

params ["_unit"];

if ("KAT_ChemicalDetector" in assignedItems _unit) exitWith {
    true
};

false
