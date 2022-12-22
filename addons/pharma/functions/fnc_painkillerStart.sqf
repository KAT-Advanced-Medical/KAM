#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Plays the painiller sound
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "Head"] call kat_pharma_fnc_painkillerStart;
 *
 * Public: No
 */

params ["_medic", "_patient"];

playsound3D [QPATHTOF_SOUND(sounds\take_painkillers.wav), _patient, false, getPosASL _patient, 5, 1, 15];
