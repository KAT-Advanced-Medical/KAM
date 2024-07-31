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
private _bloodGasTest = _target getVariable [QEGVAR(circulation,testedBloodGas), [0,0,0,0,0,0]];
private _activeBlood = 0;

{
    _x params ["_watchIDC"];

    _activeBlood = _bloodGasTest select _forEachIndex;

    if (_activeBlood != 0) then {
        ctrlSetText [_watchIDC, (_activeBlood toFixed 2)];
    } else {
        ctrlSetText [_watchIDC, "--.-"];
    };
} forEach [IDC_TEST_PACO2, IDC_TEST_PAO2, IDC_TEST_SPO2, IDC_TEST_HCO3, IDC_TEST_PH];