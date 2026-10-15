#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Whether the unit has a dosimeter assigned (in the watch slot).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Bool
 *
 * Example:
 * [player] call kat_chemical_fnc_hasDosimeter;
 *
 * Public: No
 */

params ["_unit"];

"KAT_Dosimeter" in assignedItems _unit
