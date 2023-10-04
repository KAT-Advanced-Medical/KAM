#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Removes provided items from players inventory with set ammount.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Items, Number <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [["ACE_tourniquet", 5],["ACE_packingBandage", 10]]] call kat_misc_fnc_arrayToRemoveInvItem;
 *
 * Public: No
 */

params ["_unit", "_removeItemArray"];

{
    for "_i" from 1 to (_x select 1) do
    {
        _unit removeItem (_x select 0);
    } 
} foreach _removeItemArray;