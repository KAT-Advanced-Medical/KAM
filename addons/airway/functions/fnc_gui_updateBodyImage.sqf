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
private _ctrlNPA = _ctrlGroup controlsGroupCtrl IDC_BODY_HEAD_NPA;
private _ctrlCrike = _ctrlGroup controlsGroupCtrl IDC_BODY_NECK_CRIKE;

private _airwayItem = _target getVariable [QGVAR(airway_item), ""];

if (_airwayItem isNotEqualTo "") then {
    switch (true) do {
        case (_airwayItem in ["Larynxtubus", "IGEL", "ETT"]): {
            _ctrlGuedelTube ctrlShow false;
            _ctrlNPA ctrlShow false;
            _ctrlKingLT ctrlShow true;
            _ctrlCrike ctrlShow false;
        };
        case (_airwayItem in ["Surgical_Airway"]): {
            _ctrlGuedelTube ctrlShow false;
            _ctrlNPA ctrlShow false;
            _ctrlKingLT ctrlShow false;
            _ctrlCrike ctrlShow true;
        };
        case (_airwayItem in ["NPA"]): {
            _ctrlGuedelTube ctrlShow false;
            _ctrlNPA ctrlShow true;
            _ctrlKingLT ctrlShow false;
            _ctrlCrike ctrlShow false;
        };
        default {
            _ctrlGuedelTube ctrlShow true;
            _ctrlNPA ctrlShow false;
            _ctrlKingLT ctrlShow false;
            _ctrlCrike ctrlShow false;
        };
    };
} else {
    _ctrlGuedelTube ctrlShow false;
    _ctrlKingLT ctrlShow false;
    _ctrlNPA ctrlShow false;
    _ctrlCrike ctrlShow false;
};
