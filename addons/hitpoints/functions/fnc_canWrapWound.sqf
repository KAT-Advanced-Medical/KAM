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

private _bandagedWounds = _patient getVariable [VAR_BANDAGED_WOUNDS, []];
if (isNil "_bandagedWounds") exitWith {false};

private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_bodyPart, []];
if (_bandagedWoundsOnPart isEqualTo []) exitWith {false};

private _includedTypes = ["Compressed_Gauze", "fourByfour_Gauze"];

{
    private _bandageType = _x param [4, ""];
    if (_bandageType in _includedTypes) exitWith {true};
} forEach _bandagedWoundsOnPart;

false