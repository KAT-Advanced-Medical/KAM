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
 * [CONTROL, _target, 0] call kat_breathing_fnc_gui_updateBodyImage
 *
 * Public: No
 */

params ["_ctrlGroup", "_target", "_selectionN"];

private _ctrlWoundPack = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_WOUNDPACK;
private _ctrlWoundPackVac = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_WOUNDPACK_VACUUM;
private _ctrlEvisceration = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_EVISCERATION;

diag_log "UPDATEBODYHITPOINTS";
if (_target getVariable [QGVAR(activeWoundPack), 0] == 1) then {
    _ctrlWoundPack ctrlShow true;
} else {
    _ctrlWoundPack ctrlShow false;
};

if (_target getVariable [QGVAR(activeWoundPack), 0] == 2) then {
    _ctrlWoundPackVac ctrlShow true;
} else {
    _ctrlWoundPackVac ctrlShow false;
};

if(_target getVariable [QGVAR(evisceration), 0] > 0) then {
    _ctrlEvisceration ctrlShow true;
} else {
    _ctrlEvisceration ctrlShow false;
};

