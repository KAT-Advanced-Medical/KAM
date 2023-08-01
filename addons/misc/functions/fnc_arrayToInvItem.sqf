#include "script_component.hpp"
/*
 * Author: Miss Heda, Digii
 * Adds provided items to inventory with set ammount.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Items, Number <ARRAY>
 * 2: Container (uniform, vest, backpack) (default: "") <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [[ACE_tourniquet, 5],[ACE_packingBandage, 10]], "Backpack"] call kat_misc_fnc_arrayToInvItem;
 *
 * Public: No
 */

params ["_unit", "_array", "_container"];

{
	for "_i" from 1 to (_x select 1) do
	{
		[_unit, _x select 0, _container] call ACEFUNC(common,addToInventory);
	} 
} foreach _array;