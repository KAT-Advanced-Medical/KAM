#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Condition Check if you can wrap Wounds on a limb
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>

 * Return Value:
 * Bool
 *
 * Example:
 * [player, cursorTarget, "Head", "FieldDressing"] call kat_hitpoints_fnc_canWrapWound
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];
_bodyPart = toLowerANSI _bodyPart;

private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
TRACE_1("WrappableWounds1",_bandagedWounds);
private _bandagedWoundsOnPart = _bandagedWounds get _bodyPart;
TRACE_1("WrappableWounds2",_bandagedWoundsOnPart);
if (isNil "_bandagedWoundsOnPart" || {_bandagedWoundsOnPart isEqualTo []}) exitWith {
    TRACE_1("No WrappableWounds",_bandagedWoundsOnPart);
    false};

private _includedTypes = ["Compressed_Gauze", "fourByfour_Gauze", "Burn_Dressing", "Hemostatic_Gauze"];

(_bandagedWoundsOnPart findIf {
    (_x param [4, ""]) in _includedTypes
}) != -1