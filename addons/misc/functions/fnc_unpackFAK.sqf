#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Gives the player the predefined Items (in CBA) for every FAK varient
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: String
 * 2: Number
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "kat_IFAK", 0] call kat_misc_fnc_unpackFAK;
 *
 * Public: No
 */

params ["_unit", "_item", "_firstAidKitVarient"];

private _firstSlotItemIFAK = missionNamespace getVariable [QGVAR(IfakFirstSlotItem), []];
private _firstSlotAmountIFAK = missionNamespace getVariable [QGVAR(IFAKFirstSlotAmount), []];

private _firstSlotItemAFAK = missionNamespace getVariable [QGVAR(IfakFirstSlotItem), []];
private _firstSlotAmountAFAK = missionNamespace getVariable [QGVAR(IFAKFirstSlotAmount), []];

private _firstSlotItemMFAK = missionNamespace getVariable [QGVAR(IfakFirstSlotItem), []];
private _firstSlotAmountMFAK = missionNamespace getVariable [QGVAR(IFAKFirstSlotAmount), []];








[_unit, _firstSlotItemIFAK, "", _firstSlotAmountIFAK] call ACEFUNC(common,addToInventory);
