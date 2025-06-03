#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Checks if the unit has a tourniquet applied on the specified body part.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Body Part <STRING>
 * 2: Type <STRING>
 * Return Value:
 * Bool
 *
 * Example:
 * [player, "leftleg"] call ace_medical_treatment_fnc_hasRemovableBandage
 *
 * Public: No
 */

params ["_unit", "_bodyPart", "_bandageType"];
private _bandagedWounds = GET_BANDAGED_WOUNDS(_patient);
private _bandagedWoundsOnPart = _bandagedWounds getOrDefault [_bodyPart, []];

private _hasRemovableBandage = false;

{
    private _candidate = _x;
        _candidate params ["_id", "_amount", "_bleedRate", "", "_type"];

        if (_type ==_bandageType) exitWith {
            _hasRemovableBandage = true;
        };
    } forEach _bandagedWoundsOnPart;
TRACE_1("HasBandag",_hasRemovableBandage);
_hasRemovableBandage