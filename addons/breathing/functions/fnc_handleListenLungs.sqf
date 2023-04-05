#include "script_component.hpp"
/*
 * Author: Blue
 * Handles listening to lungs.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true] call kat_breathing_fnc_handleListenLungs;
 *
 * Public: No
 */

params ["_medic","_listening"];

_medic setVariable [QGVAR(usingStethoscope), _listening, true];