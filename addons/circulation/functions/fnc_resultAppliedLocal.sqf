#include "..\script_component.hpp"
/*
 * Author: Claude
 * Reply handler run on the medic's own machine once the server has processed
 * applying a blood gas result to a patient. Removes the consumed result item,
 * or tells the medic the result was no longer available.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Result: "ok" or "invalid" (result no longer exists) <STRING>
 * 2: Result slot id, -1 on failure <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "ok", 5] call kat_circulation_fnc_resultAppliedLocal;
 *
 * Public: No
 */

params ["_medic", "_result", "_resultId"];

if (_result != "ok") exitWith {
    [LLSTRING(ArterialTest_Invalid), 1.5, _medic] call ACEFUNC(common,displayTextStructured);
};

_medic removeItem (format ["KAT_bloodResult_%1", _resultId]);
