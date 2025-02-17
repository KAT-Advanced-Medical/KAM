#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Removes oxygen mask from player
 * Main function
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_breathing_fnc_removeOxygenMask;
 *
 * Public: No
 */

params ["_medic", "_patient"];

private _maskStatus = _patient getVariable [QGVAR(oxygenMaskStatus), [0,0]];

if ((_maskStatus select 1) > 1) then {
    [_maskStatus select 1] call CBA_fnc_removePerFrameHandler;
};

if ((_maskStatus select 0) > 0) then {
    _patient addMagazine ["kat_personal_oxygen", (_maskStatus select 0)];
};

_patient unassignItem (goggles _patient);
_patient setVariable [QGVAR(oxygenMaskActive), false, true];
_patient setVariable [QGVAR(oxygenMaskStatus), [0,0], true];