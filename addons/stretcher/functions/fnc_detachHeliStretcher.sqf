#include "..\script_component.hpp"

/*
 * Author: MiszczuZPolski
 * Detaches helistretcher from helicopter
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Helicopter <OBJECT>
 *
 * Example:
 * [player, cursorObject] call kat_stretcher_fnc_detachHeliStretcher;
 *
 * Public: No
 */

params ["_player","_target"];

[_player, "kat_helistretcher"] call ACEFUNC(common,addToInventory);

private _stretcher = _target getVariable [QGVAR(stretcher), objNull];
deleteVehicle _stretcher;
_target setVariable [QGVAR(stretcher), objNull, true];

private _ropes = _target getVariable [QGVAR(ropes), []];
{
    if (!isNull _x) then {
        deleteVehicle _x;
    };
} forEach _ropes;
_target setVariable [QGVAR(ropes), [], true];

_target setVariable [QGVAR(isStretcherAttached), false, true];



