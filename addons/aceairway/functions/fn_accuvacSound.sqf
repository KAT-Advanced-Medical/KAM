/*
 * Author: Katalam
 * Plays a sound 2 times on the target position.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call kat_aceAirway_fnc_accuvacSound;
 *
 * Public: No
 */

(_this select 0) params ["_caller", "_target"];

if !(_caller getVariable ["kat_aceAirway_sound", false]) then {
    _caller setVariable ["kat_aceAirway_sound", true, true];
    (_this select 0) spawn {
        params ["_caller", "_target"];
        playsound3D ["kat_aceAirway\sounds\Suction.wav", _target, false, getPosASL _target, 6, 1, 15];
        sleep 7;
        _caller setVariable ["kat_aceAirway_sound", false, true];
    };
};

true;
