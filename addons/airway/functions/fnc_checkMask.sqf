#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks if patient has mask on
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_airway_fnc_checkMask;
 *
 * Public: No
 */

params ["_patient"];

if ((goggles _patient in (missionNamespace getVariable [QEGVAR(chemical,availGasmaskList), []])) || (goggles _patient in (missionNamespace getVariable [QEGVAR(breathing,availOxyMaskList), []]))) exitWith {
    true
};

false