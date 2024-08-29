#include "..\script_component.hpp"
/*
 * Author: tcvm
 * Modified by MiszczuZPolski
 * Picks up the stretcher and adds it to the player launcher slot.
 *
 * Arguments:
 * 0: Tripod <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call kat_stretcher_fnc_packIntoBag;
 *
 * Public: No
 */

[{
    params ["_stretcher", "_player"];
    TRACE_2("assemble_pickupTripod",_stretcher,_player);

    private _classname = "kat_CarryStretcherBag";

    private _onFinish = {
        params ["_args"];
        _args params ["_stretcher", "_player", "_classname"];
        TRACE_3("assemble_pickupTripod finish",_stretcher,_player,_classname);

        // Save tripod position before it's deleted
        private _stretcherPos = getPosATL _stretcher;

        // Eject dead units (all crew are dead at this point, otherwise condition would have failed), but ignore UAV units
        {
            if (unitIsUAV _x) then {
                _stretcher deleteVehicleCrew _x;
            } else {
                moveOut _x;
            };
        } forEach (crew _stretcher);

        deleteVehicle _stretcher;

        [_player, "PutDown"] call ACEFUNC(common,doGesture);

        // If the player has space, give it to him
        if ((alive _player) && {(secondaryWeapon _player) == ""}) exitWith {
            [_player, _classname] call CBA_fnc_addWeaponWithoutItems;
        };

        // Try to find existing weapon holders
        private _weaponHolder = nearestObject [_stretcherPos, "WeaponHolder"];

        // If there are none or too far away, make a new one
        if (isNull _weaponHolder || {_stretcherPos distance _weaponHolder > 2}) then {
            _weaponHolder = createVehicle ["GroundWeaponHolder", [0, 0, 0], [], 0, "CAN_COLLIDE"];
            _weaponHolder setDir random [0, 180, 360];
            _weaponHolder setVehiclePosition [_stretcherPos, [], 0, "CAN_COLLIDE"]; // Places object on surface below
        };

        _weaponHolder addWeaponCargoGlobal [_classname, 1];
    };

    private _condition = {
        params ["_args"];
        _args params ["_stretcher"];

        _stretcher call FUNC(canPackIntoBag)
    };

    TRACE_3("",4,typeOf _stretcher,_classname);
    [TIME_PROGRESSBAR(4), [_stretcher, _player, _classname], _onFinish, {}, LLSTRING(PickupStretcher_progressBar), _condition] call ACEFUNC(common,progressBar);
}, _this] call CBA_fnc_execNextFrame;