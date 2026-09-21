#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Checks if the target is wearing an oxygen mask (goggles only, not oxygen helmets).
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * Wearing oxygen mask <BOOL>
 *
 * Example:
 * [player] call kat_breathing_fnc_hasOxygenMaskON;
 *
 * Public: No
 */

params ["_target"];

goggles _target in (missionNamespace getVariable [QGVAR(availOxyMaskList), []])
