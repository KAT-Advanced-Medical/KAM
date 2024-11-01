#include "..\script_component.hpp"

/*
 * Author: MiszczuZPolski
 * Lowers helistretcher by 10m
 *
 * Arguments:
 * 0: Helicopter <OBJECT>
 *
 * Example:
 * [cursorObject] call kat_stretcher_fnc_lowerHeliStretcher;
 *
 * Public: No
 */

params ["_target"];

#define MAX_LENGTH 50

private _stretcher = _target getVariable [QGVAR(stretcher), objNull];
private _ropes = _target getVariable [QGVAR(ropes), []];

{
    private _rope = _x;
    if (!isNull _rope && ropeLength _rope <= MAX_LENGTH) then {
        ropeUnwind [_rope, 2, 10, true];
    };
} forEach _ropes;
