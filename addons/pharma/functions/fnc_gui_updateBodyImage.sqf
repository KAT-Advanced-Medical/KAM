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
 * [CONTROL, _target, 0] call kat_pharma_fnc_gui_updateBodyImage
 *
 * Public: No
 */

params ["_ctrlGroup", "_target", "_selectionN"];

private _ctrlIVLeftArm = _ctrlGroup controlsGroupCtrl IDC_BODY_LEFTARM_IV;
private _ctrlIVRightArm = _ctrlGroup controlsGroupCtrl IDC_BODY_RIGHTARM_IV;
private _ctrlIVLeftLeg = _ctrlGroup controlsGroupCtrl IDC_BODY_LEFTLEG_IV;
private _ctrlIVRightLeg = _ctrlGroup controlsGroupCtrl IDC_BODY_RIGHTLEG_IV;
private _ctrlIOLeftArm = _ctrlGroup controlsGroupCtrl IDC_BODY_LEFTARM_IO;
private _ctrlIORightArm = _ctrlGroup controlsGroupCtrl IDC_BODY_RIGHTARM_IO;
private _ctrlIOLeftLeg = _ctrlGroup controlsGroupCtrl IDC_BODY_LEFTLEG_IO;
private _ctrlIORightLeg = _ctrlGroup controlsGroupCtrl IDC_BODY_RIGHTLEG_IO;
private _ctrlIO = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_IO;
private _ctrlEJV = _ctrlGroup controlsGroupCtrl IDC_BODY_NECK_EJV;

private _IVArray = _target getVariable [QGVAR(IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _indicesToCheck = [4, 5, 6, 7, 8, 9, 10, 11];
private _controls = [_ctrlIVLeftArm, _ctrlIOLeftArm, _ctrlIVRightArm, _ctrlIORightArm, _ctrlIOLeftLeg, _ctrlIVLeftLeg, _ctrlIORightLeg, _ctrlIVRightLeg];

{
    private _index = _indicesToCheck select _forEachIndex;
    private _value = _IVArray select _index;

    switch (_value) do {
        case 0: {
            _x ctrlShow false;
        };
        default {
            _x ctrlShow true;
        };
    };
} forEach _controls;

if ((_IVArray select 2) isEqualTo 1) then {
    _ctrlIO ctrlShow true;
} else {
    _ctrlIO ctrlShow false;
};

if ((_IVArray select 1) == 14) then {
    _ctrlEJV ctrlShow true;
} else {
    _ctrlEJV ctrlShow false;
};

