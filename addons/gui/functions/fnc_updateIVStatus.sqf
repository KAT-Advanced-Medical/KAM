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

params ["_target"];

// Get tourniquets, damage, and blood loss for target
private _IV = _target getVariable [QEGVAR(pharma,IV), [0,0,0,0,0,0]];
private _ivFlow = _target getVariable [QEGVAR(pharma,IVflow), [0,0,0,0,0,0]];
private _ivMenuShow = _target getVariable [QEGVAR(pharma,IVmenuActive), false];

if (_ivMenuShow) then {
    ctrlShow [IDC_IV_FLOW_BACKGROUND, true];
    ctrlShow [IDC_IV_FLOW_TITLE, true];
} else {
    ctrlShow [IDC_IV_FLOW_BACKGROUND, false];
    ctrlShow [IDC_IV_FLOW_TITLE, false];
};

{
    _x params ["_coverIDC", "_titleIDC", "_typeIDC", "_valueIDC", "_buttonIDCArray", "_bodyPartN"];

    private _activeIV = _IV select _bodyPartN;
    private _activeFlow = _ivFlow select _bodyPartN;

    if !(_ivMenuShow) then {
        _activeIV = -1;
    };

    switch (true) do {
        case (_activeIV == 0): {
            ctrlShow [_coverIDC, true];
            ctrlShow [_titleIDC, false];
            ctrlShow [_typeIDC, false];
            ctrlShow [_valueIDC, false];
            _buttonIDCArray apply {ctrlShow [_x, false]};
            _buttonIDCArray apply {ctrlEnable [_x, false]};
        };
        case (_activeIV == 1): {
            ctrlShow [_coverIDC, false];
            ctrlShow [_titleIDC, true];
            ctrlShow [_typeIDC, true];
            ctrlShow [_valueIDC, true];
            _buttonIDCArray apply {ctrlShow [_x, true]};
            _buttonIDCArray apply {ctrlEnable [_x, true]};
            ctrlSetText [_typeIDC, "IO"];
            ctrlSetText [_valueIDC, (_activeFlow toFixed 1)];
        };
        case (_activeIV > 1): {
            ctrlShow [_coverIDC, false];
            ctrlShow [_titleIDC, true];
            ctrlShow [_typeIDC, true];
            ctrlShow [_valueIDC, true];
            _buttonIDCArray apply {ctrlShow [_x, true]};
            _buttonIDCArray apply {ctrlEnable [_x, true]};
            ctrlSetText [_typeIDC, "IV"];
            ctrlSetText [_valueIDC, (_activeFlow toFixed 1)];
        };
        case (_activeIV == -1): {
            ctrlShow [_coverIDC, false];
            ctrlShow [_titleIDC, false];
            ctrlShow [_typeIDC, false];
            ctrlShow [_valueIDC, false];
            _buttonIDCArray apply {ctrlShow [_x, false]};
            _buttonIDCArray apply {ctrlEnable [_x, false]};
        };
    };
} forEach [
    [IDC_IV_FLOW_HEADCOVER, IDC_IV_FLOW_HEADTITLE, IDC_IV_FLOW_HEADTYPE, IDC_IV_FLOW_HEADIV_VALUE, [IDC_IV_FLOW_HEADSUBTRACTFULL, IDC_IV_FLOW_HEADSUBTRACT, IDC_IV_FLOW_HEADADD, IDC_IV_FLOW_HEADADDFULL], 0],
    [IDC_IV_FLOW_CHESTCOVER, IDC_IV_FLOW_CHESTTITLE, IDC_IV_FLOW_CHESTTYPE, IDC_IV_FLOW_CHESTTEST, [IDC_IV_FLOW_CHESTSUBTRACTFULL, IDC_IV_FLOW_CHESTSUBTRACT, IDC_IV_FLOW_CHESTADD, IDC_IV_FLOW_CHESTADDFULL], 1],
    [IDC_IV_FLOW_LARMCOVER, IDC_IV_FLOW_LARMTITLE, IDC_IV_FLOW_LARMTYPE, IDC_IV_FLOW_LARMIVVALUE, [IDC_IV_FLOW_LARMSUBTRACTFULL, IDC_IV_FLOW_LARMSUBTRACT, IDC_IV_FLOW_LARMADD, IDC_IV_FLOW_LARMADDFULL], 2],
    [IDC_IV_FLOW_RARMCOVER, IDC_IV_FLOW_RARMTITLE, IDC_IV_FLOW_RARMTYPE, IDC_IV_FLOW_RARMIVVALUE, [IDC_IV_FLOW_RARMSUBTRACTFULL, IDC_IV_FLOW_RARMSUBTRACT, IDC_IV_FLOW_RARMADD, IDC_IV_FLOW_RARMADDFULL], 3],
    [IDC_IV_FLOW_LLEGCOVER, IDC_IV_FLOW_LLEGTITLE, IDC_IV_FLOW_LLEGTYPE, IDC_IV_FLOW_LLEGIVVALUE, [IDC_IV_FLOW_LLEGSUBTRACTFULL, IDC_IV_FLOW_LLEGSUBTRACT, IDC_IV_FLOW_LLEGADD, IDC_IV_FLOW_LLEGADDFULL], 4],
    [IDC_IV_FLOW_RLEGCOVER, IDC_IV_FLOW_RLEGTITLE, IDC_IV_FLOW_RLEGTYPE, IDC_IV_FLOW_RLEGIVVALUE, [IDC_IV_FLOW_RLEGSUBTRACTFULL, IDC_IV_FLOW_RLEGSUBTRACT, IDC_IV_FLOW_RLEGADD, IDC_IV_FLOW_RLEGADDFULL], 5]
];