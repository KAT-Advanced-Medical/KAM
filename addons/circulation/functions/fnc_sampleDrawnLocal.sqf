#include "..\script_component.hpp"
/*
 * Author: Claude
 * Reply handler run on the medic's own machine once the server has processed a
 * blood sample draw. Gives the physical sample item, or tells the medic the
 * draw failed.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Result: "ok", "invalid" (patient no longer exists) or "full" (no slot free) <STRING>
 * 2: Sample slot id, -1 on failure <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "ok", 3] call kat_circulation_fnc_sampleDrawnLocal;
 *
 * Public: No
 */

params ["_medic", "_result", "_id"];

if (_result == "invalid") exitWith {
    [LLSTRING(ArterialTest_Invalid), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

if (_result == "full") exitWith {
    [LLSTRING(ArterialTest_NoSlots), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

[_medic, (format ["KAT_bloodSample_%1", _id]), true] call CBA_fnc_addItem;
