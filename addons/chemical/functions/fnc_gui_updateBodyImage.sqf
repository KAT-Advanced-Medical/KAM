#include "..\script_component.hpp"
/*
 * Author: Blue
 * Updates the body image for given target.
 *
 * Arguments:
 * 0: Body image controls group <CONTROL>
 * 1: Target <OBJECT>
 * 2: Body part <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, _target, 0] call kat_chemical_fnc_gui_updateBodyImage
 *
 * Public: No
 */

params ["_ctrlGroup", "_target", "_selectionN"];

private _ctrlAirInfected = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_I;
if (_target getVariable [QGVAR(airPoisoning), false]) then {
    _ctrlAirInfected ctrlShow true;
} else {
    _ctrlAirInfected ctrlShow false;
};
