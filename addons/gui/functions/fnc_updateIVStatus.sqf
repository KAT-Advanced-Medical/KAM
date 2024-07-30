#include "..\script_component.hpp"
/*
 * Author: Glowbal, kymckay, mharis001
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
 * [CONTROL, _target, 0] call ace_medical_gui_fnc_updateBodyImage
 *
 * Public: No
 */

params ["_ctrlGroup", "_target"];

// Get tourniquets, damage, and blood loss for target
private _IV = _target getVariable [QEGVAR(pharma,IV), [0,0,0,0,0,0]];

{
    _x params ["_coverIDC", "_titleIDC", "_typeIDC", "_subtractIDC", "_valueIDC", "_addIDC", "_bodyPartN"];

    private _activeIV = _IV select _bodyPartN;

    // Show or hide the tourniquet icon
    if (_activeIV == 0) exitWith {
        private _cover = _ctrlGroup displayCtrl _coverIDC;
        private _subtract = _ctrlGroup displayCtrl _subtractIDC;
        private _add = _ctrlGroup displayCtrl _addIDC;
        _cover ctrlShow true;
        _subtract ctrlShow false;
        _add ctrlShow false;
    };

    if (_activeIV != 0) exitWith {
        private _cover = _ctrlGroup displayCtrl _coverIDC;
        private _subtract = _ctrlGroup displayCtrl _subtractIDC;
        private _add = _ctrlGroup displayCtrl _addIDC;
        _cover ctrlShow false;
        _subtract ctrlShow true;
        _add ctrlShow true;
    };
} forEach [
    [IDC_IV_FLOW_HEADCOVER, IDC_IV_FLOW_HEADTITLE, IDC_IV_FLOW_HEADTYPE, IDC_IV_FLOW_HEADSUBTRACT, IDC_IV_FLOW_HEADVALUE, IDC_IV_FLOW_HEADADD, 0],
    [IDC_IV_FLOW_CHESTCOVER, IDC_IV_FLOW_CHESTTITLE, IDC_IV_FLOW_CHESTTYPE, IDC_IV_FLOW_CHESTSUBTRACT, IDC_IV_FLOW_CHESTVALUE, IDC_IV_FLOW_CHESTADD, 1],
    [IDC_IV_FLOW_LARMCOVER, IDC_IV_FLOW_LARMTITLE, IDC_IV_FLOW_LARMTYPE, IDC_IV_FLOW_LARMSUBTRACT, IDC_IV_FLOW_LARMVALUE, IDC_IV_FLOW_LARMADD, 2],
    [IDC_IV_FLOW_RARMCOVER, IDC_IV_FLOW_RARMTITLE, IDC_IV_FLOW_RARMTYPE, IDC_IV_FLOW_RARMSUBTRACT, IDC_IV_FLOW_RARMVALUE, IDC_IV_FLOW_RARMADD, 3],
    [IDC_IV_FLOW_LLEGCOVER, IDC_IV_FLOW_LLEGTITLE, IDC_IV_FLOW_LLEGTYPE, IDC_IV_FLOW_LLEGSUBTRACT, IDC_IV_FLOW_LLEGVALUE, IDC_IV_FLOW_LLEGADD, 4],
    [IDC_IV_FLOW_RLEGCOVER, IDC_IV_FLOW_RLEGTITLE, IDC_IV_FLOW_RLEGTYPE, IDC_IV_FLOW_RLEGSUBTRACT, IDC_IV_FLOW_RLEGVALUE, IDC_IV_FLOW_RLEGADD, 5]
];