#include "script_component.hpp"
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
 * [player, cursorTarget] call kat_airway_fnc_accuvacSound;
 *
 * Public: No
 */

(_this select 0) params ["_medic", "_patient"];

if !(_medic getVariable [QGVAR(sound), false]) then {
    _medic setVariable [QGVAR(sound), true, true];
    (_this select 0) spawn {
        params ["_medic", "_patient"];
        playsound3D [QPATHTOF_SOUND(sounds\suction.wav), _patient, false, getPosASL _patient, 6, 1, 15];
        sleep 7;
        _medic setVariable [QGVAR(sound), false, true];
    };
};

true;
