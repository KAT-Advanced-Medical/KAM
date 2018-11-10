/*
 * Author: Katalam
 * Plays a sound
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

params ["", "_target"];

playsound3D ["kat_aceAirway\sounds\Suction.wav", _target, false, getPosASL _target, 8, 1, 15];
