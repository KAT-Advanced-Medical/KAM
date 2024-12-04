#include "..\script_component.hpp"
/*
 * Author: Mazinski
 * Detaches personal oxygen mask from player
 * Main function
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_breathing_fnc_detachPersonalOxygen;
 *
 * Public: No
 */

params ["_patient"];

private _maskStatus = _patient getVariable [QGVAR(oxygenMaskStatus), [0,0]];

if ((_maskStatus select 0) > 0) then {
    _patient addMagazine ["kat_personal_oxygen", (_maskStatus select 0)];
};

[LSTRING(PersonalOxygen_Disconnect), 1.5, _patient] call ACEFUNC(common,displayTextStructured);

if ((_maskStatus select 1) != 1) then {
    (_maskStatus select 1) call CBA_fnc_removePerFrameHandler;
};

_patient setVariable [QGVAR(oxygenMaskActive), false, true];
_patient setVariable [QGVAR(oxygenMaskStatus), [0,0], true];