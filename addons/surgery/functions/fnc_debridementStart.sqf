#include "script_component.hpp"
/*
 * Author: 1LT.Mazinski.H
 * Generates a vacuum sound for the NPWT dressing
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
 * [player, cursorObject, "LeftLeg"] call kat_surgery_fnc_debridementStart;
 *
 * Public: No
 */

params ["_medic", "_patient"];

playsound3D [QPATHTOF_SOUND(sounds\vacuum.ogg), _patient, false, getPosASL _patient, 8, 1, 15];