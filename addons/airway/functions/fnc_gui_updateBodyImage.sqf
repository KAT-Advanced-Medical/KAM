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
 * [CONTROL, _target, 0] call kat_airway_fnc_gui_updateBodyImage
 *
 * Public: No
 */

params ["_ctrlGroup", "_target", "_selectionN"];

private _ctrlGuedelTube = _ctrlGroup controlsGroupCtrl IDC_BODY_HEAD_GUEDELTUBE;
private _ctrlKingLT = _ctrlGroup controlsGroupCtrl IDC_BODY_HEAD_KINGLT;

private _airwayItem = _target getVariable [QGVAR(airway_item), ""];

if !(_airwayItem isEqualTo "") then {
    if (_airwayItem isEqualTo "Larynxtubus") then {
        _ctrlGuedelTube ctrlShow false;
        _ctrlKingLT ctrlShow true;
    } else {
        _ctrlGuedelTube ctrlShow true;
        _ctrlKingLT ctrlShow false;
    };
} else {
    _ctrlGuedelTube ctrlShow false;
    _ctrlKingLT ctrlShow false;
};
