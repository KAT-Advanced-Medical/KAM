#include "..\script_component.hpp"
/*
 * Author: Mazinksi
 * Updates ABG status GUI
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_target] call kat_medical_gui_fnc_updateABGStatus;
 *
 * Public: No
 */

params ["_target"];

// Get tourniquets, damage, and blood loss for target
private _bloodGasTest = _target getVariable [QEGVAR(circulation,testedBloodGas), [0,0,0,0,0,0]];
private _activeBlood = 0;
private _ABGmenuShow = _target getVariable [QEGVAR(pharma,ABGmenuShow), false];

if (_ABGmenuShow) then {
    ctrlShow [IDC_ABG_TITLE, true];
    ctrlShow [IDC_ABG_BACKGROUND, true];
    ctrlShow [IDC_TEST_RESET, true];
} else {
    ctrlShow [IDC_ABG_TITLE, false];
    ctrlShow [IDC_ABG_BACKGROUND, false];
    ctrlShow [IDC_TEST_RESET, false];
};

{
    _x params ["_watchIDC", "_labelIDC"];

    if !(_ABGmenuShow) then {
        ctrlShow [_watchIDC, false];
        ctrlShow [_labelIDC, false];
    } else {
        ctrlShow [_watchIDC, true];
        ctrlShow [_labelIDC, true];
        _activeBlood = _bloodGasTest select _forEachIndex;

        if (_activeBlood != 0) then {
            ctrlSetText [_watchIDC, (_activeBlood toFixed 2)];
        } else {
            ctrlSetText [_watchIDC, "--.-"];
        };
    };

} forEach [
    [IDC_TEST_PACO2, IDC_TEST_PACO2_LABEL],
    [IDC_TEST_PAO2, IDC_TEST_PAO2_LABEL],
    [IDC_TEST_SPO2, IDC_TEST_SPO2_LABEL],
    [IDC_TEST_HCO3, IDC_TEST_HCO3_LABEL],
    [IDC_TEST_PH, IDC_TEST_PH_LABEL]
];
