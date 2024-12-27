#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks if patient has an oxygen mask on
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_breathing_fnc_checkOxygenMask;
 *
 * Public: No
 */

params ["_patient"];

if ((goggles _patient in (missionNamespace getVariable [QGVAR(availOxyMaskList), []]))) exitWith {
    true
};

false