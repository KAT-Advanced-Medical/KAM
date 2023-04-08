#include "script_component.hpp"
/*
 * Author: Blue
 * Play cough sound.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit] call kat_breathing_fnc_playCough;
 *
 * Public: No
 */

params ["_unit"];

playsound3D [QPATHTOF_SOUND(sounds\pneumothoraxcough.ogg), _unit, false, getPosASL _unit, 5, 1, 15];