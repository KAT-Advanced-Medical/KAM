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

private _ctrlPulseOximeterRight = _ctrlGroup controlsGroupCtrl IDC_BODY_RIGHTARM_PULSEOX;
private _ctrlPulseOximeterLeft = _ctrlGroup controlsGroupCtrl IDC_BODY_LEFTARM_PULSEOX;
private _ctrlChestSeal = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_CHESTSEAL;
private _ctrlChestInjury = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_PNEUMOTHORAX;

if (_target getVariable [QGVAR(activeChestSeal), false]) then {
    _ctrlChestSeal ctrlShow true;
} else {
    _ctrlChestSeal ctrlShow false;
};

if (GVAR(PneumothoraxAlwaysVisible)) then {
    if(_target getVariable [QGVAR(pneumothorax), 0] > 0) then {
        _ctrlChestInjury ctrlShow true;
    } else {
        _ctrlChestInjury ctrlShow false;
    };
} else {
    if (_target getVariable [QGVAR(deepPenetratingInjury), false] || (_target getVariable [QGVAR(pneumothorax), 0] > 0)) then {
        _ctrlChestInjury ctrlShow true;
    } else {
        _ctrlChestInjury ctrlShow false;
    };
};

if (_target getVariable [QGVAR(pulseoximeter), false]) then {
    if ((_target getVariable [QGVAR(PulseOximeter_Attached), [0,0]] select 0) > 0) then {
        _ctrlPulseOximeterLeft ctrlShow true;
    } else {
        _ctrlPulseOximeterLeft ctrlShow false;
    };
    if ((_target getVariable [QGVAR(PulseOximeter_Attached), [0,0]] select 1) > 0) then {
        _ctrlPulseOximeterRight ctrlShow true;
    } else {
        _ctrlPulseOximeterRight ctrlShow false;
    };
} else {
    _ctrlPulseOximeterLeft ctrlShow false;
    _ctrlPulseOximeterRight ctrlShow false;
};
