#include "..\script_component.hpp"
/*
 * Author: Claude
 * Reply handler run on the machine of whoever last held a blood sample/result
 * item whose slot fnc_serverSweepExpiredSamples has just freed. Removes the
 * stale item locally and notifies the holder, so a reused slot id can't later
 * be tested/applied against a leftover item.
 *
 * Arguments:
 * 0: Holder <OBJECT>
 * 1: Item classname <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "KAT_bloodSample_5"] call kat_circulation_fnc_itemExpiredLocal;
 *
 * Public: No
 */

params ["_holder", "_itemClass"];

_holder removeItem _itemClass;

[LLSTRING(ArterialTest_Expired), 1.5, _holder] call ACEFUNC(common,displayTextStructured);
