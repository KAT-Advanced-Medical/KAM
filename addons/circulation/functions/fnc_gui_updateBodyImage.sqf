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
 * [CONTROL, _target, 0] call kat_circulation_fnc_gui_updateBodyImage
 *
 * Public: No
 */

params ["_ctrlGroup", "_target", "_selectionN"];

private _ctrlAEDPads = _ctrlGroup controlsGroupCtrl IDC_BODY_TORSO_AED_PADS;
private _ctrlAEDVitalsMonitorRight = _ctrlGroup controlsGroupCtrl IDC_BODY_RIGHTARM_AED_VITALS;
private _ctrlAEDVitalsMonitorLeft = _ctrlGroup controlsGroupCtrl IDC_BODY_LEFTARM_AED_VITALS;

if (_target getVariable [QGVAR(DefibrillatorPads_Connected), false]) then {
    _ctrlAEDPads ctrlShow true;
} else {
    _ctrlAEDPads ctrlShow false;
};

if (_target getVariable [QGVAR(AED_X_VitalsMonitor_Connected), false]) then {
    if (((_target getVariable [QGVAR(AED_X_VitalsMonitor_Provider), [objNull, -1, 3]]) select 2) isEqualTo 3) then {
        _ctrlAEDVitalsMonitorRight ctrlShow true;
        _ctrlAEDVitalsMonitorLeft ctrlShow false;
    } else {
        _ctrlAEDVitalsMonitorRight ctrlShow false;
        _ctrlAEDVitalsMonitorLeft ctrlShow true;
    };
} else {
    _ctrlAEDVitalsMonitorRight ctrlShow false;
    _ctrlAEDVitalsMonitorLeft ctrlShow false;
};
